From: Matthieu CASTET <matthieu.castet-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] tsc2007 : set irq edge
Date: Wed, 24 Feb 2010 11:34:05 +0100
Message-ID: <4B85009D.3040604@parrot.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------090303070603040006090808"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Kwangwoo Lee <kwlee-ec7hoAtq5SbSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--------------090303070603040006090808
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hi,

We need to pass a trigger flag for the interruption to work with some
gpio controller.

This patch make it work on a arm omap chip.

Signed-off-by: Matthieu CASTET <matthieu.castet-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>

--------------090303070603040006090808
Content-Type: text/x-diff; name="tsc2007_irq.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="tsc2007_irq.diff"

diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index 7ef0d14..a16b9e5 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -312,7 +312,7 @@ static int __devinit tsc2007_probe(struct i2c_client *client,
 	if (pdata->init_platform_hw)
 		pdata->init_platform_hw();
 
-	err = request_irq(ts->irq, tsc2007_irq, 0,
+	err = request_irq(ts->irq, tsc2007_irq, IRQF_TRIGGER_FALLING,
 			client->dev.driver->name, ts);
 	if (err < 0) {
 		dev_err(&client->dev, "irq %d busy?\n", ts->irq);

--------------090303070603040006090808--
