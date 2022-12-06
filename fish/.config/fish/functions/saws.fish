function saws -d 'saws alias for authenticating with SiriusXM AWS'
  java -jar ~/Code/SiriusXM/aws-cli/onelogin-aws-cli.jar --username jason.job@siriusxm.com --appid 1853592 --subdomain pandora --region us-east-1 --aws-account-id 790603163548 --aws-role-name SAML-PowerUser --profile 'profile sxm-platform-eng-cicd-prod'
  export AWS_PROFILE="sxm-platform-eng-cicd-prod"
  $argv
end
