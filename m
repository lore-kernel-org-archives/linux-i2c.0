From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c fixes for 2.6.32
Date: Sun, 4 Oct 2009 23:09:43 +0200
Message-ID: <20091004230943.4a18b2f6@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull some more i2c subsystem updates for Linux 2.6.32 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

There are fixes for bugs replicated across many drivers, cleanups
removing obsolete code from random i2c chip drivers, and minor
documentation cleanups.

 Documentation/hwmon/ltc4215                       |    7 +-
 Documentation/hwmon/ltc4245                       |    7 +-
 Documentation/i2c/instantiating-devices           |    2 +-
 Documentation/{i2c/chips => misc-devices}/eeprom  |    0
 Documentation/{i2c/chips => misc-devices}/max6875 |    6 +-
 Documentation/w1/masters/ds2482                   |    6 +-
 drivers/hwmon/ltc4215.c                           |   47 +-------
 drivers/hwmon/ltc4245.c                           |  131 +--------------------
 drivers/i2c/busses/i2c-amd756.c                   |    2 +-
 drivers/i2c/busses/i2c-amd8111.c                  |    4 +-
 drivers/i2c/busses/i2c-i801.c                     |    4 +-
 drivers/i2c/busses/i2c-isch.c                     |    2 +-
 drivers/i2c/busses/i2c-piix4.c                    |    4 +-
 drivers/i2c/busses/i2c-sis96x.c                   |    2 +-
 drivers/i2c/busses/i2c-viapro.c                   |    2 +-
 drivers/leds/leds-pca9532.c                       |    3 -
 drivers/macintosh/therm_adt746x.c                 |    4 +-
 drivers/macintosh/therm_pm72.c                    |    4 +-
 drivers/macintosh/windfarm_lm75_sensor.c          |    4 +-
 drivers/macintosh/windfarm_max6690_sensor.c       |    4 +-
 drivers/macintosh/windfarm_smu_sat.c              |    4 +-
 drivers/mfd/ab3100-core.c                         |    4 +-
 drivers/misc/eeprom/max6875.c                     |   29 +----
 drivers/staging/iio/light/tsl2561.c               |    4 -
 drivers/w1/masters/ds2482.c                       |   35 +-----
 25 files changed, 64 insertions(+), 257 deletions(-)
 rename Documentation/{i2c/chips => misc-devices}/eeprom (100%)
 rename Documentation/{i2c/chips => misc-devices}/max6875 (94%)

---------------

Jean Delvare (10):
      i2c: Move misc devices documentation
      max6875: Discard obsolete detect method
      ds2482: Discard obsolete detect method
      ltc4215/ltc4245: Discard obsolete detect methods
      leds: leds-pca9532 - Drop unused module parameters
      Staging: IIO: tsl2561: Drop unused module parameters
      mfd: AB3100 drop unused module parameters
      i2c: Minor documentation update
      i2c: Hide probe errors caused by ACPI resource conflicts
      macintosh: Don't assume i2c device probing always succeeds

Thanks,
-- 
Jean Delvare
