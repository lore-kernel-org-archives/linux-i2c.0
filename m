From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH] i2c-nomadik: fix regression on adapter name
Date: Tue, 30 Nov 2010 16:59:29 +0100
Message-ID: <1291132769-20775-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The Nomadik I2C adapter does not provide a name for the struct
passed into i2c_add_numbered_adapter() causing a regression on
2.6.37-rc3 due to commit 2236baa75f704851d3cd3310569058151acb1f06
adding sanity checks for adapters. Fix this by providing a name
proper.

Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
---
Second version - giving an adapter name that provides the instance
number and resource address.
---
 drivers/i2c/busses/i2c-nomadik.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index c9fffd0..f7148fd 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -872,6 +872,8 @@ static int __devinit nmk_i2c_probe(struct platform_device *pdev)
 	adap->owner	= THIS_MODULE;
 	adap->class	= I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	adap->algo	= &nmk_i2c_algo;
+	snprintf(adap->name, sizeof(adap->name),
+		 "Nomadik I2C%d at %lx", pdev->id, (unsigned long)res->start);
 
 	/* fetch the controller id */
 	adap->nr	= pdev->id;
@@ -891,8 +893,8 @@ static int __devinit nmk_i2c_probe(struct platform_device *pdev)
 		goto err_init_hw;
 	}
 
-	dev_dbg(&pdev->dev, "initialize I2C%d bus on virtual "
-		"base %p\n", pdev->id, dev->virtbase);
+	dev_info(&pdev->dev, "initialize %s on virtual "
+		"base %p\n", adap->name, dev->virtbase);
 
 	ret = i2c_add_numbered_adapter(adap);
 	if (ret) {
-- 
1.7.3.2
