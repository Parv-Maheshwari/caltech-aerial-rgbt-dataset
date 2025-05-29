#!/bin/bash

THERMAL_CSV=_boson_thermal_image_raw
COLOR_CSV=_eo_color_image_color_compressed
MONO_CSV=_eo_mono_image_mono_compressed

DATA_PATH=/ocean/projects/cis220039p/mdt2/shared/CART/bag_files
OUTPUT_DIR=/ocean/projects/cis220039p/mdt2/shared/CART/bag_files

for TRAJECTORY_PATH in ${DATA_PATH}/*/images/eo/color; do
    TRAJECTORY=$(basename $(dirname $(dirname $(dirname "$TRAJECTORY_PATH"))))
    OUTPUT_TRAJ_DIR=${OUTPUT_DIR}/${TRAJECTORY}/stereo_rectified

    if [ -d "$OUTPUT_TRAJ_DIR" ]; then
        echo "Skipping ${TRAJECTORY} as stereo_rectified folder already exists."
        continue
    fi

    echo "Processing trajectory: ${TRAJECTORY} ${TRAJECTORY_PATH}"
    python3 stereo_rectify.py \
        --data_dir ${DATA_PATH}/${TRAJECTORY} \
        --thermal_csv ${THERMAL_CSV}.csv \
        --color_csv ${COLOR_CSV}.csv \
        --mono_csv ${MONO_CSV}.csv \
        --output_dir ${OUTPUT_TRAJ_DIR}
    # --rotate180
done
