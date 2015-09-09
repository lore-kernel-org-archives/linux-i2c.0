From: Kieran Bingham <kieranbingham@gmail.com>
Subject: [PATCH v4 7/8] mfd: 88pm860x: Move over to new I2C device .probe() call
Date: Wed,  9 Sep 2015 19:33:46 +0100
Message-ID: <1441823627-6227-8-git-send-email-kieranbingham@gmail.com>
References: <1441823627-6227-1-git-send-email-kieranbingham@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441823627-6227-1-git-send-email-kieranbingham@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, grant.likely@linaro.org
List-Id: linux-i2c@vger.kernel.org

From: Lee Jones <lee.jones@linaro.org>

As part of an effort to rid the mostly unused second parameter for I2C
related .probe() functions and to conform to other existing frameworks
we're moving over to a temporary replacement .probe() call-back.

Acked-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/88pm860x-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 3269a99..a499d70 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -1130,8 +1130,7 @@ static int pm860x_dt_init(struct device_node *np,
 	return 0;
 }
 
-static int pm860x_probe(struct i2c_client *client,
-				  const struct i2c_device_id *id)
+static int pm860x_probe(struct i2c_client *client)
 {
 	struct pm860x_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct device_node *node = client->dev.of_node;
@@ -1257,7 +1256,7 @@ static struct i2c_driver pm860x_driver = {
 		.pm     = &pm860x_pm_ops,
 		.of_match_table	= pm860x_dt_ids,
 	},
-	.probe		= pm860x_probe,
+	.probe2		= pm860x_probe,
 	.remove		= pm860x_remove,
 	.id_table	= pm860x_id_table,
 };
-- 
2.1.4
