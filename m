From: Ed Swierk <eswierk-BGArkANP9klv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] rtc-ds1307: True SMBus compatibility
Date: Mon, 26 Jan 2009 13:54:22 -0800
Message-ID: <1233006862.19874.17.camel@localhost.localdomain>
References: <1231177261.13443.20.camel@localhost.localdomain>
	 <20090120114304.3b956189@hyperion.delvare>
	 <1232951630.1329.4.camel@localhost.localdomain>
	 <200901261306.21059.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200901261306.21059.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew
List-Id: linux-i2c@vger.kernel.org

On Mon, 2009-01-26 at 13:06 -0800, David Brownell wrote:
> I have two patch format issues:
> 
>  - Always put a line of whitespace after variable
>    declarations.
> 
>  - Include text like the above as part of the patch,
>    even if you're stuck with a mailer that mangles
>    non-attached text.
> 
> You're using Evolution, which is mentioned in the
> Documentation/email-clients.txt file as having a
> way (albeit awkward) to send normal patch email.
> 
> Given those changes:
> 
>   Acked-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> 
> Thanks.

Thanks for the feedback.  Here you go:

Allow the rtc-ds1307 driver to work with SMBus controllers like nforce2
that do not support i2c block transfers.

Signed-off-by: Ed Swierk <eswierk-BGArkANP9klv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>

Index: linux-2.6.27.4/drivers/rtc/rtc-ds1307.c
===================================================================
--- linux-2.6.27.4.orig/drivers/rtc/rtc-ds1307.c
+++ linux-2.6.27.4/drivers/rtc/rtc-ds1307.c
@@ -94,6 +94,10 @@ struct ds1307 {
 	struct i2c_client	*client;
 	struct rtc_device	*rtc;
 	struct work_struct	work;
+	s32 (*read_block_data)(struct i2c_client *client, u8 command,
+			       u8 length, u8 *values);
+	s32 (*write_block_data)(struct i2c_client *client, u8 command,
+				u8 length, const u8 *values);
 };
 
 struct chip_desc {
@@ -132,6 +136,79 @@ MODULE_DEVICE_TABLE(i2c, ds1307_id);
 
 /*----------------------------------------------------------------------*/
 
+#define BLOCK_DATA_MAX_TRIES 10
+
+static s32 ds1307_read_block_data_once(struct i2c_client *client, u8 command,
+				  u8 length, u8 *values)
+{
+	s32 i, data;
+
+	for (i = 0; i < length; i++) {
+		data = i2c_smbus_read_byte_data(client, command + i);
+		if (data < 0)
+			return data;
+		values[i] = data;
+	}
+	return i;
+}
+
+static s32 ds1307_read_block_data(struct i2c_client *client, u8 command,
+				  u8 length, u8 *values)
+{
+	u8 oldvalues[I2C_SMBUS_BLOCK_MAX];
+	s32 ret;
+	int tries = 0;
+
+	dev_dbg(&client->dev, "ds1307_read_block_data (length=%d)\n", length);
+	ret = ds1307_read_block_data_once(client, command, length, values);
+	if (ret < 0)
+		return ret;
+	do {
+		if (++tries > BLOCK_DATA_MAX_TRIES) {
+			dev_err(&client->dev,
+				"ds1307_read_block_data failed\n");
+			return -EIO;
+		}
+		memcpy(oldvalues, values, length);
+		ret = ds1307_read_block_data_once(client, command, length,
+						  values);
+		if (ret < 0)
+			return ret;
+	} while (memcmp(oldvalues, values, length));
+	return length;
+}
+
+static s32 ds1307_write_block_data(struct i2c_client *client, u8 command,
+				   u8 length, const u8 *values)
+{
+	u8 currvalues[I2C_SMBUS_BLOCK_MAX];
+	int tries = 0;
+
+	dev_dbg(&client->dev, "ds1307_write_block_data (length=%d)\n", length);
+	do {
+		s32 i, ret;
+
+		if (++tries > BLOCK_DATA_MAX_TRIES) {
+			dev_err(&client->dev,
+				"ds1307_write_block_data failed\n");
+			return -EIO;
+		}
+		for (i = 0; i < length; i++) {
+			ret = i2c_smbus_write_byte_data(client, command + i,
+							values[i]);
+			if (ret < 0)
+				return ret;
+		}
+		ret = ds1307_read_block_data_once(client, command, length,
+						  currvalues);
+		if (ret < 0)
+			return ret;
+	} while (memcmp(currvalues, values, length));
+	return length;
+}
+
+/*----------------------------------------------------------------------*/
+
 /*
  * The IRQ logic includes a "real" handler running in IRQ context just
  * long enough to schedule this workqueue entry.   We need a task context
@@ -202,7 +279,7 @@ static int ds1307_get_time(struct device
 	int		tmp;
 
 	/* read the RTC date and time registers all at once */
-	tmp = i2c_smbus_read_i2c_block_data(ds1307->client,
+	tmp = ds1307->read_block_data(ds1307->client,
 		DS1307_REG_SECS, 7, ds1307->regs);
 	if (tmp != 7) {
 		dev_err(dev, "%s error %d\n", "read", tmp);
@@ -279,7 +356,7 @@ static int ds1307_set_time(struct device
 		"write", buf[0], buf[1], buf[2], buf[3],
 		buf[4], buf[5], buf[6]);
 
-	result = i2c_smbus_write_i2c_block_data(ds1307->client, 0, 7, buf);
+	result = ds1307->write_block_data(ds1307->client, 0, 7, buf);
 	if (result < 0) {
 		dev_err(dev, "%s error %d\n", "write", result);
 		return result;
@@ -297,7 +374,7 @@ static int ds1307_read_alarm(struct devi
 		return -EINVAL;
 
 	/* read all ALARM1, ALARM2, and status registers at once */
-	ret = i2c_smbus_read_i2c_block_data(client,
+	ret = ds1307->read_block_data(client,
 			DS1339_REG_ALARM1_SECS, 9, ds1307->regs);
 	if (ret != 9) {
 		dev_err(dev, "%s error %d\n", "alarm read", ret);
@@ -356,7 +433,7 @@ static int ds1307_set_alarm(struct devic
 		t->enabled, t->pending);
 
 	/* read current status of both alarms and the chip */
-	ret = i2c_smbus_read_i2c_block_data(client,
+	ret = ds1307->read_block_data(client,
 			DS1339_REG_ALARM1_SECS, 9, buf);
 	if (ret != 9) {
 		dev_err(dev, "%s error %d\n", "alarm write", ret);
@@ -391,7 +468,7 @@ static int ds1307_set_alarm(struct devic
 	}
 	buf[8] = status & ~(DS1337_BIT_A1I | DS1337_BIT_A2I);
 
-	ret = i2c_smbus_write_i2c_block_data(client,
+	ret = ds1307->write_block_data(client,
 			DS1339_REG_ALARM1_SECS, 9, buf);
 	if (ret < 0) {
 		dev_err(dev, "can't set alarm time\n");
@@ -479,7 +556,7 @@ ds1307_nvram_read(struct kobject *kobj, 
 	if (unlikely(!count))
 		return count;
 
-	result = i2c_smbus_read_i2c_block_data(client, 8 + off, count, buf);
+	result = ds1307->read_block_data(client, 8 + off, count, buf);
 	if (result < 0)
 		dev_err(&client->dev, "%s error %d\n", "nvram read", result);
 	return result;
@@ -490,9 +567,11 @@ ds1307_nvram_write(struct kobject *kobj,
 		char *buf, loff_t off, size_t count)
 {
 	struct i2c_client	*client;
+	struct ds1307		*ds1307;
 	int			result;
 
 	client = kobj_to_i2c_client(kobj);
+	ds1307 = i2c_get_clientdata(client);
 
 	if (unlikely(off >= NVRAM_SIZE))
 		return -EFBIG;
@@ -501,7 +580,7 @@ ds1307_nvram_write(struct kobject *kobj,
 	if (unlikely(!count))
 		return count;
 
-	result = i2c_smbus_write_i2c_block_data(client, 8 + off, count, buf);
+	result = ds1307->write_block_data(client, 8 + off, count, buf);
 	if (result < 0) {
 		dev_err(&client->dev, "%s error %d\n", "nvram write", result);
 		return result;
@@ -536,9 +615,8 @@ static int __devinit ds1307_probe(struct
 	int			want_irq = false;
 	unsigned char		*buf;
 
-	if (!i2c_check_functionality(adapter,
-			I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
-			I2C_FUNC_SMBUS_I2C_BLOCK))
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)
+	    && !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
 		return -EIO;
 
 	if (!(ds1307 = kzalloc(sizeof(struct ds1307), GFP_KERNEL)))
@@ -548,6 +626,13 @@ static int __devinit ds1307_probe(struct
 	i2c_set_clientdata(client, ds1307);
 	ds1307->type = id->driver_data;
 	buf = ds1307->regs;
+	if (i2c_check_functionality(adapter, I2C_FUNC_SMBUS_I2C_BLOCK)) {
+		ds1307->read_block_data = i2c_smbus_read_i2c_block_data;
+		ds1307->write_block_data = i2c_smbus_write_i2c_block_data;
+	} else {
+		ds1307->read_block_data = ds1307_read_block_data;
+		ds1307->write_block_data = ds1307_write_block_data;
+	}
 
 	switch (ds1307->type) {
 	case ds_1337:
@@ -558,7 +643,7 @@ static int __devinit ds1307_probe(struct
 			want_irq = true;
 		}
 		/* get registers that the "rtc" read below won't read... */
-		tmp = i2c_smbus_read_i2c_block_data(ds1307->client,
+		tmp = ds1307->read_block_data(ds1307->client,
 				DS1337_REG_CONTROL, 2, buf);
 		if (tmp != 2) {
 			pr_debug("read error %d\n", tmp);
@@ -596,7 +681,7 @@ static int __devinit ds1307_probe(struct
 
 read_rtc:
 	/* read RTC registers */
-	tmp = i2c_smbus_read_i2c_block_data(ds1307->client, 0, 8, buf);
+	tmp = ds1307->read_block_data(ds1307->client, 0, 8, buf);
 	if (tmp != 8) {
 		pr_debug("read error %d\n", tmp);
 		err = -EIO;
