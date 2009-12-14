From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c updates for 2.6.33, round 2
Date: Mon, 14 Dec 2009 23:04:20 +0100
Message-ID: <20091214230420.4d586892@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull a second round of i2c subsystem updates for Linux 2.6.33
from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

This consists essentially in the second part of the I2C_CLIENT_INSMOD*
macros removal.

 Documentation/i2c/writing-clients |    2 +-
 drivers/hwmon/adm1021.c           |   11 ++--
 drivers/hwmon/adm1025.c           |   12 ++---
 drivers/hwmon/adm1026.c           |   11 ++---
 drivers/hwmon/adm1029.c           |   14 ++----
 drivers/hwmon/adm1031.c           |    9 ++--
 drivers/hwmon/adm9240.c           |    9 ++--
 drivers/hwmon/ads7828.c           |   13 ++---
 drivers/hwmon/adt7462.c           |   11 ++---
 drivers/hwmon/adt7470.c           |   11 ++---
 drivers/hwmon/adt7473.c           |   11 ++---
 drivers/hwmon/adt7475.c           |    6 +-
 drivers/hwmon/asb100.c            |   11 ++---
 drivers/hwmon/atxp1.c             |   11 ++---
 drivers/hwmon/dme1737.c           |   10 +---
 drivers/hwmon/ds1621.c            |    9 ++--
 drivers/hwmon/f75375s.c           |    9 ++--
 drivers/hwmon/fschmd.c            |    9 ++--
 drivers/hwmon/gl518sm.c           |   11 ++---
 drivers/hwmon/gl520sm.c           |   13 ++----
 drivers/hwmon/lm63.c              |   15 ++----
 drivers/hwmon/lm73.c              |    9 +--
 drivers/hwmon/lm75.c              |   14 ++----
 drivers/hwmon/lm77.c              |   12 ++---
 drivers/hwmon/lm78.c              |    9 ++--
 drivers/hwmon/lm80.c              |   13 ++----
 drivers/hwmon/lm83.c              |   12 ++---
 drivers/hwmon/lm85.c              |   16 +++---
 drivers/hwmon/lm87.c              |   12 ++---
 drivers/hwmon/lm90.c              |   14 ++----
 drivers/hwmon/lm92.c              |    9 +--
 drivers/hwmon/lm93.c              |    8 +--
 drivers/hwmon/lm95241.c           |    9 +--
 drivers/hwmon/max1619.c           |   14 ++----
 drivers/hwmon/max6650.c           |   10 ++--
 drivers/hwmon/pcf8591.c           |    5 +-
 drivers/hwmon/smsc47m192.c        |   11 ++---
 drivers/hwmon/thmc50.c            |    8 ++--
 drivers/hwmon/tmp401.c            |    9 ++--
 drivers/hwmon/tmp421.c            |    7 +--
 drivers/hwmon/w83781d.c           |   10 ++--
 drivers/hwmon/w83791d.c           |    9 ++--
 drivers/hwmon/w83792d.c           |    9 ++--
 drivers/hwmon/w83793.c            |    9 ++--
 drivers/hwmon/w83l785ts.c         |   14 ++----
 drivers/hwmon/w83l786ng.c         |   10 ++--
 drivers/i2c/i2c-core.c            |   52 +++++++++++++++++----
 drivers/misc/eeprom/eeprom.c      |    8 +--
 drivers/misc/ics932s401.c         |   11 ++---
 include/linux/i2c.h               |   92 +-----------------------------------
 50 files changed, 232 insertions(+), 411 deletions(-)

---------------

Jean Delvare (5):
      i2c: Drop the kind parameter from detect callbacks
      i2c: Get rid of struct i2c_client_address_data
      i2c: Drop I2C_CLIENT_INSMOD_1
      i2c: Drop I2C_CLIENT_INSMOD_2 to 8
      i2c: Get rid of I2C_CLIENT_MODULE_PARM

sonic zhang (1):
      i2c-core: i2c bus should support PM entries in struct dev_pm_ops

Thanks,
-- 
Jean Delvare
