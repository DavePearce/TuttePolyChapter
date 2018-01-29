#!/bin/sh 

# =====================================================
# User Configuration Settings 
# =====================================================

FILE_DIRS[0]="graphs/planar"
FILE_NAMES[0]="planar-graph-vX-n100.dat"
RANGES[0]="10-40:2"

FILE_DIRS[1]="graphs/regular"
FILE_NAMES[1]="reg3vX.dat"
RANGES[1]="10-40:2"

FILE_DIRS[2]="graphs/regular"
FILE_NAMES[2]="reg4vX.dat"
RANGES[2]="10-40:2"

FILE_DIRS[3]="graphs/general"
FILE_NAMES[3]="random-connected-v12-eX.dat"
RANGES[3]="12-66:2"

FILE_DIRS[4]="graphs/general"
FILE_NAMES[4]="random-connected-v14-eX.dat"
RANGES[4]="14-90:2"

FILE_DIRS[5]="graphs/general"
FILE_NAMES[5]="random-connected-v16-eX.dat"
RANGES[5]="16-120:2"

for i in {0..5}; do
    FILE_NAME=${FILE_NAMES[$i]}
    FILE_DIR=${FILE_DIRS[$i]}
    RANGE=${RANGES[$i]}
    # =====================================================
    # Create working directory
    # =====================================================
    JOB_DIR=results/`date +%d%b%y-%H%M`.$FILE_NAME
    mkdir $JOB_DIR
    # =====================================================
    # Experiment 1
    # =====================================================
    #qsub -t $RANGE -o $JOB_DIR qsub.sh $FILE_DIR/$FILE_NAME tutte-hpr
    #qsub -t $RANGE -o $JOB_DIR qsub.sh $FILE_DIR/$FILE_NAME tutte-bj
    #qsub -t $RANGE -o $JOB_DIR qsub.sh $FILE_DIR/$FILE_NAME tutte-bhkk
    # =====================================================
    # Experiment 2
    # =====================================================
    #qsub -t $RANGE -o $JOB_DIR qsub.sh $FILE_DIR/$FILE_NAME tutte-hpr "--cache-size=1536M --cache-buckets=1M"
    #qsub -t $RANGE -o $JOB_DIR qsub.sh $FILE_DIR/$FILE_NAME tutte-hpr "--dense --cache-size=1536M --cache-buckets=1M"
    #qsub -t $RANGE -o $JOB_DIR qsub.sh $FILE_DIR/$FILE_NAME tutte-hpr "--sparse --cache-size=1536M --cache-buckets=1M"
    # =====================================================
    # Experiment 3
    # =====================================================
    qsub -t $RANGE -o $JOB_DIR qsub.sh $FILE_DIR/$FILE_NAME tutte-hpr "--dense --cache-size=256M --cache-buckets=1M"
    qsub -t $RANGE -o $JOB_DIR qsub.sh $FILE_DIR/$FILE_NAME tutte-hpr "--dense --cache-size=512M --cache-buckets=1M"
    qsub -t $RANGE -o $JOB_DIR qsub.sh $FILE_DIR/$FILE_NAME tutte-hpr "--dense --cache-size=768M --cache-buckets=1M"
    qsub -t $RANGE -o $JOB_DIR qsub.sh $FILE_DIR/$FILE_NAME tutte-hpr "--dense --cache-size=1024M --cache-buckets=1M"
    qsub -t $RANGE -o $JOB_DIR qsub.sh $FILE_DIR/$FILE_NAME tutte-hpr "--dense --cache-size=1280M --cache-buckets=1M"
    qsub -t $RANGE -o $JOB_DIR qsub.sh $FILE_DIR/$FILE_NAME tutte-hpr "--dense --cache-size=1536M --cache-buckets=1M"
done

