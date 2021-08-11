#!/bin/bash

while read certificate_arn  ; do
	aws acm describe-certificate --certificate-arn $certificate_arn >> ./result.txt
done < ./list_staging_certificates.txt 
