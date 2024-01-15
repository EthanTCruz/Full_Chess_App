#!/bin/bash
sudo su
mkdir Full_Chess
cd ./Full_Chess
sudo apt-get update
sudo apt-get install -y git pip neovim python3-venv python3 tmux
git clone https://github.com/EthanTCruz/Chess_Model.git
cd Chess_Model
git checkout Full_App

# source_dir="./src/model/data/EndgameZips" # Replace with your source directory path

# # Directory to extract files into
# dest_dir="./src/model/data/EndgameTbl" # Replace with your destination directory path

# # Create destination directory if it doesn't exist
# mkdir -p "$dest_dir"

# # Loop through all .zip files in the source directory
# find "$source_dir" -name '*.zip' -exec bash -c ' 
#     unzip -d "$1" "${0}" 
# ' {} "$dest_dir" \;

# echo "Unzipping completed."

base_url="https://tablebase.lichess.ovh/tables/standard/3-4-5/"
target_directory="./src/model/data/EndgameTbl"

# Create the target directory if it doesn't exist
mkdir -p "$target_directory"

# Fetch the page and extract links
links=$(curl -s "$base_url" | grep -oP 'href="\K[^"]*(?=")' | grep -E '\.(rtbw|rtbz)$')

# Download each file
for link in $links; do
    curl -o "${target_directory}/${link##*/}" "${base_url}${link}"
done

cd ..
python3 -m venv chess-model-env
source chess-model-env/bin/activate
pip install -r ./Chess_Model/requirements.txt
cat << 'EOF' > ./your_script.sh
#!/bin/bash
source chess-model-env/bin/activate
export selfTrain=True
export trainModel=True
python Chess_Model/src/model/main.py
EOF
chmod +x ./your_script.sh

tmux new-session -d -s my_session './your_script.sh'
#tmux attach-session -t my_session
