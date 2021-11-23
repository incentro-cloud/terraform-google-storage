package test

import (
	"github.com/gruntwork-io/terratest/modules/gcp"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"os"
	"testing"
)

func TestTerraformBucketObjectsIamMembersExample(t *testing.T) {
	projectId := os.Getenv("PROJECT_ID")

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/bucket_objects_iam_members",
		Vars: map[string]interface{}{
			"project_id": projectId,
		},
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	bucketName := terraform.Output(t, terraformOptions, "storage_bucket_name")
	objectName := terraform.Output(t, terraformOptions, "storage_object_name")

	gcp.AssertStorageBucketExists(t, bucketName)
	gcp.ReadBucketObject(t, bucketName, objectName)
}
