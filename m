From: Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v5 0/6] drivers/i2c: Add FSI-attached I2C master algorithm
Date: Wed, 26 Jul 2017 12:13:12 -0500
Message-ID: <1501089198-10356-1-git-send-email-eajames@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, wsa@the-dreams.de, robh+dt@kernel.org, jk@ozlabs.org, joel@jms.id.au, andrew@aj.id.au, cbostic@linux.vnet.ibm.com, eajames@linux.vnet.ibm.com, "Edward A. James" <eajames@us.ibm.com>
List-Id: linux-i2c@vger.kernel.org

From: "Edward A. James" <eajames@us.ibm.com>

This series adds an algorithm for an I2C master physically located on an FSI
slave device. The I2C master has multiple ports, each of which may be connected
to an I2C slave. Access to the I2C master registers is achieved over FSI bus.

Due to the multi-port nature of the I2C master, the driver instantiates a new
I2C adapter for each port connected to a slave. The connected ports should be
defined in the device tree under the I2C master device.

Changes since v4:
 - Add SMBUS flags to functionality mask.
 - Improve probing by continuing parsing the dt if we fail one adapter
   registration. Also don't fail for ENOMEM, as we may have registered some
   ports already.
 - Fix remove() by checking for empty list before iterating.

Edward A. James (6):
  drivers/i2c: Add FSI-attached I2C master algorithm
  drivers/i2c: Add port structure to FSI algorithm
  drivers/i2c: Add transfer implementation for FSI algorithm
  drivers/i2c: Add I2C master locking to FSI algorithm
  drivers/i2c: Add bus recovery for FSI algorithm
  dt-bindings: i2c: Add FSI-attached I2C master dt binding documentation

 Documentation/devicetree/bindings/i2c/i2c-fsi.txt |  40 ++
 drivers/i2c/busses/Kconfig                        |  11 +
 drivers/i2c/busses/Makefile                       |   1 +
 drivers/i2c/busses/i2c-fsi.c                      | 643 ++++++++++++++++++++++
 4 files changed, 695 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-fsi.txt
 create mode 100644 drivers/i2c/busses/i2c-fsi.c

-- 
1.8.3.1
