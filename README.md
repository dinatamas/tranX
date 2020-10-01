# Original TranX

> Dina Tamás Pál | 2020.09.29.

Run the original TranX in a containerized environment.

## Build from source

1. **System upgrades:** `sudo apt-get update && sudo apt-get upgrade -y`.
1. **Install Docker:**
    * `curl -fsSL https://get.docker.com -o get-docker.sh`.
    * `sudo ./get-docker.sh`
    * `sudo usermod -aG docker $(whoami)`
1. **Install dependencies:** `sudo apt-get install git unzip wget -y`
1. **Clone the repository:** `git clone https://github.com/dinatamas/tranX_original`.
1. **Enter the repository:** `cd tranX_original`.
1. **Load dataset files:** `chmod +x .tranX/pull_data.sh && ./tranX/pull_data.sh`.
1. **Load NLTK data:**
    * `wget https://raw.githubusercontent.com/nltk/nltk_data/gh-pages/packages/tokenizers/punkt.zip`.
    * `mkdir -p nltk_data/tokenizers/`.
    * `unzip punkt.zip -d nltk_data/tokenizers/`.
    * `rm punkt.zip`
1. **Build the docker image:** `docker build -t tranx .`.
1. **Run the container:** `docker run --name tranx --cpus 2.0 -p 8081:8081 -it --rm tranx`.

### Docker cleanup reference

* **Remove all stopped containers:** `docker rm $(docker ps --filter "status=exited" -q)`.
* **Delete all dangling images:** `sudo docker rmi $(sudo docker images -f "dangling=true" -q)`.
* `docker container stop $(docker container ls -aq)`.
* `docker container rm $(docker container ls -aq)`.
* `docker image rm -f $(docker image ls -aq)`.
* `docker system prune -a --volumes`.

## Use TranX and run commands

* **Pickle dataset:** `python ./datasets/conala/dataset.py our`
* **Train on dataset:** `chmod +x ./scripts/our/train.sh && ./scripts/our/train.sh 0`.
* **Test on dataset and model:** `chmod +x ./scripts/our/test.sh && ./scripts/our/test.sh $(ls -dt $PWD/saved_models/our | head -n1)`.
* **Run Flask server:** `python server/app.py --config_file config/server/config_py3.json --model $(ls -dt $PWD/saved_models/our | head -n1)`.

