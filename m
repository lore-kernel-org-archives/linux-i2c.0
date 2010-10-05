From: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/5] BH1770GLC, SFH7770 and APDS990x als / proximity sensor drivers
Date: Tue,  5 Oct 2010 12:42:54 +0300
Message-ID: <1286271779-19819-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Patch set contains two drivers. One for BH1770GLC / SFH7770 chips and
one for APDS990X chip.

Both drivers have similar sysfs based interface. Both supports
pm_runtime and regulator frame work. There is short documentation
for both drivers.

Unfortunately I can't promise data sheets to public access.

Samu Onkalo (5):
  misc: Driver for bh1770glc / sfh7770 ALS and proximity sensor
  misc: update bhsfh driver to Kconfig and Makefile
  misc: Driver for APDS990X ALS and proximity sensors
  misc: update apds990x driver to Kconfig and Makefile
  Documentation: Short descriptions for bhsfh and apds990x drivers

 Documentation/misc-devices/apds990x.txt |  126 +++
 Documentation/misc-devices/bhsfh.txt    |  125 +++
 drivers/misc/Kconfig                    |   21 +
 drivers/misc/Makefile                   |    2 +
 drivers/misc/apds990x.c                 | 1216 ++++++++++++++++++++++++++++
 drivers/misc/bhsfh.c                    | 1324 +++++++++++++++++++++++++++++++
 include/linux/i2c/apds990x.h            |   57 ++
 include/linux/i2c/bhsfh.h               |   42 +
 8 files changed, 2913 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/misc-devices/apds990x.txt
 create mode 100644 Documentation/misc-devices/bhsfh.txt
 create mode 100644 drivers/misc/apds990x.c
 create mode 100644 drivers/misc/bhsfh.c
 create mode 100644 include/linux/i2c/apds990x.h
 create mode 100644 include/linux/i2c/bhsfh.h
