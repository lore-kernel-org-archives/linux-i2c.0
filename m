From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c updates for 2.6.38
Date: Mon, 10 Jan 2011 22:21:45 +0100
Message-ID: <20110110222145.31c40d8e@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull i2c subsystem updates for Linux 2.6.37 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

Not much this time around... Only the new generic I2C multiplexer using
the GPIO API is worth mentioning.

 Documentation/i2c/muxes/gpio-i2cmux |   65 ++++++++++++
 MAINTAINERS                         |    8 ++
 drivers/i2c/algos/i2c-algo-bit.c    |   31 +++---
 drivers/i2c/busses/i2c-i801.c       |    1 +
 drivers/i2c/busses/i2c-nforce2.c    |    2 +-
 drivers/i2c/i2c-core.c              |   29 +++---
 drivers/i2c/muxes/Kconfig           |   12 +++
 drivers/i2c/muxes/Makefile          |    1 +
 drivers/i2c/muxes/gpio-i2cmux.c     |  184 +++++++++++++++++++++++++++++++++++
 drivers/rtc/rtc-ds1307.c            |   12 +-
 include/linux/gpio-i2cmux.h         |   38 +++++++
 include/linux/i2c.h                 |   27 +++---
 12 files changed, 362 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/i2c/muxes/gpio-i2cmux
 create mode 100644 drivers/i2c/muxes/gpio-i2cmux.c
 create mode 100644 include/linux/gpio-i2cmux.h

---------------

Ben Hutchings (1):
      i2c-i801: Include <linux/slab.h>

Jean Delvare (3):
      i2c-algo-bit: Refactor adapter registration
      i2c-algo-bit: Complain about masters which can't read SCL
      i2c: Constify i2c_client where possible

Joe Perches (1):
      i2c-nforce2: Remove unnecessary cast of pci_get_drvdata

Peter Korsgaard (1):
      i2c: Add generic I2C multiplexer using GPIO API

Thanks,
-- 
Jean Delvare
