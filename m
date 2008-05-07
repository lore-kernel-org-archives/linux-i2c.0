From: =?iso-8859-15?q?Lothar_Wa=DFmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: [patch 2.6.26-rc1] i2c_core:  return -Errno not -1
Date: Wed, 7 May 2008 09:21:15 +0200
Message-ID: <18465.22635.646092.18578@ipc1.ka-ro>
Content-Type: multipart/mixed; boundary="===============1523860795837368437=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--===============1523860795837368437==

Fix return values of various functions in i2c-core.c to either promote
the return code of a called function or return a sensible 'errno'
value instead of a bogus '-1' (which would be interpreted as 'EPERM').

Signed-off-by: Lothar Waﬂmann <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
---
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 8dcd937..7ba66c7 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1113,7 +1113,7 @@ int i2c_probe(struct i2c_adapter *adapter,
 
 		dev_warn(&adapter->dev, "SMBus Quick command not supported, "
 			 "can't probe for chips\n");
-		return -1;
+		return -EOPNOTSUPP;
 	}
 
 	/* Probe entries are done second, and are not affected by ignore
@@ -1305,7 +1305,7 @@ static int i2c_smbus_check_pec(u8 cpec, struct i2c_msg *msg)
 	if (rpec != cpec) {
 		pr_debug("i2c-core: Bad PEC 0x%02x vs. 0x%02x\n",
 			rpec, cpec);
-		return -1;
+		return -EIO;
 	}
 	return 0;
 }
@@ -1320,9 +1320,10 @@ EXPORT_SYMBOL(i2c_smbus_write_quick);
 s32 i2c_smbus_read_byte(struct i2c_client *client)
 {
 	union i2c_smbus_data data;
-	if (i2c_smbus_xfer(client->adapter,client->addr,client->flags,
-	                   I2C_SMBUS_READ,0,I2C_SMBUS_BYTE, &data))
-		return -1;
+	int ret;
+	if ((ret = i2c_smbus_xfer(client->adapter,client->addr,client->flags,
+				  I2C_SMBUS_READ,0,I2C_SMBUS_BYTE, &data)))
+		return ret;
 	else
 		return data.byte;
 }
@@ -1337,10 +1338,11 @@ EXPORT_SYMBOL(i2c_smbus_write_byte);
 
 s32 i2c_smbus_read_byte_data(struct i2c_client *client, u8 command)
 {
+	int ret;
 	union i2c_smbus_data data;
-	if (i2c_smbus_xfer(client->adapter,client->addr,client->flags,
-	                   I2C_SMBUS_READ,command, I2C_SMBUS_BYTE_DATA,&data))
-		return -1;
+	if ((ret = i2c_smbus_xfer(client->adapter,client->addr,client->flags,
+				  I2C_SMBUS_READ,command, I2C_SMBUS_BYTE_DATA,&data)))
+		return ret;
 	else
 		return data.byte;
 }
@@ -1358,10 +1360,11 @@ EXPORT_SYMBOL(i2c_smbus_write_byte_data);
 
 s32 i2c_smbus_read_word_data(struct i2c_client *client, u8 command)
 {
+	int ret;
 	union i2c_smbus_data data;
-	if (i2c_smbus_xfer(client->adapter,client->addr,client->flags,
-	                   I2C_SMBUS_READ,command, I2C_SMBUS_WORD_DATA, &data))
-		return -1;
+	if ((ret = i2c_smbus_xfer(client->adapter,client->addr,client->flags,
+				  I2C_SMBUS_READ,command, I2C_SMBUS_WORD_DATA, &data)))
+		return ret;
 	else
 		return data.word;
 }
@@ -1396,12 +1399,13 @@ EXPORT_SYMBOL(i2c_smbus_write_word_data);
 s32 i2c_smbus_read_block_data(struct i2c_client *client, u8 command,
 			      u8 *values)
 {
+	int ret;
 	union i2c_smbus_data data;
 
-	if (i2c_smbus_xfer(client->adapter, client->addr, client->flags,
-	                   I2C_SMBUS_READ, command,
-	                   I2C_SMBUS_BLOCK_DATA, &data))
-		return -1;
+	if ((ret = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+				  I2C_SMBUS_READ, command,
+				  I2C_SMBUS_BLOCK_DATA, &data)))
+		return ret;
 
 	memcpy(values, &data.block[1], data.block[0]);
 	return data.block[0];
@@ -1427,15 +1431,16 @@ EXPORT_SYMBOL(i2c_smbus_write_block_data);
 s32 i2c_smbus_read_i2c_block_data(struct i2c_client *client, u8 command,
 				  u8 length, u8 *values)
 {
+	int ret;
 	union i2c_smbus_data data;
 
 	if (length > I2C_SMBUS_BLOCK_MAX)
 		length = I2C_SMBUS_BLOCK_MAX;
 	data.block[0] = length;
-	if (i2c_smbus_xfer(client->adapter,client->addr,client->flags,
-	                      I2C_SMBUS_READ,command,
-	                      I2C_SMBUS_I2C_BLOCK_DATA,&data))
-		return -1;
+	if ((ret = i2c_smbus_xfer(client->adapter,client->addr,client->flags,
+				  I2C_SMBUS_READ,command,
+				  I2C_SMBUS_I2C_BLOCK_DATA,&data)))
+		return ret;
 
 	memcpy(values, &data.block[1], data.block[0]);
 	return data.block[0];
@@ -1476,6 +1481,7 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter * adapter, u16 addr,
 	                        };
 	int i;
 	u8 partial_pec = 0;
+	int ret;
 
 	msgbuf0[0] = command;
 	switch(size) {
@@ -1528,7 +1534,7 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter * adapter, u16 addr,
 				dev_err(&adapter->dev, "smbus_access called with "
 				       "invalid block write size (%d)\n",
 				       data->block[0]);
-				return -1;
+				return -EINVAL;
 			}
 			for (i = 1; i < msg[0].len; i++)
 				msgbuf0[i] = data->block[i-1];
@@ -1541,7 +1547,7 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter * adapter, u16 addr,
 			dev_err(&adapter->dev, "%s called with invalid "
 				"block proc call size (%d)\n", __func__,
 				data->block[0]);
-			return -1;
+			return -EINVAL;
 		}
 		msg[0].len = data->block[0] + 2;
 		for (i = 1; i < msg[0].len; i++)
@@ -1559,7 +1565,7 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter * adapter, u16 addr,
 				dev_err(&adapter->dev, "i2c_smbus_xfer_emulated called with "
 				       "invalid block write size (%d)\n",
 				       data->block[0]);
-				return -1;
+				return -EINVAL;
 			}
 			for (i = 1; i <= data->block[0]; i++)
 				msgbuf0[i] = data->block[i];
@@ -1568,7 +1574,7 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter * adapter, u16 addr,
 	default:
 		dev_err(&adapter->dev, "smbus_access called with invalid size (%d)\n",
 		       size);
-		return -1;
+		return -EINVAL;
 	}
 
 	i = ((flags & I2C_CLIENT_PEC) && size != I2C_SMBUS_QUICK
@@ -1586,13 +1592,13 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter * adapter, u16 addr,
 			msg[num-1].len++;
 	}
 
-	if (i2c_transfer(adapter, msg, num) < 0)
-		return -1;
+	if ((ret = i2c_transfer(adapter, msg, num)) < 0)
+		return ret;
 
 	/* Check PEC if last message is a read */
 	if (i && (msg[num-1].flags & I2C_M_RD)) {
-		if (i2c_smbus_check_pec(partial_pec, &msg[num-1]) < 0)
-			return -1;
+		if ((ret = i2c_smbus_check_pec(partial_pec, &msg[num-1])) < 0)
+			return ret;
 	}
 
 	if (read_write == I2C_SMBUS_READ)


Lothar Waﬂmann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstraﬂe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch‰ftsf¸hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org
___________________________________________________________


--===============1523860795837368437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============1523860795837368437==--
