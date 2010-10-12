From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Optimize function i2c_detect()
Date: Tue, 12 Oct 2010 10:26:19 +0200
Message-ID: <20101012102619.3471b82b@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Check the class flags before allocating the temporary i2c_client
structure, to avoid allocating it when we don't need it.

Also optimize the inner loop a bit.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/i2c-core.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- linux-2.6.36-rc7.orig/drivers/i2c/i2c-core.c	2010-10-11 17:19:53.000000000 +0200
+++ linux-2.6.36-rc7/drivers/i2c/i2c-core.c	2010-10-12 09:55:37.000000000 +0200
@@ -1521,26 +1521,25 @@ static int i2c_detect(struct i2c_adapter
 	if (!driver->detect || !address_list)
 		return 0;
 
+	/* Stop here if the classes do not match */
+	if (!(adapter->class & driver->class))
+		return 0;
+
 	/* Set up a temporary client to help detect callback */
 	temp_client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (!temp_client)
 		return -ENOMEM;
 	temp_client->adapter = adapter;
 
-	/* Stop here if the classes do not match */
-	if (!(adapter->class & driver->class))
-		goto exit_free;
-
 	for (i = 0; address_list[i] != I2C_CLIENT_END; i += 1) {
 		dev_dbg(&adapter->dev, "found normal entry for adapter %d, "
 			"addr 0x%02x\n", adap_id, address_list[i]);
 		temp_client->addr = address_list[i];
 		err = i2c_detect_address(temp_client, driver);
-		if (err)
-			goto exit_free;
+		if (unlikely(err))
+			break;
 	}
 
- exit_free:
 	kfree(temp_client);
 	return err;
 }

-- 
Jean Delvare
