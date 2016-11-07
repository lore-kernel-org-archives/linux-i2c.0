From: Kieran Bingham <kieran@ksquared.org.uk>
Subject: [PATCHv7 10/11] mfd: as3722: Rid driver of superfluous I2C device ID structure
Date: Mon,  7 Nov 2016 12:47:45 +0000
Message-ID: <1478522866-29620-11-git-send-email-kieran@bingham.xyz>
References: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Kieran Bingham <kieran@ksquared.org.uk>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

From: Lee Jones <lee.jones@linaro.org>

Also remove unused second probe() parameter 'i2c_device_id'.

Acked-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Kieran Bingham <kieran@bingham.xyz>

---
Changes since v4
 - Rename .probe2 to probe_new

 drivers/mfd/as3722.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/as3722.c b/drivers/mfd/as3722.c
index f87342c211bc..7d8c5e4136e2 100644
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
@@ -441,12 +440,6 @@ static const struct of_device_id as3722_of_match[] = {
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
@@ -457,8 +450,7 @@ static struct i2c_driver as3722_i2c_driver = {
 		.of_match_table = as3722_of_match,
 		.pm = &as3722_pm_ops,
 	},
-	.probe = as3722_i2c_probe,
-	.id_table = as3722_i2c_id,
+	.probe_new = as3722_i2c_probe,
 };
 
 module_i2c_driver(as3722_i2c_driver);
-- 
2.7.4
