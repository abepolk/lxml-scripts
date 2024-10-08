# To be sourced, not sh'ed

# Builds lxml and its dependences statically on a GCP Debian VM,
# and opens an interactive Python session where you can use lxml in-place

sudo apt install build-essential gcc git python3-dev python3-venv -y
python3 -m venv venv
source venv/bin/activate
git clone https://github.com/lxml/lxml.git
cd lxml/
pip3 install -r requirements.txt
env CFLAGS="-fPIC" python3 setup.py build_ext -i --with-cython --static-deps
PYTHONPATH=src python3