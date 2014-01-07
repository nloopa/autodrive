#!/usr/bin/env bash
#
# Run xfstests against reiserfs
# Use xfstests at https://github.com/nloopa/xfstests.git
#

losetup /dev/loop0 /home/rwang/test.img
losetup /dev/loop1 /home/rwang/scratch.img

testdir="/home/rwang/testmnt"
scratchdir="/home/rwang/scratchmnt"

export TEST_DEV=/dev/loop0
export TEST_DIR=$testdir
export SCRATCH_DEV=/dev/loop1
export SCRATCH_MNT=$scratchdir

export FSTYP="reiserfs"
mkfs.$FSTYP -f $TEST_DEV
mkfs.$FSTYP -f $SCRATCH_DEV
mount $TEST_DEV $TEST_DIR
mount $SCRATCH_DEV $SCRATCH_MNT

OPTIONS="-X 068"
./check $OPTIONS reiserfs/"[0-9][0-9][0-9]" 

umount /home/rwang/testmnt
umount /home/rwang/scratchmnt
losetup -d /dev/loop0
losetup -d /dev/loop1

