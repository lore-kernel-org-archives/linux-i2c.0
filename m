From: eajames.ibm@gmail.com
Subject: [PATCH linux v2 0/6] drivers: hwmon: Add On-Chip Controller driver
Date: Wed, 11 Jan 2017 12:10:31 -0600
Message-ID: <1484158237-10014-1-git-send-email-eajames.ibm@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:36750 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936916AbdAKSKq (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 11 Jan 2017 13:10:46 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux@roeck-us.net
Cc: devicetree@vger.kernel.org, jdelvare@suse.com, corbet@lwn.net, linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, robh+dt@kernel.org, wsa@the-dreams.de, andrew@aj.id.au, joel@jms.id.au, benh@kernel.crashing.org, "Edward A. James" <eajames@us.ibm.com>

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

 Documentation/devicetree/bindings/hwmon/occ.txt |  13 +
 Documentation/hwmon/occ                         | 114 +++++
 drivers/hwmon/Kconfig                           |   2 +
 drivers/hwmon/Makefile                          |   1 +
 drivers/hwmon/occ/Kconfig                       |  29 ++
 drivers/hwmon/occ/Makefile                      |   2 +
 drivers/hwmon/occ/occ.c                         | 533 ++++++++++++++++++++++++
 drivers/hwmon/occ/occ.h                         |  83 ++++
 drivers/hwmon/occ/occ_p8.c                      | 254 +++++++++++
 drivers/hwmon/occ/occ_p8.h                      |  31 ++
 drivers/hwmon/occ/occ_p9.c                      | 314 ++++++++++++++
 drivers/hwmon/occ/occ_p9.h                      |  31 ++
 drivers/hwmon/occ/occ_scom_i2c.c                |  73 ++++
 drivers/hwmon/occ/occ_scom_i2c.h                |  26 ++
 drivers/hwmon/occ/occ_sysfs.c                   | 274 ++++++++++++
 drivers/hwmon/occ/occ_sysfs.h                   |  44 ++
 drivers/hwmon/occ/p8_occ_i2c.c                  | 123 ++++++
 drivers/hwmon/occ/scom.h                        |  47 +++
 18 files changed, 1994 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/occ.txt
 create mode 100644 Documentation/hwmon/occ
 create mode 100644 drivers/hwmon/occ/Kconfig
 create mode 100644 drivers/hwmon/occ/Makefile
 create mode 100644 drivers/hwmon/occ/occ.c
 create mode 100644 drivers/hwmon/occ/occ.h
 create mode 100644 drivers/hwmon/occ/occ_p8.c
 create mode 100644 drivers/hwmon/occ/occ_p8.h
 create mode 100644 drivers/hwmon/occ/occ_p9.c
 create mode 100644 drivers/hwmon/occ/occ_p9.h
 create mode 100644 drivers/hwmon/occ/occ_scom_i2c.c
 create mode 100644 drivers/hwmon/occ/occ_scom_i2c.h
 create mode 100644 drivers/hwmon/occ/occ_sysfs.c
 create mode 100644 drivers/hwmon/occ/occ_sysfs.h
 create mode 100644 drivers/hwmon/occ/p8_occ_i2c.c
 create mode 100644 drivers/hwmon/occ/scom.h

-- 
1.9.1
