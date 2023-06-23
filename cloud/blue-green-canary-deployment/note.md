# Begin canary test
```
terraform apply -var 'traffic_distribution=blue-90'
```

# Verify canary deployment traffic
```
for i in `seq 1 10`; do curl $(terraform output -raw lb_dns_name); done
```

# Increase traffic to green environment
```
terraform apply -var 'traffic_distribution=split'
```
# Verify rolling deployment traffic
```
for i in `seq 1 10`; do curl $(terraform output -raw lb_dns_name); done
```

# Promote green environment
```
terraform apply -var 'traffic_distribution=green'
```

# Verify load balancer traffic
```
for i in `seq 1 5`; do curl $(terraform output -raw lb_dns_name); done
```

# Scale down blue environment
After verifying that your load balancer directs all traffic to your green environment, it is safe to disable the blue environment.

Apply your configuration to destroy the blue environment resources by setting the traffic_distribution variable to green and enable_blue_env to false. Remember to confirm your apply with a yes.
```
terraform apply -var 'traffic_distribution=green' -var 'enable_blue_env=false
```
# Enable new version environment
Apply your configuration to provision the new version of your infrastructure. Remember to confirm your apply with a yes. Set the traffic_distribution variable to green to continue directly all traffic to your current production deployment in the green environment.

```
terraform apply -var 'traffic_distribution=green'
```
# Start shifting traffic to blue environment
Apply your configuration to run a canary test to the blue environment by setting the traffic_distribution variable to green-90. Remember to confirm your apply with a yes.
```
terraform apply -var 'traffic_distribution=green-90'
```
```
for i in `seq 1 10`; do curl $(terraform output -raw lb_dns_name); done
```
# Promote blue environment
```
terraform apply -var 'traffic_distribution=blue'
```
```
for i in `seq 1 5`; do curl $(terraform output -raw lb_dns_name); done
```
# Clean up your infrastructure
```
terraform destroy -var 'traffic_distribution=blue'
```
