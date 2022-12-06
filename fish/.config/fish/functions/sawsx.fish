function sawsx -d 'sawsx alias for exporting code artifact vars after authenticating with saws alias'
  export CODEARTIFACT_AUTH_TOKEN=$(aws codeartifact get-authorization-token --domain enterprise --domain-owner 877812532776 --region us-east-1 --query authorizationToken --output text --profile sxm-platform-eng-cicd-prod )
  export CODEARTIFACT_URL="https://enterprise-877812532776.d.codeartifact.us-east-1.amazonaws.com/npm/platform-eng-cicd" 
  export CODEARTIFACT_REPO_NAME="platform-eng-cicd"
  aws codeartifact login --tool npm --region us-east-1 --domain enterprise --domain-owner 877812532776 --repository platform-eng-cicd --profile sxm-platform-eng-cicd-prod
  $argv
end
