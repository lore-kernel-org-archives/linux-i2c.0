From: Samu Onkalo <samu.p.onkalo@nokia.com>
Subject: [PATCH 0/4] Led driver support for LP5521 and LP5523 chips
Date: Thu, 16 Sep 2010 13:12:22 +0300
Message-ID: <1284631946-5350-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rpurdie@linux.intel.com
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Patch set provides support for LP5521 and LP5523 LED driver chips
from National Semicondutor. Both drivers supports programmable engines
and naturally LED class features.

Documentation is provided as a part of the patch set.
I created "leds" sub directory to Documentation.
Perhaps rest of the leds* documentation should be moved
there.

Datasheets are freely available at National Semiconductor www pages.

Tested to work in top of 2.6.36-RC4 kernel.

Samu Onkalo (4):
  leds: driver for National Semiconductor LP5521 chip
  leds: Driver for National Semiconductors LP5523 chip
  leds: Update LP552x support Kconfig and Makefile
  Documentation: led drivers lp5521 and lp5523

 Documentation/leds/leds-lp5521.txt |   85 +++
 Documentation/leds/leds-lp5523.txt |   81 +++
 drivers/leds/Kconfig               |   18 +
 drivers/leds/Makefile              |    2 +
 drivers/leds/leds-lp5521.c         |  820 +++++++++++++++++++++++++++
 drivers/leds/leds-lp5523.c         | 1063 ++++++++++++++++++++++++++++++++++++
 include/linux/leds-lp5521.h        |   46 ++
 include/linux/leds-lp5523.h        |   46 ++
 8 files changed, 2161 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/leds/leds-lp5521.txt
 create mode 100644 Documentation/leds/leds-lp5523.txt
 create mode 100644 drivers/leds/leds-lp5521.c
 create mode 100644 drivers/leds/leds-lp5523.c
 create mode 100644 include/linux/leds-lp5521.h
 create mode 100644 include/linux/leds-lp5523.h
