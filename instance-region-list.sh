#####################################################################################################################################################################################################################################Created By Rahul Chandyok##########################################################################################################################################################################################################################################################
echo "Please choose the region number as per the below list to fetch the complete AWS Instance Report"
boxes -d shell -p a1l2 <(echo "1.  US East (N. Virginia)   -> us-east-1
2.  US West (Oregon)        -> us-west-2
3.  US West (N. California) -> us-west-1
4.  EU (Ireland)            -> eu-west-1
5.  EU (Frankfurt)          -> eu-central-1
6.  Asia Pacific (Singapore)-> ap-southeast-1
7.  Asia Pacific (Tokyo)    -> ap-northeast-1
8.  Asia Pacific (Sydney)   -> ap-southeast-2
9.  Asia Pacific (Seoul)    -> ap-northeast-2
10. Asia Pacific (Mumbai)   -> ap-south-1")
read region_number
case $region_number in
1) region=us-east-1
   ;;
2) region=us-west-2
   ;;
3) region=us-west-1
   ;;
4) region=eu-west-1
   ;;
5) region=eu-central-1
   ;;
6) region=ap-southeast-1
   ;;
7) region=ap-northeast-1
   ;;
8) region=ap-southeast-2
   ;;
9) region=ap-northeast-2
   ;;
10) region=ap-south-1
   ;;
*) echo "Please provide the valid Region number to proceed further...Try Again" ;;
esac
#boxes -d shell -p a1l2 <(aws ec2 describe-instances --region $region --output text --query 'Reservations[].Instances[].[Tags[0].Value,InstanceId,PublicIpAddress,PrivateIpAddress,KeyName,SecurityGroups[0].GroupName,Placement.AvailabilityZone, State.Name]' | column -t)
echo -e "Instance_Name\tInstance_ID\tPublic_Key\tPrivate_Key\tKey_Pair_Name\tSecurity_Group\tAvailablity_Zone\tInstance_Current_State" > /home/centos/temp.txt
aws ec2 describe-instances --region $region --output text --query 'Reservations[].Instances[].[Tags[0].Value,InstanceId,PublicIpAddress,PrivateIpAddress,KeyName,SecurityGroups[0].GroupName,Placement.AvailabilityZone, State.Name]' | column -t >> /home/centos/temp.txt
cat temp.txt | column -t >aws_instance_report.txt
echo "PFA" | mailx -s "Complete List of AWS Instance Details of $region Region" -a /home/centos/aws_instance_report.txt rahulchandyok@gmail.com
rm -rf /home/centos/temp.txt
