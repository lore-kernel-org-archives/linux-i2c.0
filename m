From: eajames.ibm@gmail.com
Subject: [PATCH linux 0/6] drivers: hwmon: Add On-Chip Controller driver
Date: Fri, 30 Dec 2016 11:56:02 -0600
Message-ID: <1483120568-21082-1-git-send-email-eajames.ibm@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux@roeck-us.net
Cc: jdelvare@suse.com, corbet@lwn.net, mark.rutland@arm.com, robh+dt@kernel.org, wsa@the-dreams.de, andrew@aj.id.au, joel@jms.id.au, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, "Edward A. James" <eajames@us.ibm.com>
List-Id: linux-i2c@vger.kernel.org

From: "Edward A. James" <eajames@us.ibm.com>

This patchset adds a hwmon driver to support the OCC (On-Chip Controller)
on the IBM POWER8 and POWER9 processors, from a BMC (Baseboard Management
Controller). The OCC is an embedded processor that provides real time
power and thermal monitoring.

The driver provides an interface on a BMC to poll OCC sensor data, set
user power caps, and perform some basic OCC error handling. It interfaces
with userspace through hwmon.

The driver is currently functional only for the OCC on POWER8 chips.
Communicating with the POWER9 OCC requries FSI support.

Edward A. James (6):
  hwmon: Add core On-Chip Controller support for POWER CPUs
  hwmon: occ: Add sysfs interface
  hwmon: occ: Add I2C transport implementation for SCOM operations
  hwmon: occ: Add callbacks for parsing P8 OCC datastructures
  hwmon: occ: Add hwmon implementation for the P8 OCC
  hwmon: occ: Add callbacks for parsing P9 OCC datastructures

 .../devicetree/bindings/i2c/i2c-ibm-occ.txt        |  13 +
 Documentation/hwmon/occ                            | 100 ++++
 drivers/hwmon/Kconfig                              |   2 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/occ/Kconfig                          |  29 ++
 drivers/hwmon/occ/Makefile                         |   2 +
 drivers/hwmon/occ/occ.c                            | 544 +++++++++++++++++++++
 drivers/hwmon/occ/occ.h                            |  86 ++++
 drivers/hwmon/occ/occ_p8.c                         | 217 ++++++++
 drivers/hwmon/occ/occ_p8.h                         |  30 ++
 drivers/hwmon/occ/occ_scom_i2c.c                   |  73 +++
 drivers/hwmon/occ/occ_scom_i2c.h                   |  26 +
 drivers/hwmon/occ/occ_sysfs.c                      | 492 +++++++++++++++++++
 drivers/hwmon/occ/occ_sysfs.h                      |  52 ++
 drivers/hwmon/occ/p8_occ_i2c.c                     | 141 ++++++
 drivers/hwmon/occ/p9_occ.c                         | 243 +++++++++
 drivers/hwmon/occ/p9_occ.h                         |  30 ++
 drivers/hwmon/occ/scom.h                           |  47 ++
 18 files changed, 2128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-ibm-occ.txt
 create mode 100644 Documentation/hwmon/occ
 create mode 100644 drivers/hwmon/occ/Kconfig
 create mode 100644 drivers/hwmon/occ/Makefile
 create mode 100644 drivers/hwmon/occ/occ.c
 create mode 100644 drivers/hwmon/occ/occ.h
 create mode 100644 drivers/hwmon/occ/occ_p8.c
 create mode 100644 drivers/hwmon/occ/occ_p8.h
 create mode 100644 drivers/hwmon/occ/occ_scom_i2c.c
 create mode 100644 drivers/hwmon/occ/occ_scom_i2c.h
 create mode 100644 drivers/hwmon/occ/occ_sysfs.c
 create mode 100644 drivers/hwmon/occ/occ_sysfs.h
 create mode 100644 drivers/hwmon/occ/p8_occ_i2c.c
 create mode 100644 drivers/hwmon/occ/p9_occ.c
 create mode 100644 drivers/hwmon/occ/p9_occ.h
 create mode 100644 drivers/hwmon/occ/scom.h

-- 
1.9.1

