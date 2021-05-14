download_scan_layer () {
  local OUTPUT=$1
	aws lambda get-layer-version-by-arn --arn $OUTPUT --query 'Content.Location' | xargs wget -O ./lambda_layers/$OUTPUT.zip
  unzip ./lambda_layers/$OUTPUT.zip -d ./lambda_layers/$OUTPUT
  if [ -d "./lambda_layers/$OUTPUT" ]; then
    srcclr_scan "./lambda_layers/$OUTPUT"
  fi
}

srcclr_scan () {
  local OUTPUT=$1
  SRCCLR_NO_GIT=1 SRCCLR_NPM_SCOPE=production SRCCLR_NODE_MODULES=true SRCCLR_FAT_JAR=true SRCCLR_BOWER_COMPONENTS=true SRCCLR_NO_DEPENDENCY_GRAPH=true SRCCLR_IGNORED_DLL_DIRS="" SRCCLR_IGNORED_JAR_DIRS="" srcclr scan --recursive --quick $OUTPUT
}

mkdir -p lambda_layers
for run in $(aws lambda list-layers --output text);
do
  if [[ $run == arn:* ]] ;
  then
	  download_scan_layer "$run"
  fi
done

echo "Done processing all AWS lambda layers"
