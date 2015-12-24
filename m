From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: [PATCH 1/2] i2c: enable i2c device to suspend/resume asynchronously
Date: Thu, 24 Dec 2015 22:41:05 +0800
Message-ID: <567C0401.8000806@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:10128 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751036AbbLXOlI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 24 Dec 2015 09:41:08 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: srinivas.kowtal@intel.com, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Now, PM core supports asynchronous suspend/resume mode for devices
during system suspend/resume, and the power state transition of one
device may be completed in separate kernel thread. PM core ensures
all power state transition dependency between devices. This patch
enables i2c devices to suspend/resume asynchronously. This will take
advantage of multicore and improve system suspend/resume speed. After
enabling all i2c devices, i2c adapters and i2c controllers on ASUS
T100TA tablet, the system suspend-to-idle time is reduced to about
510ms from 750ms, and the system resume time is reduced to about 790ms
from 900ms.

Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
---
 drivers/i2c/i2c-core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index ba8eb08..4ff620e 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1072,6 +1072,7 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 	client->dev.of_node = info->of_node;
 	client->dev.fwnode = info->fwnode;
 
+	device_enable_async_suspend(&client->dev);
 	i2c_dev_set_name(adap, client);
 	status = device_register(&client->dev);
 	if (status)
-- 1.7.1
