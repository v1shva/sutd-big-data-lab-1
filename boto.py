import boto3
session = boto3.session.Session(aws_access_key_id='', aws_secret_access_key='', aws_session_token='', region_name='')
ec2 = session.resource('ec2')
# create a new EC2 instance
instances = ec2.create_instances(
     ImageId='ami-06b263d6ceff0b3dd',
     MinCount=1,
     MaxCount=1,
     InstanceType='t2.micro',
     KeyName='test-vm'
 )
