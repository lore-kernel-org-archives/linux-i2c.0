From: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Subject: [PATCH v4 0/2] iMC SMBUS and DIMM bus probing
Date: Thu, 18 Jul 2013 11:36:52 -0700
Message-ID: <cover.1374171757.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Intel LGA2011 machines have dedicated SMBUS controllers for DIMM
sockets.  Because they're dedicated, they can be safely and accurately
probed, since all devices on them are known to be attached to DIMMs.
The devices found are:
 - SPD EEPROMs
 - TSODs (Temperature Sensor on DIMMs)
 - Other interesting things, with drivers hopefully to follow...

This patch series adds a simple generic layer for probing for DIMMs ove=
r
SMBUS and an i2c bus driver for the iMC controller found on Intel
LGA2011 chips.

It now uses only modern infrastructure -- new-style I2C probing and the
at24 (instead of eeprom) driver.

I've tested this on a Core i7 Extreme and on a Xeon E5 server.
With this series applied, sensors shows (on the Xeon E5):

jc42-i2c-1-18
Adapter: iMC socket 0 channel 0
temp1:        +33.0=C2=B0C  (low  =3D  +0.0=C2=B0C)                  AL=
ARM (HIGH)
                       (high =3D  +0.0=C2=B0C, hyst =3D  +0.0=C2=B0C)
                       (crit =3D +100.0=C2=B0C, hyst =3D +100.0=C2=B0C)

jc42-i2c-1-1c
Adapter: iMC socket 0 channel 0
temp1:        +35.2=C2=B0C  (low  =3D  +0.0=C2=B0C)                  AL=
ARM (HIGH)
                       (high =3D  +0.0=C2=B0C, hyst =3D  +0.0=C2=B0C)
                       (crit =3D +100.0=C2=B0C, hyst =3D +100.0=C2=B0C)

jc42-i2c-3-18
Adapter: iMC socket 1 channel 0
temp1:        +27.0=C2=B0C  (low  =3D  +0.0=C2=B0C)                  AL=
ARM (HIGH)
                       (high =3D  +0.0=C2=B0C, hyst =3D  +0.0=C2=B0C)
                       (crit =3D +100.0=C2=B0C, hyst =3D +100.0=C2=B0C)

jc42-i2c-3-1c
Adapter: iMC socket 1 channel 0
temp1:        +33.2=C2=B0C  (low  =3D  +0.0=C2=B0C)                  AL=
ARM (HIGH)
                       (high =3D  +0.0=C2=B0C, hyst =3D  +0.0=C2=B0C)
                       (crit =3D +100.0=C2=B0C, hyst =3D +100.0=C2=B0C)

with no need for any userspace probing or manual module loading.
decode-dimms works on both machines, again without any manual module
loading.

The whole series is available on git here (against v3.9.7):
https://git.kernel.org/cgit/linux/kernel/git/luto/linux.git/log/?h=3Di2=
c_imc/patch_v4

I'm not entirely attached the to the probing approach in patch 1 -- see
comments there.

Changes from v3:
 - Dropped redundant "tsod" driver
 - Dropped eeprom modalias
 - Switched to probing for the "eeprom" and "jc42"

Andy Lutomirski (2):
  i2c: Add DIMM bus code
  i2c_imc: New driver for Intel's iMC, found on LGA2011 chips

 drivers/i2c/busses/Kconfig    |  19 ++
 drivers/i2c/busses/Makefile   |   5 +
 drivers/i2c/busses/dimm-bus.c |  97 ++++++++
 drivers/i2c/busses/i2c-imc.c  | 548 ++++++++++++++++++++++++++++++++++=
++++++++
 include/linux/i2c/dimm-bus.h  |  24 ++
 5 files changed, 693 insertions(+)
 create mode 100644 drivers/i2c/busses/dimm-bus.c
 create mode 100644 drivers/i2c/busses/i2c-imc.c
 create mode 100644 include/linux/i2c/dimm-bus.h

--=20
1.8.1.4
