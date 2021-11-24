package test

import (
	"github.com/gruntwork-io/terratest/modules/gcp"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"os"
	"testing"
)

func TestTerraformBucketExample(t *testing.T) {
	projectId := os.Getenv("PROJECT_ID")

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/bucket",
		Vars: map[string]interface{}{
			"project_id": projectId,
		},
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	bucketName := terraform.Output(t, terraformOptions, "storage_bucket_name")

	gcp.AssertStorageBucketExists(t, bucketName)
}
