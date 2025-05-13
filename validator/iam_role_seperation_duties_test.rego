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

template_name := "GCPIAMRoleSeparationDutiesV1"

import data.test.fixtures.iam_role_seperation_duties.constraints.iam_role_seperation_duties_kms as fixture_constraint_kms
import data.test.fixtures.iam_role_seperation_duties.constraints.iam_role_seperation_duties_service_account as fixture_constraint_service_account
import data.test.fixtures.iam_role_seperation_duties.constraints.iam_role_seperation_duties_service_account_no_project as fixture_constraint_service_account_no_project

import data.test.fixtures.iam_role_seperation_duties.assets.kms_no_violation as fixture_kms_no_violation
import data.test.fixtures.iam_role_seperation_duties.assets.kms_violation as fixture_kms_violation
import data.test.fixtures.iam_role_seperation_duties.assets.service_account_no_violation as fixture_service_account_no_violation
import data.test.fixtures.iam_role_seperation_duties.assets.service_account_violation as fixture_service_account_violation

import data.validator.test_utils as test_utils

test_iam_role_seperation_duties_service_account_no_project_no_violation {
	test_utils.check_test_violations_count(fixture_service_account_violation, [fixture_constraint_service_account_no_project], template_name, 0)
}

test_iam_role_seperation_duties_service_account_no_violation {
	test_utils.check_test_violations_count(fixture_service_account_no_violation, [fixture_constraint_service_account], template_name, 0)
}

test_iam_role_seperation_duties_service_account_violation {
	expected_resource_names := {"//cloudresourcemanager.googleapis.com/projects/12345"}
	test_utils.check_test_violations_count(fixture_service_account_violation, [fixture_constraint_service_account], template_name, 1)
	test_utils.check_test_violations_resources(fixture_service_account_violation, [fixture_constraint_service_account], template_name, expected_resource_names)
}

test_iam_role_seperation_duties_kms_no_violation {
	test_utils.check_test_violations_count(fixture_kms_no_violation, [fixture_constraint_kms], template_name, 0)
}

test_iam_role_seperation_duties_kms_violation {
	expected_resource_names := {"//cloudresourcemanager.googleapis.com/projects/12345"}
	test_utils.check_test_violations_count(fixture_kms_violation, [fixture_constraint_kms], template_name, 1)
	test_utils.check_test_violations_resources(fixture_kms_violation, [fixture_constraint_kms], template_name, expected_resource_names)
}
