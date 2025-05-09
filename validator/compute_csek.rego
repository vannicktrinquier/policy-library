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

package templates.gcp.GCPComputeRequireCSEKEncryptionConstraintV1

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
	disks := lib.get_default(instance, "disk", [])
	disk := disks[_]
	not is_using_csek(disk)

	# Check if instance is in denylist/allowlist
	target_instances := lib.get_default(params, "instances", [])
	trace(sprintf("asset name:%v, target_instances: %v", [asset.name, target_instances]))
	instance_name_targeted(asset.name, target_instances)

	message := sprintf("%v is required  to use Customer Supplied Customer Key.", [asset.name])
	metadata := {"resource": asset.name}
}

is_using_csek(disk) {
	csek := lib.get_default(disk.diskEncryptionKey, "rawKey", "")
	csek != ""
}

###########################
# Rule Utilities
###########################
instance_name_targeted(asset_name, instance_filters) {
	matches := {asset_name} & cast_set(instance_filters)
	count(matches) > 0
}
