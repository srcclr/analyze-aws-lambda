download_scan_lambda () {
  local OUTPUT=$1
	aws lambda get-function --function-name $OUTPUT --query 'Code.Location' | xargs wget -O ./lambda_functions/$OUTPUT.zip
  unzip ./lambda_functions/$OUTPUT.zip -d ./lambda_functions/$OUTPUT
  if [ -d "./lambda_functions/$OUTPUT" ]; then
    srcclr_scan "./lambda_functions/$OUTPUT"
  fi
}

srcclr_scan () {
  local OUTPUT=$1
  SRCCLR_NO_GIT=1 SRCCLR_NPM_SCOPE=production SRCCLR_NODE_MODULES=true SRCCLR_FAT_JAR=true SRCCLR_BOWER_COMPONENTS=true SRCCLR_NO_DEPENDENCY_GRAPH=true SRCCLR_IGNORED_DLL_DIRS="" SRCCLR_IGNORED_JAR_DIRS="" srcclr scan --recursive --quick $OUTPUT
}

mkdir -p lambda_functions
for run in $(aws lambda list-functions --output text);
do
  if [[ $run == arn:* ]] ;
  then
	  download_scan_lambda "$run"
  fi
done

echo "Done processing all AWS lambda functions"
