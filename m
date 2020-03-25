From: Khalil Blaiech <kblaiech@mellanox.com>
Subject: [PATCH v7 0/2] i2c: add driver for Mellanox BlueField SoC
Date: Tue, 24 Mar 2020 21:05:06 -0400
Message-ID: <cover.1585095702.git.kblaiech@mellanox.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:54817 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727119AbgCYBFR (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 24 Mar 2020 21:05:17 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Rob Herring <robh@kernel.org>, linux-i2c@vger.kernel.org
Cc: Khalil Blaiech <kblaiech@mellanox.com>, Vadim Pasternak <vadimp@mellanox.com>

Add I2C SMBus driver and device tree bindings documentation.

The Mellanox BlueField is a System-on-Chip (SoC) that combines
Arm cores and ConnectX network adapter technology intended to
accelerate storage network solutions. The Mellanox BlueField
incorporates various I2C devices that are accessed using SMBus
protocol, a variant of the I2C protocol. On storage controllers,
the BlueField SoC is connected to a management controller board,
e.g., BMC via an I2C bus.

An I2C driver running on the Arm side is needed to manage the
hardware I2C controllers. The driver enables a master function
to transfer data back and forth from/to I2C devices, such as
EEPROM parts and implements a slave function to handle the BMC
controller requests.

v6->v7:
	- Fixing kernel coding style issues as suggested by
	Mellanox internal code reviewers.
        - Updating the dependency expression in Kconfig.
        - Fixing various device driver bugs.
        - Adding an entry to MAINTAINERS file.
v5->v6:
        - Fixing kernel coding style issues detected using
        '--strict' flag.
	- Updating the device binding documentation to add
	support for BlueField-2 SoCs.
v4->v5:
        - Fixing device driver bug.
v3->v4:
	- Review of the device binding documentation to
	fix format issue and miscellaneous cleanup.
v2->v3:
	- Various device driver changes and bug fixes.
	- Updating the device property in the device binding
	documentation and file format review.
v1->v2:
        - Various device driver changes and bug fixes.
	- Cleanup of the device binding documentation.
	

Khalil Blaiech (2):
  i2c: i2c-mlxbf: I2C SMBus driver for Mellanox BlueField SoC
  dt-bindings: i2c: I2C binding for Mellanox BlueField SoC

 .../devicetree/bindings/i2c/mellanox,i2c-mlxbf.txt |   42 +
 MAINTAINERS                                        |    6 +
 drivers/i2c/busses/Kconfig                         |   13 +
 drivers/i2c/busses/Makefile                        |    1 +
 drivers/i2c/busses/i2c-mlxbf.c                     | 2506 ++++++++++++++++++++
 5 files changed, 2568 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/mellanox,i2c-mlxbf.txt
 create mode 100644 drivers/i2c/busses/i2c-mlxbf.c

-- 
2.1.2
