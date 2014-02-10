From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 09/17] i2c: i2c-mv64xxx: deprecate class based instantiation
Date: Mon, 10 Feb 2014 11:04:03 +0100
Message-ID: <1392026654-5343-10-git-send-email-wsa@the-dreams.de>
References: <1392026654-5343-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392026654-5343-1-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Warn users that class based instantiation is going away soon in favour
of more robust probing and faster bootup times.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

This patch is a suggestion. Looking for an ack by someone who actually uses
the driver.

 drivers/i2c/busses/i2c-mv64xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 8be7e42..05801c6 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -851,7 +851,7 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 	drv_data->adapter.dev.parent = &pd->dev;
 	drv_data->adapter.algo = &mv64xxx_i2c_algo;
 	drv_data->adapter.owner = THIS_MODULE;
-	drv_data->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
+	drv_data->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD | I2C_CLASS_DEPRECATED;
 	drv_data->adapter.nr = pd->id;
 	drv_data->adapter.dev.of_node = pd->dev.of_node;
 	platform_set_drvdata(pd, drv_data);
-- 
1.8.5.1
