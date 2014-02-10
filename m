From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 05/17] i2c: i2c-bcm2835: deprecate class based instantiation
Date: Mon, 10 Feb 2014 11:03:59 +0100
Message-ID: <1392026654-5343-6-git-send-email-wsa@the-dreams.de>
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

 drivers/i2c/busses/i2c-bcm2835.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index 77df97b..6722808 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -295,7 +295,7 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 	adap = &i2c_dev->adapter;
 	i2c_set_adapdata(adap, i2c_dev);
 	adap->owner = THIS_MODULE;
-	adap->class = I2C_CLASS_HWMON;
+	adap->class = I2C_CLASS_HWMON | I2C_CLASS_DEPRECATED;
 	strlcpy(adap->name, "bcm2835 I2C adapter", sizeof(adap->name));
 	adap->algo = &bcm2835_i2c_algo;
 	adap->dev.parent = &pdev->dev;
-- 
1.8.5.1
