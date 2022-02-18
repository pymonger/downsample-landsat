# downsample-landsat
Example CWL workflow calling a papermilled notebook.

## Prerequisites

1. Clone repo:
   ```
   cd /tmp
   git clone https://github.com/pymonger/downsample-landsat.git
   cd downsample-landsat
   ```
1. Create virtualenv:
   ```
   virtualenv env
   source env/bin/activate
   ```
1. Install `cwltool`:
   ```
   pip install cwltool
   ```

## Building Container Image
```
git clone https://github.com/pymonger/downsample-landsat.git
cd downsample-landsat
docker build --rm --force-rm -t pymonger/downsample-landsat:latest -f Dockerfile .
```
