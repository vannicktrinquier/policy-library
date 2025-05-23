#
# Copyright 2018 Google LLC
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

package templates.gcp.GCPGKERestrictPodTrafficConstraintV2

import data.validator.gcp.lib as lib

deny[{
	"msg": message,
	"details": metadata,
}] {
	constraint := input.constraint
	asset := input.asset
	asset.asset_type == "container.googleapis.com/Cluster"

	container := asset.resource.data
	not check_all_enabled(container)

	message := sprintf("%v doesn't restrict traffic among pods with a network policy.", [asset.name])
	metadata := {"resource": asset.name}
}

###########################
# Rule Utilities
###########################
check_all_enabled(container) {
	network_policy_config_enabled(container) == true
	network_policy_enabled(container) == true
}

network_policy_config_enabled(container) {
	# URL to network policy config:
	# https://cloud.google.com/kubernetes-engine/docs/reference/rest/v1beta1/projects.locations.clusters#Cluster.NetworkPolicyConfig
	addons_config := lib.get_default(container, "addonsConfig", {})
	networkPolicyConfig := lib.get_default(addons_config, "networkPolicyConfig", {})
	network_policy_config_disabled := lib.get_default(networkPolicyConfig, "disabled", false)
	network_policy_config_disabled == false
}

network_policy_enabled(container) = network_policy_enabled {
	# URL to network policy:
	# https://cloud.google.com/kubernetes-engine/docs/reference/rest/v1beta1/projects.locations.clusters#Cluster.NetworkPolicy
	network_policy := lib.get_default(container, "networkPolicy", {})
	network_policy_enabled := lib.get_default(network_policy, "enabled", false)
	network_policy_enabled == true
}
