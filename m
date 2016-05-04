From: Kieran Bingham <kieran@ksquared.org.uk>
Subject: [PATCHv5 8/8] mfd: as3722: Rid driver of superfluous I2C device ID structure
Date: Wed,  4 May 2016 16:14:48 +0100
Message-ID: <1462374888-22888-9-git-send-email-kieran@bingham.xyz>
References: <1462374888-22888-1-git-send-email-kieran@bingham.xyz>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34136 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523AbcEDPPS (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 4 May 2016 11:15:18 -0400
In-Reply-To: <1462374888-22888-1-git-send-email-kieran@bingham.xyz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, javier@osg.samsung.com
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com, Kieran Bingham <kieran@ksquared.org.uk>

From: Lee Jones <lee.jones@linaro.org>

Also remove unused second probe() parameter 'i2c_device_id'.

Acked-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Kieran Bingham <kieran@bingham.xyz>

---
Changes since v4
 - Rename .probe2 to probe_new
---
 drivers/mfd/as3722.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/as3722.c b/drivers/mfd/as3722.c
index e1f597f97f86..28fc62af6861 100644
--- a/drivers/mfd/as3722.c
+++ b/drivers/mfd/as3722.c
@@ -354,8 +354,7 @@ static int as3722_i2c_of_probe(struct i2c_client *i2c,
 	return 0;
 }
 
-static int as3722_i2c_probe(struct i2c_client *i2c,
-			const struct i2c_device_id *id)
+static int as3722_i2c_probe(struct i2c_client *i2c)
 {
 	struct as3722 *as3722;
 	unsigned long irq_flags;
@@ -453,12 +452,6 @@ static const struct of_device_id as3722_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, as3722_of_match);
 
-static const struct i2c_device_id as3722_i2c_id[] = {
-	{ "as3722", 0 },
-	{},
-};
-MODULE_DEVICE_TABLE(i2c, as3722_i2c_id);
-
 static const struct dev_pm_ops as3722_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(as3722_i2c_suspend, as3722_i2c_resume)
 };
@@ -469,9 +462,8 @@ static struct i2c_driver as3722_i2c_driver = {
 		.of_match_table = as3722_of_match,
 		.pm = &as3722_pm_ops,
 	},
-	.probe = as3722_i2c_probe,
+	.probe_new = as3722_i2c_probe,
 	.remove = as3722_i2c_remove,
-	.id_table = as3722_i2c_id,
 };
 
 module_i2c_driver(as3722_i2c_driver);
-- 
2.5.0
