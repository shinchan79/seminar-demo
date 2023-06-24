# Blue/green deployments on ECS Fargate with Codepipeline - Examples

An example about deploying a Nginx web server on ECS Fargate with blue/green strategy.

More info here:
- [Blue/green deployment of a web server on ECS Fargate](https://letsmake.cloud/bluegreen-fargate)

Put to codecommit repo files in codedeploy and codebuild folder, remember to change "<TASK_DEFINITION_ARN:revision>" to real value (output of terraform) and account id, region in taskdef.json