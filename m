From: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCHv2 0/4] Led driver support for LP5521 and LP5523 chips
Date: Wed, 29 Sep 2010 12:10:01 +0300
Message-ID: <1285751405-22039-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rpurdie-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Changes in v2 patch set:
- Documentation corrections
- Coding style corrections
- 5521 selftest return value handling changed
- check against illegal channel number value in platform data

Original cover-letter:

Patch set provides support for LP5521 and LP5523 LED driver chips
from National Semicondutor. Both drivers supports programmable engines
and naturally LED class features.

Documentation is provided as a part of the patch set.
I created "leds" sub directory to Documentation.
Perhaps rest of the leds* documentation should be moved
there.

Datasheets are freely available at National Semiconductor www pages.

Tested to work in top of 2.6.36-RC5 kernel.

Samu Onkalo (4):
  leds: driver for National Semiconductor LP5521 chip
  leds: Driver for National Semiconductors LP5523 chip
  leds: Update LP552x support Kconfig and Makefile
  Documentation: led drivers lp5521 and lp5523

 Documentation/leds/leds-lp5521.txt |   88 +++
 Documentation/leds/leds-lp5523.txt |   84 +++
 drivers/leds/Kconfig               |   18 +
 drivers/leds/Makefile              |    2 +
 drivers/leds/leds-lp5521.c         |  821 +++++++++++++++++++++++++++
 drivers/leds/leds-lp5523.c         | 1065 ++++++++++++++++++++++++++++++++++++
 include/linux/leds-lp5521.h        |   48 ++
 include/linux/leds-lp5523.h        |   48 ++
 8 files changed, 2174 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/leds/leds-lp5521.txt
 create mode 100644 Documentation/leds/leds-lp5523.txt
 create mode 100644 drivers/leds/leds-lp5521.c
 create mode 100644 drivers/leds/leds-lp5523.c
 create mode 100644 include/linux/leds-lp5521.h
 create mode 100644 include/linux/leds-lp5523.h
