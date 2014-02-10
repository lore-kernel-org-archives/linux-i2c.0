From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 15/17] i2c: i2c-stu300: deprecate class based instantiation
Date: Mon, 10 Feb 2014 11:04:09 +0100
Message-ID: <1392026654-5343-16-git-send-email-wsa@the-dreams.de>
References: <1392026654-5343-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392026654-5343-1-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Warn users that class based instantiation is going away soon in favour
of more robust probing and faster bootup times.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
---

This patch is a suggestion. Looking for an ack by someone who actually uses
the driver.

 drivers/i2c/busses/i2c-stu300.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
index 04a17b9..d381af9 100644
--- a/drivers/i2c/busses/i2c-stu300.c
+++ b/drivers/i2c/busses/i2c-stu300.c
@@ -911,7 +911,7 @@ static int stu300_probe(struct platform_device *pdev)
 	adap = &dev->adapter;
 	adap->owner = THIS_MODULE;
 	/* DDC class but actually often used for more generic I2C */
-	adap->class = I2C_CLASS_DDC;
+	adap->class = I2C_CLASS_DDC | I2C_CLASS_DEPRECATED;
 	strlcpy(adap->name, "ST Microelectronics DDC I2C adapter",
 		sizeof(adap->name));
 	adap->nr = bus_nr;
-- 
1.8.5.1
