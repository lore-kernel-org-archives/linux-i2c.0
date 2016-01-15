From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: [PATCH v2] i2c/designware: enable i2c controller to suspend/resume
 asynchronously
Date: Fri, 15 Jan 2016 14:38:09 +0800
Message-ID: <569893D1.5050403@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:56995 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbcAOGiQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 15 Jan 2016 01:38:16 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jarkko.nikula@linux.intel.com, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

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
Changes in v2:
- Move the device_enable_async_suspend() call into i2c_dw_proble()

 drivers/i2c/busses/i2c-designware-core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index ba9732c..5d6ad27 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -861,6 +861,7 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 
 	init_completion(&dev->cmd_complete);
 	mutex_init(&dev->lock);
+	device_enable_async_suspend(dev->dev);
 
 	r = i2c_dw_init(dev);
 	if (r)
-- 1.7.1
