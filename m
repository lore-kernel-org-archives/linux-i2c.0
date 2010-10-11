From: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCHv3 0/5] [PATCHv3 0/6] BH1770GLC, SFH7770 and APDS990x als / proximity sensor drivers
Date: Mon, 11 Oct 2010 14:06:44 +0300
Message-ID: <1286795209-12487-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Patch set contains two drivers. One for BH1770GLC / SFH7770 chips and
one for APDS990X chip.

Both drivers have similar sysfs based interface. Both supports
pm_runtime and regulator frame work. There is short documentation
for both drivers.

Unfortunately I can't promise data sheets to public access.

changes since patch set version 3:

- unused variables removed
- several if statements cleaned up (brackets, else if statements)
- bug fix: chip was accessed after powering regulators off
- bug fix: unbalance at runtime-pm enable - disable corrected at module probe
- PAGE_SIZEs removed
- Some duplicate code removed to one function
- documentation updated and typing errors corrected
- platform data documentation moved to header file as kernel-doc format
- bhsfh -> bh1770glc

Tested on top of 2.6.36-rc5

Samu Onkalo (5):
  misc: Driver for bh1770glc / sfh7770 ALS and proximity sensor
  misc: update bh1770glc driver to Kconfig and Makefile
  misc: Driver for APDS990X ALS and proximity sensors
  misc: update apds990x driver to Kconfig and Makefile
  Documentation: Short descriptions for bh1770glc and apds990x drivers

 Documentation/misc-devices/apds990x.txt  |  113 +++
 Documentation/misc-devices/bh1770glc.txt |  118 +++
 drivers/misc/Kconfig                     |   21 +
 drivers/misc/Makefile                    |    2 +
 drivers/misc/apds990x.c                  | 1295 +++++++++++++++++++++++++++
 drivers/misc/bh1770glc.c                 | 1413 ++++++++++++++++++++++++++++++
 include/linux/i2c/apds990x.h             |   79 ++
 include/linux/i2c/bh1770glc.h            |   53 ++
 8 files changed, 3094 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/misc-devices/apds990x.txt
 create mode 100644 Documentation/misc-devices/bh1770glc.txt
 create mode 100644 drivers/misc/apds990x.c
 create mode 100644 drivers/misc/bh1770glc.c
 create mode 100644 include/linux/i2c/apds990x.h
 create mode 100644 include/linux/i2c/bh1770glc.h
