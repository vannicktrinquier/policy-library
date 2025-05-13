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

package templates.gcp.GCPComputeDisableDefaultServiceAccountV1

import data.validator.gcp.lib as lib

###########################
# Find allowlist/denylist Violations
###########################
deny[{
	"msg": message,
	"details": metadata,
}] {
	constraint := input.constraint
	lib.get_constraint_params(constraint, params)
	asset := input.asset
	asset.asset_type == "compute.googleapis.com/Instance"

	instance := asset.resource.data
	is_default_service_account(instance)

	# Check if instance is in denylist/allowlist
	match_mode := lib.get_default(params, "match_mode", "exact")
	mode := lib.get_default(params, "mode", "allowlist")
	target_instances := lib.get_default(params, "instances", [])
	trace(sprintf("asset name:%v, target_instances: %v, mode: %v, match_mode: %v", [asset.name, target_instances, mode, match_mode]))
	instance_name_targeted(asset.name, target_instances, mode, match_mode)

	message := sprintf("%v is not allowed to use the default service account.", [asset.name])
	metadata := {"resource": asset.name}
}

is_default_service_account(instance) {
	not instance.serviceAccounts
}

is_default_service_account(instance) {
	count(instance.serviceAccounts) == 0
}

is_default_service_account(instance) {
	service_account := lib.get_default(instance.serviceAccounts[0], "email", "")
	regex.match(`^[0-9]+-compute@developer\.gserviceaccount\.com$`, service_account)
}

###########################
# Rule Utilities
###########################
instance_name_targeted(asset_name, instance_filters, mode, match_mode) {
	mode == "allowlist"
	match_mode == "exact"
	matches := {asset_name} & cast_set(instance_filters)
	count(matches) == 0
}

instance_name_targeted(asset_name, instance_filters, mode, match_mode) {
	mode == "denylist"
	match_mode == "exact"
	matches := {asset_name} & cast_set(instance_filters)
	count(matches) > 0
}

instance_name_targeted(asset_name, instance_filters, mode, match_mode) {
	mode == "allowlist"
	match_mode == "regex"
	not re_match_name(asset_name, instance_filters)
}

instance_name_targeted(asset_name, instance_filters, mode, match_mode) {
	mode == "denylist"
	match_mode == "regex"
	re_match_name(asset_name, instance_filters)
}

re_match_name(name, filters) {
	re_match(filters[_], name)
}
