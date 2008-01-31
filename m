From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 3/3] Add support for PCA953[4-8] I2C GPIO
	extenders to the pca953x driver
Date: Thu, 31 Jan 2008 15:35:41 -0800
Message-ID: <200801311535.41442.david-b@pacbell.net>
References: <Pine.LNX.4.64.0801311453470.8478@axis700.grange>
	<200801311320.57437.david-b@pacbell.net>
	<Pine.LNX.4.64.0801312308110.3704@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0801312308110.3704-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
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
To: Guennadi Liakhovetski <g.liakhovetski-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: video4linux-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thursday 31 January 2008, Guennadi Liakhovetski wrote:
> On Thu, 31 Jan 2008, David Brownell wrote:
> =

> > On Thursday 31 January 2008, Guennadi Liakhovetski wrote:
> > > +/* This is only temporary - should go with 2.6.26. Only introduced n=
ow
> > > + * to avoid a sequence of strcmp() calls and just compare in a loop =
*/
> > > +struct pca953x_desc {
> > > +=A0=A0=A0=A0=A0=A0=A0unsigned int=A0=A0=A0=A0gpios;
> > > +=A0=A0=A0=A0=A0=A0=A0char=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*name;
> > > +};
> > =

> > This is a bit sub-optimal; if it were the same as i2c_device_id then
> > less code would need to change later.  So I'll probably tweak that bit
> > before sending it on.
> =

> Well, you said i2c_device_id is going to look like
> =

>   struct i2c_device_id {
>         char name[I2C_NAME_SIZE];
>         kernel_ulong_t driver_data;=A0=A0=A0=A0=A0/* Data private to the =
driver */
>   };
> =

> And I only have a (const) statically initialized array of such structs. =

> So, what would be the difference?

Compare to this cleaned up version of your patch 3/3 ... which is a bit
smaller since it removes reg_shift.  (Tell me I didn't break anything!)

When 2.6.26 merges i2c_device_id, then "pca953x_desc" will be replaced
by "i2c_device_id" and some code will vanish from probe().  No other
changes needed.

- Dave

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D CUT HERE
From: Guennadi Liakhovetski <g.liakhovetski-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

This third part of the extension to support more pca953x chips
updates the logic to handle the smaller register widths used by
the 4-bit and 8-bit parts, and to use the chip type to determine
how many GPIOs it provides.

As long as we don't support interrupt and reset capabilities, those size
issues are the only software-visible differences between these parts.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/gpio/pca953x.c |   73 ++++++++++++++++++++++++++++++++++++--------=
-----
 1 file changed, 55 insertions(+), 18 deletions(-)

--- g26.orig/drivers/gpio/pca953x.c	2008-01-31 14:41:19.000000000 -0800
+++ g26/drivers/gpio/pca953x.c	2008-01-31 15:20:28.000000000 -0800
@@ -1,5 +1,5 @@
 /*
- *  pca953x.c - 16-bit I/O port with interrupt and reset
+ *  pca953x.c - 4/8/16 bit I/O ports
  *
  *  Copyright (C) 2005 Ben Gardner <bgardner-ohtLXRgXiI/QT0dZR+AlfA@public.gmane.org>
  *  Copyright (C) 2007 Marvell International Ltd.
@@ -18,13 +18,26 @@
 =

 #include <asm/gpio.h>
 =

+#define PCA953X_INPUT          0
+#define PCA953X_OUTPUT         1
+#define PCA953X_INVERT         2
+#define PCA953X_DIRECTION      3
+
+/* This is temporary - in 2.6.26 i2c_driver_data should replace it. */
+struct pca953x_desc {
+	char		name[I2C_NAME_SIZE];
+	unsigned long	driver_data;
+};
 =

-#define NR_PCA953X_GPIOS	16
-
-#define PCA953X_INPUT		0
-#define PCA953X_OUTPUT		2
-#define PCA953X_INVERT		4
-#define PCA953X_DIRECTION	6
+static const struct pca953x_desc pca953x_descs[] =3D {
+	{ "pca9534", 8, },
+	{ "pca9535", 16, },
+	{ "pca9536", 4, },
+	{ "pca9537", 4, },
+	{ "pca9538", 8, },
+	{ "pca9539", 16, },
+	/* REVISIT several pca955x parts should work here too */
+};
 =

 struct pca953x_chip {
 	unsigned gpio_start;
@@ -40,17 +53,30 @@ struct pca953x_chip {
  */
 static int pca953x_write_reg(struct pca953x_chip *chip, int reg, uint16_t =
val)
 {
-	if (i2c_smbus_write_word_data(chip->client, reg, val) < 0)
-		return -EIO;
+	int ret;
+
+	if (chip->gpio_chip.ngpio <=3D 8)
+		ret =3D i2c_smbus_write_byte_data(chip->client, reg, val);
 	else
-		return 0;
+		ret =3D i2c_smbus_write_word_data(chip->client, reg << 1, val);
+
+	if (ret < 0) {
+		dev_err(&chip->client->dev, "failed writing register\n");
+		return -EIO;
+	}
+
+	return 0;
 }
 =

 static int pca953x_read_reg(struct pca953x_chip *chip, int reg, uint16_t *=
val)
 {
 	int ret;
 =

-	ret =3D i2c_smbus_read_word_data(chip->client, reg);
+	if (chip->gpio_chip.ngpio <=3D 8)
+		ret =3D i2c_smbus_read_byte_data(chip->client, reg);
+	else
+		ret =3D i2c_smbus_read_word_data(chip->client, reg << 1);
+
 	if (ret < 0) {
 		dev_err(&chip->client->dev, "failed reading register\n");
 		return -EIO;
@@ -148,7 +174,7 @@ static void pca953x_gpio_set_value(struc
 	chip->reg_output =3D reg_val;
 }
 =

-static int pca953x_init_gpio(struct pca953x_chip *chip)
+static void pca953x_setup_gpio(struct pca953x_chip *chip, int gpios)
 {
 	struct gpio_chip *gc;
 =

@@ -160,22 +186,30 @@ static int pca953x_init_gpio(struct pca9
 	gc->set =3D pca953x_gpio_set_value;
 =

 	gc->base =3D chip->gpio_start;
-	gc->ngpio =3D NR_PCA953X_GPIOS;
-	gc->label =3D "pca953x";
-
-	return gpiochip_add(gc);
+	gc->ngpio =3D gpios;
+	gc->label =3D chip->client->name;
 }
 =

 static int __devinit pca953x_probe(struct i2c_client *client)
 {
 	struct pca953x_platform_data *pdata;
 	struct pca953x_chip *chip;
-	int ret;
+	int ret, i;
+	const struct pca953x_desc *id =3D NULL;
 =

 	pdata =3D client->dev.platform_data;
 	if (pdata =3D=3D NULL)
 		return -ENODEV;
 =

+	/* this loop vanishes when we get i2c_device_id */
+	for (i =3D 0; i < ARRAY_SIZE(pca953x_descs); i++)
+		if (!strcmp(pca953x_descs[i].name, client->name)) {
+			id =3D pca953x_descs + i;
+			break;
+		}
+	if (!id)
+		return -ENODEV;
+
 	chip =3D kzalloc(sizeof(struct pca953x_chip), GFP_KERNEL);
 	if (chip =3D=3D NULL)
 		return -ENOMEM;
@@ -187,6 +221,8 @@ static int __devinit pca953x_probe(struc
 	/* initialize cached registers from their original values.
 	 * we can't share this chip with another i2c master.
 	 */
+	pca953x_setup_gpio(chip, id->driver_data);
+
 	ret =3D pca953x_read_reg(chip, PCA953X_OUTPUT, &chip->reg_output);
 	if (ret)
 		goto out_failed;
@@ -200,7 +236,8 @@ static int __devinit pca953x_probe(struc
 	if (ret)
 		goto out_failed;
 =

-	ret =3D pca953x_init_gpio(chip);
+
+	ret =3D gpiochip_add(&chip->gpio_chip);
 	if (ret)
 		goto out_failed;
 =


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
