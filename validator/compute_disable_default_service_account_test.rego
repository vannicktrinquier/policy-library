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
import data.validator.test_utils as test_utils

# Importing the test data
import data.test.fixtures.compute_disable_default_service_account.assets.compute.instance_no_violation as fixture_compute_instance_no_violation
import data.test.fixtures.compute_disable_default_service_account.assets.compute.instance_violation as fixture_compute_instance_violation
import data.test.fixtures.compute_disable_default_service_account.assets.compute.no_instances as fixture_compute_no_instance

# Importing the test constraint
import data.test.fixtures.compute_disable_default_service_account.constraints.disable_default_service_account_allowlist as fixture_constraint_allowlist
import data.test.fixtures.compute_disable_default_service_account.constraints.disable_default_service_account_default as fixture_constraint_default
import data.test.fixtures.compute_disable_default_service_account.constraints.disable_default_service_account_denylist as fixture_constraint_denylist

template_name := "GCPComputeDisableDefaultServiceAccountV1"

#### Testing for GCE instances using default constraint

#1. No instances at all
test_compute_disable_default_service_account_no_instances {
	test_utils.check_test_violations_count(fixture_compute_no_instance, [fixture_constraint_default], template_name, 0)
}

#2. One instance with custom service account
test_compute_disable_default_service_account_no_violations {
	# expected_resource_names := {"//compute.googleapis.com/projects/test-project/zones/us-east1-c/instances/vm-custom-service-account"}
	test_utils.check_test_violations_count(fixture_compute_instance_no_violation, [fixture_constraint_default], template_name, 0)
}

# #3. Two instance with default service account or empty service account
test_compute_disable_default_service_account_violations {
	expected_resource_names := {"//compute.googleapis.com/projects/test-project/zones/us-east1-c/instances/vm-default-service-account"}
	test_utils.check_test_violations_count(fixture_compute_instance_violation, [fixture_constraint_default], template_name, 1)
	test_utils.check_test_violations_resources(fixture_compute_instance_violation, [fixture_constraint_default], template_name, expected_resource_names)
}

#### Testing for GCE instances using one constraint with allow list compute instance

#1. No instances at all
test_compute_disable_default_service_account_no_instances {
	test_utils.check_test_violations_count(fixture_compute_no_instance, [fixture_constraint_allowlist], template_name, 0)
}

#2. One instance with custom service account
test_compute_disable_default_service_account_no_violations {
	# expected_resource_names := {"//compute.googleapis.com/projects/test-project/zones/us-east1-c/instances/vm-custom-service-account"}
	test_utils.check_test_violations_count(fixture_compute_instance_no_violation, [fixture_constraint_allowlist], template_name, 0)
}

# #3. Two instance with default service account or empty service account
test_compute_disable_default_service_account_violations {
	expected_resource_names := {"//compute.googleapis.com/projects/test-project/zones/us-east1-c/instances/vm-default-service-account"}
	test_utils.check_test_violations_count(fixture_compute_instance_violation, [fixture_constraint_allowlist], template_name, 1)
	test_utils.check_test_violations_resources(fixture_compute_instance_violation, [fixture_constraint_allowlist], template_name, expected_resource_names)
}

#### Testing for GCE instances using one constraint with deny list compute instance

#1. No instances at all
test_compute_disable_default_service_account_no_instances {
	test_utils.check_test_violations_count(fixture_compute_no_instance, [fixture_constraint_denylist], template_name, 0)
}

#2. One instance with custom service account
test_compute_disable_default_service_account_no_violations {
	# expected_resource_names := {"//compute.googleapis.com/projects/test-project/zones/us-east1-c/instances/vm-custom-service-account"}
	test_utils.check_test_violations_count(fixture_compute_instance_no_violation, [fixture_constraint_denylist], template_name, 0)
}

# #3. Two instance with default service account or empty service account
test_compute_disable_default_service_account_violations {
	expected_resource_names := {"//compute.googleapis.com/projects/test-project/zones/us-east1-c/instances/vm-default-service-account"}
	test_utils.check_test_violations_count(fixture_compute_instance_violation, [fixture_constraint_allowlist], template_name, 1)
	test_utils.check_test_violations_resources(fixture_compute_instance_violation, [fixture_constraint_allowlist], template_name, expected_resource_names)
}
