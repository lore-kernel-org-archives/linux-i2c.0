From: Kieran Bingham <kieran@ksquared.org.uk>
Subject: [PATCHv7 09/11] mfd: 88pm860x: Move over to new I2C device .probe() call
Date: Mon,  7 Nov 2016 12:47:44 +0000
Message-ID: <1478522866-29620-10-git-send-email-kieran@bingham.xyz>
References: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Kieran Bingham <kieran@ksquared.org.uk>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

From: Lee Jones <lee.jones@linaro.org>

As part of an effort to rid the mostly unused second parameter for I2C
related .probe() functions and to conform to other existing frameworks
we're moving over to a temporary replacement .probe() call-back.

Acked-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Kieran Bingham <kieran@bingham.xyz>

---
Changes since v4
 - Rename .probe2 to probe_new

 drivers/mfd/88pm860x-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 25e1aafae60c..227b99018657 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -1132,8 +1132,7 @@ static int pm860x_dt_init(struct device_node *np,
 	return 0;
 }
 
-static int pm860x_probe(struct i2c_client *client,
-				  const struct i2c_device_id *id)
+static int pm860x_probe(struct i2c_client *client)
 {
 	struct pm860x_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct device_node *node = client->dev.of_node;
@@ -1259,7 +1258,7 @@ static struct i2c_driver pm860x_driver = {
 		.pm     = &pm860x_pm_ops,
 		.of_match_table	= pm860x_dt_ids,
 	},
-	.probe		= pm860x_probe,
+	.probe_new	= pm860x_probe,
 	.remove		= pm860x_remove,
 	.id_table	= pm860x_id_table,
 };
-- 
2.7.4
