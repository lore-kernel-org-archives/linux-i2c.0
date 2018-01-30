From: Andrew Cooks <andrew.cooks@opengear.com>
Subject: [PATCH v4 0/3] Enable ACPI-defined peripherals on i2c-piix4 SMBus
Date: Wed, 31 Jan 2018 07:40:27 +1000
Message-ID: <cover.1517285239.git.andrew.cooks@opengear.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, "open list:I2C/SMBUS CONTROLLER DRIVERS FOR
        PC" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: Andrew Cooks <andrew.cooks@opengear.com>
List-Id: linux-i2c@vger.kernel.org

These patches fix a couple of issues with the i2c-piix4 driver on
AMD Family 16h Model 30h SoCs and add ACPI-based enumeration to the
i2c-piix4 driver.

Some I2C peripherals, eg. PCA953x IO expander, are not discovered by the
probe or detect mechanisms when attached to an SMBus controller that uses
the i2c-piix4 SMBus driver.

ACPI provides a mechanism to define these peripherals and the controller
port that they're attached to.

Changes:
v4:
  remove unnecessary SB800_MAIN_PORTS constant
  reduce piix4_remove change
v3:
  take chip revision into account when determining port selection register
v2:
  count the adapters, instead of misusing port numbers

Andrew Cooks (3):
  i2c: piix4: Fix port selection for AMD Family 16h Model 30h
  i2c: piix4: fix probing of reserved ports on AMD
  i2c: piix4: add ACPI support

 drivers/i2c/busses/i2c-piix4.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

-- 
2.7.4
