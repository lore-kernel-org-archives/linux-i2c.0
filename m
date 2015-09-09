From: Kieran Bingham <kieranbingham@gmail.com>
Subject: [PATCH v4 8/8] mfd: as3722: Rid driver of superfluous I2C device ID structure
Date: Wed,  9 Sep 2015 19:33:47 +0100
Message-ID: <1441823627-6227-9-git-send-email-kieranbingham@gmail.com>
References: <1441823627-6227-1-git-send-email-kieranbingham@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441823627-6227-1-git-send-email-kieranbingham@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, grant.likely@linaro.org
List-Id: linux-i2c@vger.kernel.org

From: Lee Jones <lee.jones@linaro.org>

Also remove unused second probe() parameter 'i2c_device_id'.

Acked-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/as3722.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/as3722.c b/drivers/mfd/as3722.c
index 924ea90..6ac4be3 100644
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
@@ -428,20 +427,13 @@ static const struct of_device_id as3722_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, as3722_of_match);
 
-static const struct i2c_device_id as3722_i2c_id[] = {
-	{ "as3722", 0 },
-	{},
-};
-MODULE_DEVICE_TABLE(i2c, as3722_i2c_id);
-
 static struct i2c_driver as3722_i2c_driver = {
 	.driver = {
 		.name = "as3722",
 		.of_match_table = as3722_of_match,
 	},
-	.probe = as3722_i2c_probe,
+	.probe2 = as3722_i2c_probe,
 	.remove = as3722_i2c_remove,
-	.id_table = as3722_i2c_id,
 };
 
 module_i2c_driver(as3722_i2c_driver);
-- 
2.1.4
