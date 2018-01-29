#!/bin/sh
#
# Force Bourne Shell if not Sun Grid Engine default shell (you never know!)
#
#$ -S /bin/sh
#
# I know I have a directory here so I'll use it as my initial working directory
#
#$ -wd /vol/grid-solar/sgeusers/djp/TuttePolyChapter/data
#
#
# Merge stderr into stdout
#$ -j y
#
# Attempt to rerun aborted jobs
#$ -r y
#
# Resource requests are "hard" constraints and must be provided
#$ -hard
#
# Require AMD62 machines with 2G of memory
#$ -l arch=lx-amd64,mem_free=2000M,ecs_model=9020

NUM_GRAPHS=100
TIMEOUT=180
TUTTE_CMD="/vol/grid-solar/sgeusers/djp/bin/$2"
OPTIONS=$3

# =====================================================
# Tutte HPR Configuration Settings 
# =====================================================

TUTTE_HPR_CACHE_BUCKETS=1M
TUTTE_HPR_FLAGS="-qi --timeout=$TIMEOUT --cache-reset $OPTIONS"

# =====================================================
# Tutte BJ Configuration Settings 
# =====================================================

export LD_LIBRARY_PATH="/vol/grid-solar/sgeusers/djp/libs/"

# =====================================================
# Tutte BHKK Configuration Settings 
# =====================================================

BHKK_CONVERT="/vol/grid-solar/sgeusers/djp/bin/bhkk_convert"

# =====================================================
# Run Commands
# =====================================================

FILE=$(echo $1 | sed -e "s/X/$SGE_TASK_ID/") 

if [ "$2" == "tutte-hpr" ];
then
    # Excute HaggardPearceRoyle Code
    $TUTTE_CMD $TUTTE_HPR_FLAGS --graphs=1:$NUM_GRAPHS $FILE
    #
elif [ "$2" == "tutte-bj" ];
then
    #
    for i in $(seq 1 1 $NUM_GRAPHS)
    do
	sed -n "$i,$i p" $FILE | timeout $TIMEOUT $TUTTE_CMD $OPTIONS
    done
    #
else
    # bhkk
    for i in $(seq 1 1 $NUM_GRAPHS)
    do
	sed -n "$i,$i p" $FILE | $BHKK_CONVERT | timeout $TIMEOUT $TUTTE_CMD $OPTIONS
    done
fi
