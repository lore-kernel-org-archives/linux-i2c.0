From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: [PATCH] i2c/designware: enable i2c controller to suspend/resume
 asynchronously
Date: Thu, 24 Dec 2015 22:30:42 +0800
Message-ID: <567C0192.2050601@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jarkko.nikula@linux.intel.com, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, srinivas.kowtal@intel.com
List-Id: linux-i2c@vger.kernel.org

Now, PM core supports asynchronous suspend/resume mode for devices
during system suspend/resume, and the power state transition of one
device may be completed in separate kernel thread. PM core ensures
all power state transition dependency between devices. This patch
enables designware i2c controllers to suspend/resume asynchronously.
This will take advantage of multicore and improve system suspend/resume
speed. After enabling all i2c devices, i2c adapters and i2c controllers
on ASUS T100TA tablet, the system suspend-to-idle time is reduced to
about 510ms from 750ms, and the system resume time is reduced to about
790ms from 900ms.

Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 6b00061..395130b 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -230,6 +230,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	}
 
 	adap = &dev->adapter;
+	device_enable_async_suspend(&pdev->dev);
 	adap->owner = THIS_MODULE;
 	adap->class = I2C_CLASS_DEPRECATED;
 	ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));
-- 1.7.1
