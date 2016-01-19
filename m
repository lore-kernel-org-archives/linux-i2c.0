From: minyard@acm.org
Subject: [PATCH] i2c-smbus: Don't report duplicate alerts
Date: Tue, 19 Jan 2016 11:00:48 -0600
Message-ID: <1453222848-20457-1-git-send-email-minyard@acm.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from vms173023pub.verizon.net ([206.46.173.23]:58390 "EHLO
	vms173023pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932414AbcASSBa (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 19 Jan 2016 13:01:30 -0500
Received: from serve.minyard.net ([173.57.176.17]) by vms173023.mailsrvcs.net
 (Oracle Communications Messaging Server 7.0.5.32.0 64bit (built Jul 16 2014))
 with ESMTPA id <0O1700F8RLXH0150@vms173023.mailsrvcs.net> for
 linux-i2c@vger.kernel.org; Tue, 19 Jan 2016 11:00:58 -0600 (CST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Getting the same alert twice in a row is legal and normal,
especially on a fast device (like running in qemu).  Kind of
like interrupts.  So don't report duplicate alerts, and deliver
them normally.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/i2c/i2c-smbus.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index 94765a8..cecd423 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -75,7 +75,6 @@ static void smbus_alert(struct work_struct *work)
 {
 	struct i2c_smbus_alert *alert;
 	struct i2c_client *ara;
-	unsigned short prev_addr = 0;	/* Not a valid address */
 
 	alert = container_of(work, struct i2c_smbus_alert, alert);
 	ara = alert->ara;
@@ -99,18 +98,12 @@ static void smbus_alert(struct work_struct *work)
 		data.flag = status & 1;
 		data.addr = status >> 1;
 
-		if (data.addr == prev_addr) {
-			dev_warn(&ara->dev, "Duplicate SMBALERT# from dev "
-				"0x%02x, skipping\n", data.addr);
-			break;
-		}
 		dev_dbg(&ara->dev, "SMBALERT# from dev 0x%02x, flag %d\n",
 			data.addr, data.flag);
 
 		/* Notify driver for the device which issued the alert */
 		device_for_each_child(&ara->adapter->dev, &data,
 				      smbus_do_alert);
-		prev_addr = data.addr;
 	}
 
 	/* We handled all alerts; re-enable level-triggered IRQs */
-- 
2.5.0
