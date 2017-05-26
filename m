From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/8] i2c: refactor core and break out blocks
Date: Fri, 26 May 2017 10:20:51 +0200
Message-ID: <20170526082101.4746-1-wsa@the-dreams.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, linux-acpi@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Yes, I wanted to do this for years now... The I2C core became a huge monolithic
blob getting harder and harder to maintain. This series breaks out some
functional parts into seperate files. This makes the code easier to handle
because of the smaller chunks. It reduces ifdeffery because we can now handle
compilation at the Makefile level. And it helps to spread responsibility, e.g.
the ACPI maintainers do now have a dedicated file listed in MAINTAINERS.

This series was tested with a Renesas Lager board (R-Car H2 SoC). It booted
normally and all device drivers for I2C clients seem to work normally. I wired
two I2C busses together and used i2c-slave-eeprom to let one I2C IP core read
out data from the other. That all worked fine. Buildbot is also happy, it found
two issues of the first (non public) iteration. Thanks!

I did not test ACPI and hope for some assistance here :) I'd also be happy if
people could check the includes of the newly created files, there might be
missing some.

As a result, the main i2c-core file goes down from ~3600 lines to ~2000 lines.
I think this is pretty helpful. I plan to apply this for v4.13 to not block
other core changes. Let's see if we are there yet and the series is ready.
Looking forward to comments.

A branch can be found here:
git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/core-refactor

Kind regards,

   Wolfram


Wolfram Sang (8):
  i2c: rename core source file to allow refactorization
  i2c: break out slave support into seperate file
  i2c: break out smbus support into seperate file
  i2c: break out OF support into seperate file
  i2c: break out ACPI support into seperate file
  docs: i2c: dev-interface: adapt to new filenames of the i2c core
  i2c: remove unneeded includes from core
  i2c: reformat core-base file header

 Documentation/driver-api/i2c.rst            |    5 +-
 Documentation/i2c/dev-interface             |   14 +-
 MAINTAINERS                                 |    1 +
 drivers/i2c/Makefile                        |    7 +-
 drivers/i2c/busses/i2c-designware-core.c    |    2 +-
 drivers/i2c/i2c-core-acpi.c                 |  653 +++++++++++
 drivers/i2c/{i2c-core.c => i2c-core-base.c} | 1681 +--------------------------
 drivers/i2c/i2c-core-of.c                   |  276 +++++
 drivers/i2c/i2c-core-slave.c                |  115 ++
 drivers/i2c/i2c-core-smbus.c                |  594 ++++++++++
 drivers/i2c/i2c-core.h                      |   24 +
 include/trace/events/i2c.h                  |  226 +---
 include/trace/events/smbus.h                |  249 ++++
 13 files changed, 1978 insertions(+), 1869 deletions(-)
 create mode 100644 drivers/i2c/i2c-core-acpi.c
 rename drivers/i2c/{i2c-core.c => i2c-core-base.c} (58%)
 create mode 100644 drivers/i2c/i2c-core-of.c
 create mode 100644 drivers/i2c/i2c-core-slave.c
 create mode 100644 drivers/i2c/i2c-core-smbus.c
 create mode 100644 include/trace/events/smbus.h

-- 
2.11.0

