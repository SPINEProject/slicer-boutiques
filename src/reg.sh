#!/bin/sh

# inputs
pre=$1
post=$2
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/slicer/lib/Slicer-4.8/cli-modules/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/slicer/lib/Slicer-4.8/
# Prepare inputs
mkdir /tmp/input
mkdir /tmp/output
mkdir /tmp/pre
cd /tmp/pre
tar -xvzf "$pre"
/src/dcm2niix -f pre -o /tmp/input/ /tmp/pre
mkdir /tmp/post
cd /tmp/post
tar -xvzf "$post"
/src/dcm2niix -f post -o /tmp/input/ /tmp/post

/opt/slicer/lib/Slicer-4.8/cli-modules/BRAINSFit --fixedVolume /tmp/input/pre.nii --movingVolume /tmp/input/post.nii   --useRigid --outputVolume "/output/output.nii.gz" --outputTransform "/output/transform.hdf5" --initializeTransformMode useGeometryAlign --samplingPercentage 0.1
