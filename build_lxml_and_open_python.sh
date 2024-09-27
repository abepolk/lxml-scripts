# Builds lxml and its dependences on a GCP Debian VM,
# and opens an interactive Python session where you can use lxml in-place

sudo apt install autoconf build-essential gcc git libtool pkg-config python3-dev python3-venv -y
python3 -m venv venv
source venv/bin/activate
git clone https://gitlab.gnome.org/GNOME/libxml2.git
cd libxml2/
./autogen.sh
make
sudo make install
cd ..
git clone https://gitlab.gnome.org/GNOME/libxslt.git
cd libxslt/
./autogen.sh
make
sudo make install
cd ..
git clone https://github.com/lxml/lxml.git
cd lxml/
pip3 install -r requirements.txt
python3 setup.py build_ext -i --with-cython --with-xml2-config=$HOME/libxml2/xml2-config --with-xslt-config=$HOME/libxslt/xslt-config
PYTHONPATH=src LD_LIBRARY_PATH=/usr/local/lib python3