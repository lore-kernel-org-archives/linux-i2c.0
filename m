From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-taos-evm: Fix log messages
Date: Wed, 8 Jun 2011 18:24:14 +0200
Message-ID: <20110608182414.352cd131@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

* Print all error and information messages even when debugging is
  disabled.
* Don't use adapter device to log messages before it is ready.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-taos-evm.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-3.0-rc2.orig/drivers/i2c/busses/i2c-taos-evm.c	2010-08-02 00:11:14.000000000 +0200
+++ linux-3.0-rc2/drivers/i2c/busses/i2c-taos-evm.c	2011-06-08 18:06:32.000000000 +0200
@@ -234,7 +234,7 @@ static int taos_connect(struct serio *se
 
 	if (taos->state != TAOS_STATE_IDLE) {
 		err = -ENODEV;
-		dev_dbg(&serio->dev, "TAOS EVM reset failed (state=%d, "
+		dev_err(&serio->dev, "TAOS EVM reset failed (state=%d, "
 			"pos=%d)\n", taos->state, taos->pos);
 		goto exit_close;
 	}
@@ -255,7 +255,7 @@ static int taos_connect(struct serio *se
 					 msecs_to_jiffies(250));
 	if (taos->state != TAOS_STATE_IDLE) {
 		err = -ENODEV;
-		dev_err(&adapter->dev, "Echo off failed "
+		dev_err(&serio->dev, "TAOS EVM echo off failed "
 			"(state=%d)\n", taos->state);
 		goto exit_close;
 	}
@@ -263,7 +263,7 @@ static int taos_connect(struct serio *se
 	err = i2c_add_adapter(adapter);
 	if (err)
 		goto exit_close;
-	dev_dbg(&serio->dev, "Connected to TAOS EVM\n");
+	dev_info(&serio->dev, "Connected to TAOS EVM\n");
 
 	taos->client = taos_instantiate_device(adapter);
 	return 0;
@@ -288,7 +288,7 @@ static void taos_disconnect(struct serio
 	serio_set_drvdata(serio, NULL);
 	kfree(taos);
 
-	dev_dbg(&serio->dev, "Disconnected from TAOS EVM\n");
+	dev_info(&serio->dev, "Disconnected from TAOS EVM\n");
 }
 
 static struct serio_device_id taos_serio_ids[] = {


-- 
Jean Delvare
