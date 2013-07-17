From: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Subject: [PATCH v3 0/4] iMC SMBUS, TSOD hwmon devices, and eeprom modalias
Date: Wed, 17 Jul 2013 13:53:04 -0700
Message-ID: <cover.1374093761.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Intel LGA2011 machines have dedicated SMBUS controllers for DIMM socket=
s.  Because they're dedicated, they can be safely and accurately probed=
, since all devices on them are known to be attached to DIMMs.  The dev=
ices found are:
 - SPD EEPROMs
 - TSODs (Temperature Sensor on DIMMs), a JEDEC standard device
 - Other interesting things, with drivers hopefully to follow...

This patch series adds a simple generic layer for probing for DIMMs ove=
r
SMBUS, an i2c bus driver for the iMC controller found on Intel LGA2011
chips, and a modalias for the eeprom driver so it can be automatically
loaded.

I've tested this on a Core i7 Extreme and on a Xeon E5 server.
With this series applied, sensors shows (on the Xeon E5):

TSOD-i2c-1-18
Adapter: iMC socket 0 channel 0
DIMM Temperature:  +35.2=C2=B0C =20

TSOD-i2c-1-1c
Adapter: iMC socket 0 channel 0
DIMM Temperature:  +33.0=C2=B0C =20

TSOD-i2c-3-18
Adapter: iMC socket 1 channel 0
DIMM Temperature:  +34.0=C2=B0C =20

TSOD-i2c-3-1c
Adapter: iMC socket 1 channel 0
DIMM Temperature:  +27.2=C2=B0C=20

with no need for any userspace probing or manual module loading.
decode-dimms works on both machines, again without any manual module
loading.

The whole series is available on git here (against v3.9.7):
https://git.kernel.org/cgit/linux/kernel/git/luto/linux.git/log/?h=3Di2=
c_imc/patch_v3

Changes from earlier versions:
 - Dropped changes to core I2C_CLASS_SPD probing
 - Cleanup up i2c_imc driver
 - Added dimm-bus, tsod driver, and eeprom modalias

Andy Lutomirski (4):
  i2c: Add DIMM bus code
  i2c_imc: New driver for Intel's iMC, found on LGA2011 chips
  tsod: New hwmon driver for Temperature Sensors on DIMM
  eeprom: Add a MODULE_DEVICE_TABLE

 drivers/hwmon/Kconfig         |  10 +
 drivers/hwmon/Makefile        |   1 +
 drivers/hwmon/tsod.c          | 195 +++++++++++++++
 drivers/i2c/busses/Kconfig    |  19 ++
 drivers/i2c/busses/Makefile   |   5 +
 drivers/i2c/busses/dimm-bus.c |  84 +++++++
 drivers/i2c/busses/i2c-imc.c  | 548 ++++++++++++++++++++++++++++++++++=
++++++++
 drivers/misc/eeprom/eeprom.c  |   1 +
 include/linux/i2c/dimm-bus.h  |  24 ++
 9 files changed, 887 insertions(+)
 create mode 100644 drivers/hwmon/tsod.c
 create mode 100644 drivers/i2c/busses/dimm-bus.c
 create mode 100644 drivers/i2c/busses/i2c-imc.c
 create mode 100644 include/linux/i2c/dimm-bus.h

--=20
1.8.1.4
