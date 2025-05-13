#
# Copyright 2025 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package templates.gcp.GCPIAMRoleSeparationDutiesV1

import data.validator.gcp.lib as lib

deny[{
	"msg": message,
	"details": metadata,
}] {
	constraint := input.constraint
	lib.get_constraint_params(constraint, params)
	asset := input.asset

	asset_types := params.assetTypes
	exclusive_roles := params.roles

	input.asset.asset_type == asset_types[_]
	bindings := asset.iam_policy.bindings

	some i, j
	member_name := bindings[i].members[j]
	not startswith(member_name, "serviceAccount:")
	roles_for_member := {role |
		b := bindings[_]
		member_name == b.members[_]
		role := b.role
	}
	exclusive_roles_bound(params.roles, roles_for_member)
	message := sprintf("Expected IAM separation of duties for resource %v, roles %v and member %v", [asset.name, exclusive_roles, member_name])
	metadata := {"resource": asset.name}
}

###########################
# Rule Utilities
###########################
exclusive_roles_bound(exclusive_roles, roles_for_member) {
	matches := cast_set(exclusive_roles) & cast_set(roles_for_member)
	count(matches) == count(exclusive_roles)
}
