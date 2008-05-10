From: David Brownell <david-b@pacbell.net>
Subject: Re: [i2c] [RFC][PATCH 4/4] RTC: SMBus support for the M41T80,
Date: Sat, 10 May 2008 09:36:50 -0700
Message-ID: <200805100936.52057.david-b@pacbell.net>
References: <200805070120.03821.david-b@pacbell.net> <Pine.LNX.4.55.0805100301100.10552@cliff.in.clinika.pl> <20080510085340.29c26aef@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20080510085340.29c26aef@hyperion.delvare>
Content-Disposition: inline
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Jean Delvare <khali@linux-fr.org>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, linux-mips@linux-mips.org, mgreer@mvista.com, rtc-linux@googlegroups.com, Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-kernel@vger.kernel.org, i2c@lm-sensors.org, ab@mycable.de, Alessandro Zummo <alessandro.zummo@towertech.it>
List-Id: linux-i2c@vger.kernel.org

On Friday 09 May 2008, Jean Delvare wrote:
>=20
> > > On a related note, you will notice that the other i2c_smbus_* fun=
ctions
> > > do not follow the naming of SMBus transactions. Again that's some=
thing
> > > I regret but I feel that changing the names now would cause a lot=
 of
> > > confusion amongst developers, so I'm not doing it.
> >=20
> > It may not be worth the effort, but if done in bulk for all the use=
rs in
> > the tree, there should be no problem with that. =A0...
>=20
> It's not that easy. There are some drivers which are both in-tree and
> out-of-tree, for which such a change means adding ifdefs.

Actually, I thought it *WAS* that easy.  See the appended patch,
which goes on top of the various doc and (mostly SMBus) fault
handling patches I've sent ... the old names are still available
(only needed by out-of-tree drivers), but marked as __deprecated.
So:  no #ifdefs required.

I agree it's not worth while for *all* the SMBus functions that
use names-made-up-for-Linux.  But for the two which are really
badly misnamed (after *different* SMBus operations), I suggest
fixing would be a reasonable thing.


> And there is=20
> i2c-dev.h (the user-space one) which has similar functions,

That's problematic in its own right though.  Not only that
the *kernel* file Documentation/i2c/dev-interface referring
to those functions, which are unavailable from the header
provided by the kernel.  Or that there's no relationship
between the kernel and userspace files of the same name.
But also that those functions are actually a bit too large
to be appropriate as inlines, even once you manage to track
it down (as part of a "tools" package, not a "library").


> if we=20
> rename only the kernel variants, there will be some confusion. But if
> we rename also the user-space variants, then it's up to 2.4 kernel
> users to have different names for kernel-space and user-space functio=
ns.

True, but that would be a question for a "libsmbus" or somesuch
to deal with.  Not a kernel issue.

- Dave


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Two of the SMBus operations are using confusingly inappropriate names:

  i2c_smbus_read_byte() does not execute the SMBus "Read Byte" protocol
  	... it implements the SMBus "Receive Byte" protocol instead!!

  i2c_smbus_write_byte() does not execute the SMBus "Write Byte" protoc=
ol
  	... it implements the SMBus "Send Byte" protocol instead!!

This patch changes the names of those functions, so they no longer
use names of different operations (which they do not implement).

---
 Documentation/i2c/chips/max6875   |    4 ++--
 Documentation/i2c/smbus-protocol  |   12 +++++-------
 Documentation/i2c/writing-clients |    4 ++--
 drivers/gpio/pcf857x.c            |    8 ++++----
 drivers/hwmon/ds1621.c            |    2 +-
 drivers/hwmon/lm90.c              |    2 +-
 drivers/i2c/chips/eeprom.c        |   10 +++++-----
 drivers/i2c/chips/max6875.c       |    2 +-
 drivers/i2c/chips/pcf8574.c       |    4 ++--
 drivers/i2c/chips/pcf8591.c       |   10 +++++-----
 drivers/i2c/chips/tsl2550.c       |   16 ++++++++--------
 drivers/i2c/i2c-core.c            |   12 ++++++------
 drivers/media/video/saa7110.c     |    2 +-
 drivers/media/video/saa7185.c     |    2 +-
 drivers/media/video/tda9840.c     |    8 ++++----
 drivers/media/video/tea6415c.c    |    4 ++--
 drivers/media/video/tea6420.c     |    4 ++--
 drivers/w1/masters/ds2482.c       |   10 +++++-----
 include/linux/i2c.h               |   20 ++++++++++++++++++--
 19 files changed, 75 insertions(+), 61 deletions(-)

--- g26.orig/include/linux/i2c.h	2008-05-07 16:32:18.000000000 -0700
+++ g26/include/linux/i2c.h	2008-05-10 00:13:48.000000000 -0700
@@ -73,8 +73,8 @@ extern s32 i2c_smbus_xfer (struct i2c_ad
    conventions of smbus_access. */
=20
 extern s32 i2c_smbus_write_quick(struct i2c_client * client, u8 value)=
;
-extern s32 i2c_smbus_read_byte(struct i2c_client * client);
-extern s32 i2c_smbus_write_byte(struct i2c_client * client, u8 value);
+extern s32 i2c_smbus_receive_byte(struct i2c_client *client);
+extern s32 i2c_smbus_send_byte(struct i2c_client *client, u8 value);
 extern s32 i2c_smbus_read_byte_data(struct i2c_client * client, u8 com=
mand);
 extern s32 i2c_smbus_write_byte_data(struct i2c_client * client,
                                      u8 command, u8 value);
@@ -94,6 +94,22 @@ extern s32 i2c_smbus_write_i2c_block_dat
 					  u8 command, u8 length,
 					  const u8 *values);
=20
+/* Stop using these legacy names in new code.
+ * - the SMBus "Read Byte" operation is i2c_smbus_read_byte_data()
+ * - the SMBus "Write Byte" operation is i2c_smbus_write_byte_data()
+ *
+ */
+static inline s32 __deprecated i2c_smbus_read_byte(struct i2c_client *=
client)
+{
+	return i2c_smbus_receive_byte(client);
+}
+
+static inline s32 __deprecated i2c_smbus_write_byte(struct i2c_client =
*client,
+		u8 value)
+{
+	return i2c_smbus_send_byte(client, value);
+}
+
 /*
  * A driver is capable of handling one or more physical devices presen=
t on
  * I2C adapters. This information is used to inform the driver of adap=
ter
--- g26.orig/drivers/i2c/i2c-core.c	2008-05-07 16:32:18.000000000 -0700
+++ g26/drivers/i2c/i2c-core.c	2008-05-10 00:08:45.000000000 -0700
@@ -1529,13 +1529,13 @@ s32 i2c_smbus_write_quick(struct i2c_cli
 EXPORT_SYMBOL(i2c_smbus_write_quick);
=20
 /**
- * i2c_smbus_read_byte - SMBus "receive byte" protocol
+ * i2c_smbus_receive_byte - SMBus "receive byte" protocol
  * @client: Handle to slave device
  *
  * This executes the SMBus "receive byte" protocol, returning negative=
 errno
  * else the byte received from the device.
  */
-s32 i2c_smbus_read_byte(struct i2c_client *client)
+s32 i2c_smbus_receive_byte(struct i2c_client *client)
 {
 	union i2c_smbus_data data;
 	int status;
@@ -1545,22 +1545,22 @@ s32 i2c_smbus_read_byte(struct i2c_clien
 			I2C_SMBUS_BYTE, &data);
 	return (status < 0) ? status : data.byte;
 }
-EXPORT_SYMBOL(i2c_smbus_read_byte);
+EXPORT_SYMBOL(i2c_smbus_receive_byte);
=20
 /**
- * i2c_smbus_write_byte - SMBus "send byte" protocol
+ * i2c_smbus_send_byte - SMBus "send byte" protocol
  * @client: Handle to slave device
  * @value: Byte to be sent
  *
  * This executes the SMBus "send byte" protocol, returning negative er=
rno
  * else zero on success.
  */
-s32 i2c_smbus_write_byte(struct i2c_client *client, u8 value)
+s32 i2c_smbus_send_byte(struct i2c_client *client, u8 value)
 {
 	return i2c_smbus_xfer(client->adapter,client->addr,client->flags,
 	                      I2C_SMBUS_WRITE, value, I2C_SMBUS_BYTE, NULL);
 }
-EXPORT_SYMBOL(i2c_smbus_write_byte);
+EXPORT_SYMBOL(i2c_smbus_send_byte);
=20
 /**
  * i2c_smbus_read_byte_data - SMBus "read byte" protocol
--- g26.orig/Documentation/i2c/chips/max6875	2007-07-12 16:32:15.000000=
000 -0700
+++ g26/Documentation/i2c/chips/max6875	2008-05-10 00:07:50.000000000 -=
0700
@@ -88,14 +88,14 @@ To write 0x5a to address 0x8003:
=20
 Reading data from the EEPROM is a little more complicated.
 Use i2c_smbus_write_byte_data() to set the read address and then
-i2c_smbus_read_byte() or i2c_smbus_read_i2c_block_data() to read the d=
ata.
+i2c_smbus_receive_byte() or i2c_smbus_read_i2c_block_data() to read th=
e data.
=20
 Example:
 To read data starting at offset 0x8100, first set the address:
   i2c_smbus_write_byte_data(fd, 0x81, 0x00);
=20
 And then read the data
-  value =3D i2c_smbus_read_byte(fd);
+  value =3D i2c_smbus_receive_byte(fd);
=20
   or
=20
--- g26.orig/Documentation/i2c/smbus-protocol	2008-05-10 00:13:59.00000=
0000 -0700
+++ g26/Documentation/i2c/smbus-protocol	2008-05-10 00:15:14.000000000 =
-0700
@@ -18,9 +18,7 @@ handled at all on most pure SMBus adapte
=20
 Below is a list of SMBus protocol operations, and the functions execut=
ing
 them.  Note that the names used in the SMBus protocol specifications u=
sually
-don't match these function names.  For some of the operations which pa=
ss a
-single data byte, the functions using SMBus protocol operation names e=
xecute
-a different protocol operation entirely.
+don't match these function names.
=20
=20
 Key to symbols
@@ -49,8 +47,8 @@ This sends a single bit to the device, a
 A Addr Rd/Wr [A] P
=20
=20
-SMBus Receive Byte:  i2c_smbus_read_byte()
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SMBus Receive Byte:  i2c_smbus_receive_byte()
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 This reads a single byte from a device, without specifying a device
 register. Some devices are so simple that this interface is enough; fo=
r
@@ -60,8 +58,8 @@ the previous SMBus command.
 S Addr Rd [A] [Data] NA P
=20
=20
-SMBus Send Byte:  i2c_smbus_write_byte()
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+SMBus Send Byte:  i2c_smbus_send_byte()
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 This operation is the reverse of Receive Byte: it sends a single byte
 to a device.  See Receive Byte for more information.
--- g26.orig/Documentation/i2c/writing-clients	2008-04-29 21:51:55.0000=
00000 -0700
+++ g26/Documentation/i2c/writing-clients	2008-05-10 00:07:50.000000000=
 -0700
@@ -560,8 +560,8 @@ SMBus communication
=20
=20
   extern s32 i2c_smbus_write_quick(struct i2c_client * client, u8 valu=
e);
-  extern s32 i2c_smbus_read_byte(struct i2c_client * client);
-  extern s32 i2c_smbus_write_byte(struct i2c_client * client, u8 value=
);
+  extern s32 i2c_smbus_receive_byte(struct i2c_client * client);
+  extern s32 i2c_smbus_send_byte(struct i2c_client * client, u8 value)=
;
   extern s32 i2c_smbus_read_byte_data(struct i2c_client * client, u8 c=
ommand);
   extern s32 i2c_smbus_write_byte_data(struct i2c_client * client,
                                        u8 command, u8 value);
--- g26.orig/drivers/gpio/pcf857x.c	2008-05-07 16:32:18.000000000 -0700
+++ g26/drivers/gpio/pcf857x.c	2008-05-10 00:07:50.000000000 -0700
@@ -68,7 +68,7 @@ static int pcf857x_input8(struct gpio_ch
 	struct pcf857x	*gpio =3D container_of(chip, struct pcf857x, chip);
=20
 	gpio->out |=3D (1 << offset);
-	return i2c_smbus_write_byte(gpio->client, gpio->out);
+	return i2c_smbus_send_byte(gpio->client, gpio->out);
 }
=20
 static int pcf857x_get8(struct gpio_chip *chip, unsigned offset)
@@ -76,7 +76,7 @@ static int pcf857x_get8(struct gpio_chip
 	struct pcf857x	*gpio =3D container_of(chip, struct pcf857x, chip);
 	s32		value;
=20
-	value =3D i2c_smbus_read_byte(gpio->client);
+	value =3D i2c_smbus_receive_byte(gpio->client);
 	return (value < 0) ? 0 : (value & (1 << offset));
 }
=20
@@ -89,7 +89,7 @@ static int pcf857x_output8(struct gpio_c
 		gpio->out |=3D bit;
 	else
 		gpio->out &=3D ~bit;
-	return i2c_smbus_write_byte(gpio->client, gpio->out);
+	return i2c_smbus_send_byte(gpio->client, gpio->out);
 }
=20
 static void pcf857x_set8(struct gpio_chip *chip, unsigned offset, int =
value)
@@ -202,7 +202,7 @@ static int pcf857x_probe(struct i2c_clie
=20
 		/* fail if there's no chip present */
 		else
-			status =3D i2c_smbus_read_byte(client);
+			status =3D i2c_smbus_receive_byte(client);
=20
 	/* '75/'75c addresses are 0x20..0x27, just like the '74;
 	 * the '75c doesn't have a current source pulling high.
--- g26.orig/drivers/hwmon/ds1621.c	2008-03-28 11:08:28.000000000 -0700
+++ g26/drivers/hwmon/ds1621.c	2008-05-10 00:07:50.000000000 -0700
@@ -132,7 +132,7 @@ static void ds1621_init_client(struct i2
 	ds1621_write_value(client, DS1621_REG_CONF, reg);
 =09
 	/* start conversion */
-	i2c_smbus_write_byte(client, DS1621_COM_START);
+	i2c_smbus_send_byte(client, DS1621_COM_START);
 }
=20
 static ssize_t show_temp(struct device *dev, struct device_attribute *=
da,
--- g26.orig/drivers/hwmon/lm90.c	2008-03-28 11:08:29.000000000 -0700
+++ g26/drivers/hwmon/lm90.c	2008-05-10 00:07:50.000000000 -0700
@@ -463,7 +463,7 @@ static int lm90_read_reg(struct i2c_clie
  	if (client->flags & I2C_CLIENT_PEC) {
  		err =3D adm1032_write_byte(client, reg);
  		if (err >=3D 0)
- 			err =3D i2c_smbus_read_byte(client);
+			err =3D i2c_smbus_receive_byte(client);
  	} else
  		err =3D i2c_smbus_read_byte_data(client, reg);
=20
--- g26.orig/drivers/i2c/chips/eeprom.c	2008-03-28 11:08:29.000000000 -=
0700
+++ g26/drivers/i2c/chips/eeprom.c	2008-05-10 00:07:50.000000000 -0700
@@ -93,12 +93,12 @@ static void eeprom_update_client(struct=20
 							!=3D 32)
 					goto exit;
 		} else {
-			if (i2c_smbus_write_byte(client, slice << 5)) {
+			if (i2c_smbus_send_byte(client, slice << 5)) {
 				dev_dbg(&client->dev, "eeprom read start has failed!\n");
 				goto exit;
 			}
 			for (i =3D slice << 5; i < (slice + 1) << 5; i++) {
-				j =3D i2c_smbus_read_byte(client);
+				j =3D i2c_smbus_receive_byte(client);
 				if (j < 0)
 					goto exit;
 				data->data[i] =3D (u8) j;
@@ -208,9 +208,9 @@ static int eeprom_detect(struct i2c_adap
 		char name[4];
=20
 		name[0] =3D i2c_smbus_read_byte_data(new_client, 0x80);
-		name[1] =3D i2c_smbus_read_byte(new_client);
-		name[2] =3D i2c_smbus_read_byte(new_client);
-		name[3] =3D i2c_smbus_read_byte(new_client);
+		name[1] =3D i2c_smbus_receive_byte(new_client);
+		name[2] =3D i2c_smbus_receive_byte(new_client);
+		name[3] =3D i2c_smbus_receive_byte(new_client);
=20
 		if (!memcmp(name, "PCG-", 4) || !memcmp(name, "VGN-", 4)) {
 			dev_info(&new_client->dev, "Vaio EEPROM detected, "
--- g26.orig/drivers/i2c/chips/max6875.c	2008-03-28 10:42:32.000000000 =
-0700
+++ g26/drivers/i2c/chips/max6875.c	2008-05-10 00:07:50.000000000 -0700
@@ -112,7 +112,7 @@ static void max6875_update_slice(struct=20
 			}
 		} else {
 			for (i =3D 0; i < SLICE_SIZE; i++) {
-				j =3D i2c_smbus_read_byte(client);
+				j =3D i2c_smbus_receive_byte(client);
 				if (j < 0) {
 					goto exit_up;
 				}
--- g26.orig/drivers/i2c/chips/pcf8574.c	2008-03-28 11:08:29.000000000 =
-0700
+++ g26/drivers/i2c/chips/pcf8574.c	2008-05-10 00:07:50.000000000 -0700
@@ -75,7 +75,7 @@ static struct i2c_driver pcf8574_driver=20
 static ssize_t show_read(struct device *dev, struct device_attribute *=
attr, char *buf)
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
-	return sprintf(buf, "%u\n", i2c_smbus_read_byte(client));
+	return sprintf(buf, "%u\n", i2c_smbus_receive_byte(client));
 }
=20
 static DEVICE_ATTR(read, S_IRUGO, show_read, NULL);
@@ -101,7 +101,7 @@ static ssize_t set_write(struct device *
 		return -EINVAL;
=20
 	data->write =3D val;
-	i2c_smbus_write_byte(client, data->write);
+	i2c_smbus_send_byte(client, data->write);
 	return count;
 }
=20
--- g26.orig/drivers/i2c/chips/pcf8591.c	2008-03-28 11:08:29.000000000 =
-0700
+++ g26/drivers/i2c/chips/pcf8591.c	2008-05-10 00:07:50.000000000 -0700
@@ -149,7 +149,7 @@ static ssize_t set_out0_enable(struct de
 		data->control |=3D PCF8591_CONTROL_AOEF;
 	else
 		data->control &=3D ~PCF8591_CONTROL_AOEF;
-	i2c_smbus_write_byte(client, data->control);
+	i2c_smbus_send_byte(client, data->control);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -288,7 +288,7 @@ static void pcf8591_init_client(struct i
 =09
 	/* The first byte transmitted contains the conversion code of the=20
 	   previous read cycle. FLUSH IT! */
-	i2c_smbus_read_byte(client);
+	i2c_smbus_receive_byte(client);
 }
=20
 static int pcf8591_read_channel(struct device *dev, int channel)
@@ -302,13 +302,13 @@ static int pcf8591_read_channel(struct d
 	if ((data->control & PCF8591_CONTROL_AICH_MASK) !=3D channel) {
 		data->control =3D (data->control & ~PCF8591_CONTROL_AICH_MASK)
 			      | channel;
-		i2c_smbus_write_byte(client, data->control);
+		i2c_smbus_send_byte(client, data->control);
 =09
 		/* The first byte transmitted contains the conversion code of=20
 		   the previous read cycle. FLUSH IT! */
-		i2c_smbus_read_byte(client);
+		i2c_smbus_receive_byte(client);
 	}
-	value =3D i2c_smbus_read_byte(client);
+	value =3D i2c_smbus_receive_byte(client);
=20
 	mutex_unlock(&data->update_lock);
=20
--- g26.orig/drivers/i2c/chips/tsl2550.c	2008-04-29 21:51:56.000000000 =
-0700
+++ g26/drivers/i2c/chips/tsl2550.c	2008-05-10 00:07:50.000000000 -0700
@@ -68,7 +68,7 @@ static int tsl2550_set_operating_mode(st
 {
 	struct tsl2550_data *data =3D i2c_get_clientdata(client);
=20
-	int ret =3D i2c_smbus_write_byte(client, TSL2550_MODE_RANGE[mode]);
+	int ret =3D i2c_smbus_send_byte(client, TSL2550_MODE_RANGE[mode]);
=20
 	data->operating_mode =3D mode;
=20
@@ -81,9 +81,9 @@ static int tsl2550_set_power_state(struc
 	int ret;
=20
 	if (state =3D=3D 0)
-		ret =3D i2c_smbus_write_byte(client, TSL2550_POWER_DOWN);
+		ret =3D i2c_smbus_send_byte(client, TSL2550_POWER_DOWN);
 	else {
-		ret =3D i2c_smbus_write_byte(client, TSL2550_POWER_UP);
+		ret =3D i2c_smbus_send_byte(client, TSL2550_POWER_UP);
=20
 		/* On power up we should reset operating mode also... */
 		tsl2550_set_operating_mode(client, data->operating_mode);
@@ -107,14 +107,14 @@ static int tsl2550_get_adc_value(struct=20
 	 */
 	end =3D jiffies + msecs_to_jiffies(400);
 	while (time_before(jiffies, end)) {
-		i2c_smbus_write_byte(client, cmd);
+		i2c_smbus_send_byte(client, cmd);
=20
 		if (loop++ < 5)
 			mdelay(1);
 		else
 			msleep(1);
=20
-		ret =3D i2c_smbus_read_byte(client);
+		ret =3D i2c_smbus_receive_byte(client);
 		if (ret < 0)
 			return ret;
 		else if (ret & 0x0080)
@@ -342,16 +342,16 @@ static int tsl2550_init_client(struct i2
 	 * Probe the chip. To do so we try to power up the device and then to
 	 * read back the 0x03 code
 	 */
-	err =3D i2c_smbus_write_byte(client, TSL2550_POWER_UP);
+	err =3D i2c_smbus_send_byte(client, TSL2550_POWER_UP);
 	if (err < 0)
 		return err;
 	mdelay(1);
-	if (i2c_smbus_read_byte(client) !=3D TSL2550_POWER_UP)
+	if (i2c_smbus_receive_byte(client) !=3D TSL2550_POWER_UP)
 		return -ENODEV;
 	data->power_state =3D 1;
=20
 	/* Set the default operating mode */
-	err =3D i2c_smbus_write_byte(client,
+	err =3D i2c_smbus_send_byte(client,
 				   TSL2550_MODE_RANGE[data->operating_mode]);
 	if (err < 0)
 		return err;
--- g26.orig/drivers/media/video/saa7110.c	2008-04-24 13:45:59.00000000=
0 -0700
+++ g26/drivers/media/video/saa7110.c	2008-05-10 00:07:51.000000000 -07=
00
@@ -127,7 +127,7 @@ saa7110_write_block (struct i2c_client *
 static inline int
 saa7110_read (struct i2c_client *client)
 {
-	return i2c_smbus_read_byte(client);
+	return i2c_smbus_receive_byte(client);
 }
=20
 /* -------------------------------------------------------------------=
---- */
--- g26.orig/drivers/media/video/saa7185.c	2008-04-24 13:45:59.00000000=
0 -0700
+++ g26/drivers/media/video/saa7185.c	2008-05-10 00:07:51.000000000 -07=
00
@@ -82,7 +82,7 @@ struct saa7185 {
 static inline int
 saa7185_read (struct i2c_client *client)
 {
-	return i2c_smbus_read_byte(client);
+	return i2c_smbus_receive_byte(client);
 }
=20
 static int
--- g26.orig/drivers/media/video/tda9840.c	2008-04-24 13:45:59.00000000=
0 -0700
+++ g26/drivers/media/video/tda9840.c	2008-05-10 00:07:51.000000000 -07=
00
@@ -74,7 +74,7 @@ static int command(struct i2c_client *cl
=20
 		result =3D i2c_smbus_write_byte_data(client, SWITCH, byte);
 		if (result)
-			dprintk("i2c_smbus_write_byte() failed, ret:%d\n", result);
+			dprintk("i2c_smbus_write_byte_data() failed, ret:%d\n", result);
 		break;
=20
 	case TDA9840_LEVEL_ADJUST:
@@ -94,7 +94,7 @@ static int command(struct i2c_client *cl
=20
 		result =3D i2c_smbus_write_byte_data(client, LEVEL_ADJUST, byte);
 		if (result)
-			dprintk("i2c_smbus_write_byte() failed, ret:%d\n", result);
+			dprintk("i2c_smbus_write_byte_data() failed, ret:%d\n", result);
 		break;
=20
 	case TDA9840_STEREO_ADJUST:
@@ -114,7 +114,7 @@ static int command(struct i2c_client *cl
=20
 		result =3D i2c_smbus_write_byte_data(client, STEREO_ADJUST, byte);
 		if (result)
-			dprintk("i2c_smbus_write_byte() failed, ret:%d\n", result);
+			dprintk("i2c_smbus_write_byte_data() failed, ret:%d\n", result);
 		break;
=20
 	case TDA9840_DETECT: {
@@ -144,7 +144,7 @@ static int command(struct i2c_client *cl
=20
 		result =3D i2c_smbus_write_byte_data(client, TEST, byte);
 		if (result)
-			dprintk("i2c_smbus_write_byte() failed, ret:%d\n", result);
+			dprintk("i2c_smbus_write_byte_data() failed, ret:%d\n", result);
 		break;
 	default:
 		return -ENOIOCTLCMD;
--- g26.orig/drivers/media/video/tea6415c.c	2008-04-24 13:45:59.0000000=
00 -0700
+++ g26/drivers/media/video/tea6415c.c	2008-05-10 00:07:51.000000000 -0=
700
@@ -165,9 +165,9 @@ static int switch_matrix(struct i2c_clie
 		break;
 	};
=20
-	ret =3D i2c_smbus_write_byte(client, byte);
+	ret =3D i2c_smbus_send_byte(client, byte);
 	if (ret) {
-		dprintk("i2c_smbus_write_byte() failed, ret:%d\n", ret);
+		dprintk("i2c_smbus_send_byte() failed, ret:%d\n", ret);
 		return -EIO;
 	}
=20
--- g26.orig/drivers/media/video/tea6420.c	2008-04-24 13:45:59.00000000=
0 -0700
+++ g26/drivers/media/video/tea6420.c	2008-05-10 00:07:51.000000000 -07=
00
@@ -79,9 +79,9 @@ static int tea6420_switch(struct i2c_cli
 		break;
 	}
=20
-	ret =3D i2c_smbus_write_byte(client, byte);
+	ret =3D i2c_smbus_send_byte(client, byte);
 	if (ret) {
-		dprintk("i2c_smbus_write_byte() failed, ret:%d\n", ret);
+		dprintk("i2c_smbus_send_byte() failed, ret:%d\n", ret);
 		return -EIO;
 	}
=20
--- g26.orig/drivers/w1/masters/ds2482.c	2008-03-28 10:42:44.000000000 =
-0700
+++ g26/drivers/w1/masters/ds2482.c	2008-05-10 00:07:51.000000000 -0700
@@ -167,7 +167,7 @@ static inline int ds2482_select_register
  */
 static inline int ds2482_send_cmd(struct ds2482_data *pdev, u8 cmd)
 {
-	if (i2c_smbus_write_byte(&pdev->client, cmd) < 0)
+	if (i2c_smbus_send_byte(&pdev->client, cmd) < 0)
 		return -1;
=20
 	pdev->read_prt =3D DS2482_PTR_CODE_STATUS;
@@ -216,7 +216,7 @@ static int ds2482_wait_1wire_idle(struct
=20
 	if (!ds2482_select_register(pdev, DS2482_PTR_CODE_STATUS)) {
 		do {
-			temp =3D i2c_smbus_read_byte(&pdev->client);
+			temp =3D i2c_smbus_receive_byte(&pdev->client);
 		} while ((temp >=3D 0) && (temp & DS2482_REG_STS_1WB) &&
 			 (++retries < DS2482_WAIT_IDLE_TIMEOUT));
 	}
@@ -244,7 +244,7 @@ static int ds2482_set_channel(struct ds2
=20
 	pdev->read_prt =3D DS2482_PTR_CODE_CHANNEL;
 	pdev->channel =3D -1;
-	if (i2c_smbus_read_byte(&pdev->client) =3D=3D ds2482_chan_rd[channel]=
) {
+	if (i2c_smbus_receive_byte(&pdev->client) =3D=3D ds2482_chan_rd[chann=
el]) {
 		pdev->channel =3D channel;
 		return 0;
 	}
@@ -368,7 +368,7 @@ static u8 ds2482_w1_read_byte(void *data
 	ds2482_select_register(pdev, DS2482_PTR_CODE_DATA);
=20
 	/* Read the data byte */
-	result =3D i2c_smbus_read_byte(&pdev->client);
+	result =3D i2c_smbus_receive_byte(&pdev->client);
=20
 	mutex_unlock(&pdev->access_lock);
=20
@@ -463,7 +463,7 @@ static int ds2482_detect(struct i2c_adap
 	ndelay(525);
=20
 	/* Read the status byte - only reset bit and line should be set */
-	temp1 =3D i2c_smbus_read_byte(new_client);
+	temp1 =3D i2c_smbus_receive_byte(new_client);
 	if (temp1 !=3D (DS2482_REG_STS_LL | DS2482_REG_STS_RST)) {
 		dev_dbg(&adapter->dev, "DS2482 (0x%02x) reset status "
 			"0x%02X - not a DS2482\n", address, temp1);
