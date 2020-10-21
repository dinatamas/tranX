# Original TranX

> Dina Tamás Pál | 2020.09.29.

Run the original TranX in a containerized environment.

## Use TranX and run commands

* **Pickle dataset:** `python ./datasets/conala/dataset.py our`.
* **Train on dataset:** `chmod +x ./scripts/our/train.sh && ./scripts/our/train.sh 0`.
* **Test on dataset and model:** `chmod +x ./scripts/our/test.sh && ./scripts/our/test.sh $(ls -dt $PWD/saved_models/our | head -n1)`.
* **Run Flask server:** `python server/app.py --config_file config/server/config_py3.json --model $(ls -dt $PWD/saved_models/our | head -n1)`.

## Build from source | Linux

1. **System upgrades:** `sudo apt-get update && sudo apt-get upgrade -y`.
1. **Install Docker:**
    * `curl -fsSL https://get.docker.com -o get-docker.sh`.
    * `sudo ./get-docker.sh`
    * `sudo usermod -aG docker $(whoami)`
1. **Install dependencies:** `sudo apt-get install git unzip wget -y`.
1. **Clone the repository:** `git clone https://github.com/dinatamas/tranX_original`.
1. **Enter the repository:** `cd tranX_original`.
1. **Load dataset files:** `pushd tranX && chmod +x ./pull_data.sh && ./pull_data.sh && popd`.
1. **Load NLTK data:**
    * `wget https://raw.githubusercontent.com/nltk/nltk_data/gh-pages/packages/tokenizers/punkt.zip`.
    * `mkdir -p nltk_data/tokenizers/`.
    * `unzip punkt.zip -d nltk_data/tokenizers/`.
    * `rm punkt.zip`.
1. **Build the docker image:** `docker build -t tranx_original .`.
1. **Run the container:** `docker run --name tranx_original --cpus 2.0 -p 8081:8081 -it -d tranx_original:latest`.
1. **Enter the container's shell:** `docker exec tranx_original -it /bin/bash`.

## Build from the source | Windows

_Another option is to use the Windows Subsytem for Linux._

1. **System upgrades:** Use Windows Update to manually install updates.
1. **Install Docker:**
    * Install on Windows Home: [Guide](https://docs.docker.com/docker-for-windows/install-windows-home/)
    * Install on Windows Pro/Enterprise/Education: [Guide](https://docs.docker.com/docker-for-windows/install/)
1. **Get the repository:** 
    * Download https://github.com/dinatamas/tranX_original/archive/master.zip
    * Unzip the contents of the compressed archive.
    * Enter the tranx_original-master\tranX folder.
1. **Prepare the datasets:**
    * Download and unzip the dataset archives.
      _The contents should automatically be extracted to `.\data\{dataset}\`_
        * http://dinatamas.web.elte.hu/tranx.0.2.1.zip
        * http://dinatamas.web.elte.hu/conala-corpus-v1.1.zip
        * http://dinatamas.web.elte.hu/our.zip
    * Create the following folders:
        * `.\saved_models\{dataset}\`, `.\logs\{dataset}\`, `.\decodes\{dataset}\`
          for every dataset: `django, geo, atis, jobs, wikisql, conala, our`
    * Create an empty `.\data\atis\iata.txt` file.
1. **Load NLTK data:**
    * Download https://raw.githubusercontent.com/nltk/nltk_data/gh-pages/packages/tokenizers/punkt.zip
    * Unzip the contents of this archive to `.\nltk_data\tokenizers\`.
1. **Build the docker image:** `docker build -t tranx_original .`.
1. **Run the container:** `docker run --name tranx_original --cpus 2.0 -p 8081:8081 -it -d tranx_original:latest`.
1. **Enter the container's shell:** `docker exec tranx_original -it /bin/bash`.

## Docker cleanup reference

* **Remove all stopped containers:** `docker rm $(docker ps --filter "status=exited" -q)`.
* **Delete all dangling images:** `sudo docker rmi $(sudo docker images -f "dangling=true" -q)`.
* `docker container stop $(docker container ls -aq)`.
* `docker container rm $(docker container ls -aq)`.
* `docker image rm -f $(docker image ls -aq)`.
* `docker system prune -a --volumes`.
