From: "De Candia Michele" <Michele.DeCandia-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>
Subject: R: [PATCH] i2c/tsl2550: Use combined SMBus transactions
Date: Wed, 5 Aug 2009 11:47:28 +0200
Message-ID: <B6A09801228D2144A4B541D2D675AD2BBAF811@MSRV-BE0.valueteam.com>
References: <20090715222824.2250d26b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <20090715222824.2250d26b-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,
Sorry for my delay in answering; I've just tested your patch and it wor=
ks fine on my hardware.
A lux read is 4 times faster then previous implementation, great job!

Regards,
Michele=20

-----Messaggio originale-----
Da: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-i2c-owner-u79uwXL29TZUIDd8j+nm9g@public.gmane.org=
=2Eorg] Per conto di Jean Delvare
Inviato: mercoled=EC 15 luglio 2009 22.28
A: Linux I2C
Cc: De Candia Michele; Rodolfo Giometti
Oggetto: [PATCH] i2c/tsl2550: Use combined SMBus transactions

Make the I/O faster, mainly by using combined SMBus transactions when
possible. While the TSL2550 datasheet doesn't say the device supports
them, they seem to work just fine in practice, and a combined
transaction is faster than two simple transactions in many cases and
always more reliable.

A side effect is to suppress the delays between SMBus writes and
reads. The datasheet doesn't say they are needed and things work just
fine for me without them.

I also couldn't see any reason for the delay between reading the two
channels. Nor for the loop to get a reading in the first place. The
400 ms delay between samples only matters at chip power-up, after that
the chip always hold the previously sampled value so we never get to
wait.

All these changes make reading the lux value much faster and cheaper.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Michele De Candia <michele.decandia-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>
Cc: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
---
Michele, Rodolfo, can you please test and confirm the driver still
works OK for you? Thanks.

 drivers/i2c/chips/tsl2550.c |   42 ++++++++++-------------------------=
-------
 1 file changed, 10 insertions(+), 32 deletions(-)

--- linux-2.6.31-rc3.orig/drivers/i2c/chips/tsl2550.c	2009-07-15 22:19:=
51.000000000 +0200
+++ linux-2.6.31-rc3/drivers/i2c/chips/tsl2550.c	2009-07-15 22:20:03.00=
0000000 +0200
@@ -24,10 +24,9 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/mutex.h>
-#include <linux/delay.h>
=20
 #define TSL2550_DRV_NAME	"tsl2550"
-#define DRIVER_VERSION		"1.1.2"
+#define DRIVER_VERSION		"1.2"
=20
 /*
  * Defines
@@ -96,32 +95,13 @@ static int tsl2550_set_power_state(struc
=20
 static int tsl2550_get_adc_value(struct i2c_client *client, u8 cmd)
 {
-	unsigned long end;
-	int loop =3D 0, ret =3D 0;
+	int ret;
=20
-	/*
-	 * Read ADC channel waiting at most 400ms (see data sheet for further
-	 * info).
-	 * To avoid long busy wait we spin for few milliseconds then
-	 * start sleeping.
-	 */
-	end =3D jiffies + msecs_to_jiffies(400);
-	while (time_before(jiffies, end)) {
-		i2c_smbus_write_byte(client, cmd);
-
-		if (loop++ < 5)
-			mdelay(1);
-		else
-			msleep(1);
-
-		ret =3D i2c_smbus_read_byte(client);
-		if (ret < 0)
-			return ret;
-		else if (ret & 0x0080)
-			break;
-	}
+	ret =3D i2c_smbus_read_byte_data(client, cmd);
+	if (ret < 0)
+		return ret;
 	if (!(ret & 0x80))
-		return -EIO;
+		return -EAGAIN;
 	return ret & 0x7f;	/* remove the "valid" bit */
 }
=20
@@ -285,8 +265,6 @@ static ssize_t __tsl2550_show_lux(struct
 		return ret;
 	ch0 =3D ret;
=20
-	mdelay(1);
-
 	ret =3D tsl2550_get_adc_value(client, TSL2550_READ_ADC1);
 	if (ret < 0)
 		return ret;
@@ -345,11 +323,10 @@ static int tsl2550_init_client(struct i2
 	 * Probe the chip. To do so we try to power up the device and then to
 	 * read back the 0x03 code
 	 */
-	err =3D i2c_smbus_write_byte(client, TSL2550_POWER_UP);
+	err =3D i2c_smbus_read_byte_data(client, TSL2550_POWER_UP);
 	if (err < 0)
 		return err;
-	mdelay(1);
-	if (i2c_smbus_read_byte(client) !=3D TSL2550_POWER_UP)
+	if (err !=3D TSL2550_POWER_UP)
 		return -ENODEV;
 	data->power_state =3D 1;
=20
@@ -374,7 +351,8 @@ static int __devinit tsl2550_probe(struc
 	struct tsl2550_data *data;
 	int *opmode, err =3D 0;
=20
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE)) {
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WRITE_BYTE
+					    | I2C_FUNC_SMBUS_READ_BYTE_DATA)) {
 		err =3D -EIO;
 		goto exit;
 	}


--=20
Jean Delvare
--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
