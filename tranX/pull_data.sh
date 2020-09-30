#!/bin/bash

echo "download dataset"
data_file="tranx.0.2.1.zip"
wget -c http://dinatamas.web.elte.hu/${data_file}
unzip ${data_file}
rm ${data_file}

data_file="our.zip"
wget -c http://dinatamas.web.elte.hu/${data_file}
unzip ${data_file}
rm ${data_file}

for dataset in django geo atis jobs wikisql conala our;
do
	mkdir -p saved_models/${dataset}
	mkdir -p logs/${dataset}
	mkdir -p decodes/${dataset}
done

echo "Done!"
