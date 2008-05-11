From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.26-rc1-git] i2c-core: return -Errno, not -1
Date: Sun, 11 May 2008 15:16:07 -0700
Message-ID: <200805111516.08453.david-b@pacbell.net>
References: <200805031306.16698.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200805031306.16698.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Disposition: inline
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

More updates to the I2C stack's fault reporting:  make the core stop
returning "-1" (usually "-EPERM") for all faults.  Instead, pass lower
level fault code up the stack, or return some appropriate errno.

This patch happens to touch almost exclusively SMBus calls.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
This is an updated version of:
	http://marc.info/?l=i2c&m=120984528415259&w=2
with some return codes updated to address feedback from the similar
patch for the x86 I2C/SMBus adapters.

 drivers/i2c/i2c-core.c |   78 +++++++++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 34 deletions(-)

--- g26.orig/drivers/i2c/i2c-core.c	2008-05-11 13:07:56.000000000 -0700
+++ g26/drivers/i2c/i2c-core.c	2008-05-11 15:09:00.000000000 -0700
@@ -981,7 +981,7 @@ int i2c_transfer(struct i2c_adapter * ad
 		return ret;
 	} else {
 		dev_dbg(&adap->dev, "I2C level transfers not supported\n");
-		return -ENOSYS;
+		return -EOPNOTSUPP;
 	}
 }
 EXPORT_SYMBOL(i2c_transfer);
@@ -1113,7 +1113,7 @@ int i2c_probe(struct i2c_adapter *adapte
 
 		dev_warn(&adapter->dev, "SMBus Quick command not supported, "
 			 "can't probe for chips\n");
-		return -1;
+		return -EOPNOTSUPP;
 	}
 
 	/* Probe entries are done second, and are not affected by ignore
@@ -1305,7 +1305,7 @@ static int i2c_smbus_check_pec(u8 cpec, 
 	if (rpec != cpec) {
 		pr_debug("i2c-core: Bad PEC 0x%02x vs. 0x%02x\n",
 			rpec, cpec);
-		return -1;
+		return -EBADMSG;
 	}
 	return 0;
 }
@@ -1320,11 +1320,12 @@ EXPORT_SYMBOL(i2c_smbus_write_quick);
 s32 i2c_smbus_read_byte(struct i2c_client *client)
 {
 	union i2c_smbus_data data;
-	if (i2c_smbus_xfer(client->adapter,client->addr,client->flags,
-	                   I2C_SMBUS_READ,0,I2C_SMBUS_BYTE, &data))
-		return -1;
-	else
-		return data.byte;
+	int status;
+
+	status = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+			I2C_SMBUS_READ, 0,
+			I2C_SMBUS_BYTE, &data);
+	return (status < 0) ? status : data.byte;
 }
 EXPORT_SYMBOL(i2c_smbus_read_byte);
 
@@ -1338,11 +1339,12 @@ EXPORT_SYMBOL(i2c_smbus_write_byte);
 s32 i2c_smbus_read_byte_data(struct i2c_client *client, u8 command)
 {
 	union i2c_smbus_data data;
-	if (i2c_smbus_xfer(client->adapter,client->addr,client->flags,
-	                   I2C_SMBUS_READ,command, I2C_SMBUS_BYTE_DATA,&data))
-		return -1;
-	else
-		return data.byte;
+	int status;
+
+	status = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+			I2C_SMBUS_READ, command,
+			I2C_SMBUS_BYTE_DATA, &data);
+	return (status < 0) ? status : data.byte;
 }
 EXPORT_SYMBOL(i2c_smbus_read_byte_data);
 
@@ -1359,11 +1361,12 @@ EXPORT_SYMBOL(i2c_smbus_write_byte_data)
 s32 i2c_smbus_read_word_data(struct i2c_client *client, u8 command)
 {
 	union i2c_smbus_data data;
-	if (i2c_smbus_xfer(client->adapter,client->addr,client->flags,
-	                   I2C_SMBUS_READ,command, I2C_SMBUS_WORD_DATA, &data))
-		return -1;
-	else
-		return data.word;
+	int status;
+
+	status = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+			I2C_SMBUS_READ, command,
+			I2C_SMBUS_WORD_DATA,  &data);
+	return (status < 0) ? status : data.word;
 }
 EXPORT_SYMBOL(i2c_smbus_read_word_data);
 
@@ -1397,11 +1400,13 @@ s32 i2c_smbus_read_block_data(struct i2c
 			      u8 *values)
 {
 	union i2c_smbus_data data;
+	int status;
 
-	if (i2c_smbus_xfer(client->adapter, client->addr, client->flags,
-	                   I2C_SMBUS_READ, command,
-	                   I2C_SMBUS_BLOCK_DATA, &data))
-		return -1;
+	status = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+			I2C_SMBUS_READ, command,
+			I2C_SMBUS_BLOCK_DATA, &data);
+	if (status)
+		return status;
 
 	memcpy(values, &data.block[1], data.block[0]);
 	return data.block[0];
@@ -1428,14 +1433,16 @@ s32 i2c_smbus_read_i2c_block_data(struct
 				  u8 length, u8 *values)
 {
 	union i2c_smbus_data data;
+	int status;
 
 	if (length > I2C_SMBUS_BLOCK_MAX)
 		length = I2C_SMBUS_BLOCK_MAX;
 	data.block[0] = length;
-	if (i2c_smbus_xfer(client->adapter,client->addr,client->flags,
-	                      I2C_SMBUS_READ,command,
-	                      I2C_SMBUS_I2C_BLOCK_DATA,&data))
-		return -1;
+	status = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+			I2C_SMBUS_READ, command,
+			I2C_SMBUS_I2C_BLOCK_DATA, &data);
+	if (status < 0)
+		return status;
 
 	memcpy(values, &data.block[1], data.block[0]);
 	return data.block[0];
@@ -1476,6 +1483,7 @@ static s32 i2c_smbus_xfer_emulated(struc
 	                        };
 	int i;
 	u8 partial_pec = 0;
+	int status;
 
 	msgbuf0[0] = command;
 	switch(size) {
@@ -1528,7 +1536,7 @@ static s32 i2c_smbus_xfer_emulated(struc
 				dev_err(&adapter->dev, "smbus_access called with "
 				       "invalid block write size (%d)\n",
 				       data->block[0]);
-				return -1;
+				return -EINVAL;
 			}
 			for (i = 1; i < msg[0].len; i++)
 				msgbuf0[i] = data->block[i-1];
@@ -1541,7 +1549,7 @@ static s32 i2c_smbus_xfer_emulated(struc
 			dev_err(&adapter->dev, "%s called with invalid "
 				"block proc call size (%d)\n", __func__,
 				data->block[0]);
-			return -1;
+			return -EINVAL;
 		}
 		msg[0].len = data->block[0] + 2;
 		for (i = 1; i < msg[0].len; i++)
@@ -1559,7 +1567,7 @@ static s32 i2c_smbus_xfer_emulated(struc
 				dev_err(&adapter->dev, "i2c_smbus_xfer_emulated called with "
 				       "invalid block write size (%d)\n",
 				       data->block[0]);
-				return -1;
+				return -EINVAL;
 			}
 			for (i = 1; i <= data->block[0]; i++)
 				msgbuf0[i] = data->block[i];
@@ -1568,7 +1576,7 @@ static s32 i2c_smbus_xfer_emulated(struc
 	default:
 		dev_err(&adapter->dev, "smbus_access called with invalid size (%d)\n",
 		       size);
-		return -1;
+		return -EOPNOTSUPP;
 	}
 
 	i = ((flags & I2C_CLIENT_PEC) && size != I2C_SMBUS_QUICK
@@ -1586,13 +1594,15 @@ static s32 i2c_smbus_xfer_emulated(struc
 			msg[num-1].len++;
 	}
 
-	if (i2c_transfer(adapter, msg, num) < 0)
-		return -1;
+	status = i2c_transfer(adapter, msg, num);
+	if (status < 0)
+		return status;
 
 	/* Check PEC if last message is a read */
 	if (i && (msg[num-1].flags & I2C_M_RD)) {
-		if (i2c_smbus_check_pec(partial_pec, &msg[num-1]) < 0)
-			return -1;
+		status = i2c_smbus_check_pec(partial_pec, &msg[num-1]);
+		if (status < 0)
+			return status;
 	}
 
 	if (read_write == I2C_SMBUS_READ)

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
