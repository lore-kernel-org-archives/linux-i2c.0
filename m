From: Andrew Cooks <andrew.cooks@opengear.com>
Subject: [PATCH v2 0/3] Enable ACPI-defined peripherals on i2c-piix4 SMBus
Date: Thu, 14 Dec 2017 13:11:43 +1000
Message-ID: <cover.1513215039.git.andrew.cooks@opengear.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-by2nam01on0087.outbound.protection.outlook.com ([104.47.34.87]:64038
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751803AbdLNDMJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 13 Dec 2017 22:12:09 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jdelvare@suse.com, linux-i2c@vger.kernel.org
Cc: platypus-sw@opengear.com, Andrew Cooks <andrew.cooks@opengear.com>

These patches add ACPI-based enumeration to the i2c-piix4 driver.

Some I2C peripherals, eg. PCA953x IO expander, are not discovered by the
probe or detect mechanisms when attached to an SMBus controller that uses
the i2c-piix4 SMBus driver.

ACPI provides a mechanism to define these peripherals and the controller
port that they're attached to.

v2:
  count the adapters, instead of misusing port numbers

Andrew Cooks (3):
  i2c: piix4: Fix SMBus port selection for AMD Family 16h chips
  i2c: piix4: fix number of SMBus ports on HUDSON2
  i2c: add ACPI support for i2c-piix4

 drivers/i2c/busses/i2c-piix4.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

-- 
2.7.4
