From: Tin Huynh <tnhuynh@apm.com>
Subject: [PATCH V1] i2c: designware: fix wrong tx/rx fifo for ACPI
Date: Tue, 29 Nov 2016 10:32:07 +0700
Message-ID: <1480390327-24562-1-git-send-email-tnhuynh@apm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com, Tin Huynh <tnhuynh@apm.com>
List-Id: linux-i2c@vger.kernel.org

ACPI always sets txfifo and rxfifo to 32. This configuration will
cause problem if the IP core supports a fifo size of 16 bytes only.
Set the default value to 0 so the driver will get these parameters 
from IP core.

Signed-off-by: Tin Huynh <tnhuynh@apm.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 0b42a12..c88a4b8 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -97,8 +97,8 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
 	const struct acpi_device_id *id;
 
 	dev->adapter.nr = -1;
-	dev->tx_fifo_depth = 32;
-	dev->rx_fifo_depth = 32;
+	dev->tx_fifo_depth = 0;
+	dev->rx_fifo_depth = 0;
 
 	/*
 	 * Try to get SDA hold time and *CNT values from an ACPI method if
-- 
1.7.1

