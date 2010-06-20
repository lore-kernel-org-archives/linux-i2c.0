From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Registering I2C devices on X86
Date: Sun, 20 Jun 2010 10:34:08 +0200
Message-ID: <20100620103408.7fa5bcb7@hyperion.delvare>
References: <4C062E70.3090409@pelagicore.com>
	<20100602103650.GA4876@pengutronix.de>
	<20100602130408.1e732a0a@hyperion.delvare>
	<4C0640A0.9070103@pelagicore.com>
	<20100603082103.4bdccd85@hyperion.delvare>
	<4C07A26C.3070708@pelagicore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C07A26C.3070708-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard =?UTF-8?B?UsO2amZvcnM=?= <richard.rojfors.lists-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Richard,

Sorry for the late reply, your post slipped through the cracks.

On Thu, 03 Jun 2010 14:39:08 +0200, Richard R=C3=B6jfors wrote:
> On 06/03/2010 08:21 AM, Jean Delvare wrote:
> > On Wed, 02 Jun 2010 13:29:36 +0200, Richard R=C3=B6jfors wrote:
> >> The "problem" I see is that the CPU and the chipset + I2C chip wil=
l be populated on several
> >> different boards. It would mean that the I2C bus driver would need=
 knowledge of all the boards where
> >> it is used. And the bus driver itself can not really detect which =
board it's running on.
> >>
> >> That is why I kept the I2C device setup in a separate driver. So e=
ach board would have a separate
> >> "setup" driver. Isn't that the most clean solution right now?
> >
> > I have to admit I don't clearly understand what you are doing. It
> > should become clearer when I see your code.
>=20
> The I2C bus driver used is a standard one and the setup of I2C device=
s depends on the actual board=20
> the chips are deployed on.
>=20
> I do stuff like this, example of a driver for one specific board (the=
re are more I2C devices to come):
>=20
> #include <linux/gpio.h>
> #include <linux/i2c.h>
> #include <linux/i2c/tsc2007.h>
>=20
> #define DRIVER_NAME "the_module"
>=20
> static int	i2c_bus =3D 0;
> static unsigned	tsc2007_irq_pin =3D 102;
>=20
> static __devinitdata struct tsc2007_platform_data tsc2007_platform_da=
ta =3D {
> 	.model =3D 2007,
> 	.x_plate_ohms =3D 200
> };
>=20
> static __initdata struct i2c_board_info tsc2007_i2c_board_info =3D {
> 	I2C_BOARD_INFO("tsc2007", 0x48),
> 	.platform_data =3D &tsc2007_platform_data,
> 	/* irq to be filled in runtime */
> };
>=20
> static struct i2c_client *tsc2007_client;
>=20
> static __init int the_module_get_irq(unsigned gpio_pin)
> {
> 	int err;
>=20
> 	err =3D gpio_request(gpio_pin, DRIVER_NAME);
> 	if (err)
> 		return err;
>=20
> 	err =3D gpio_direction_input(gpio_pin);
> 	if (err)
> 		goto err;
>=20
> 	err =3D gpio_to_irq(gpio_pin);
> 	if (err < 0)
> 		goto err;
>=20
> 	return err;
> err:
> 	gpio_free(tsc2007_irq_pin);
> 	return err;
> }
>=20
> static __init int the_module_init(void)
> {
> 	struct i2c_adapter *adapt;
> 	int err;
>=20
> 	adapt =3D i2c_get_adapter(i2c_bus);

How do you know the value of i2c_bus? This is the key problem. If you
do not declare your I2C chips at the platform data level, there are no
I2C bus numbers reserved for static numbering. And even if you managed
to change that, the I2C adapters on x86 do not ask for a specific bus
number: they pick the first one available.

Maybe it happens to work for you right now, but this is very fragile.
I2C bus number 0 could become something completely different (for
example a DDC channel on the graphics adapter) at any time, depending
on which drivers are included in your kernel, the order in which they
are loaded/linked, and which exact hardware you run on.

If you want to take this approach, you need to extend the current API
first. You need a way to reserve static I2C bus numbers without
declaring devices on them. And you need to change the bus drivers (e.g.
i2c-i801.c) to request this specific bus number under specific
circumstances. So you won't avoid platform/machine specific code in the
I2C bus
driver.

The above is certainly doable, but if you need to do that kind of
thing, then it's probably time to rethink the whole thing. If x86
starts being used for embedded-style applications, then the
platform/machine handling should be adjusted. I see no reason why the
same approach that works for ARM platforms wouldn't work for x86
platforms as well.


> 	if (!adapt) {
> 		printk(KERN_ERR "%s: Failed to get I2C adapter\n", __func__);
> 		return -ENODEV;
> 	}
>=20
> 	err =3D the_module_get_irq(tsc2007_irq_pin);
> 	if (err < 0)
> 		goto put_adapter;
> 	tsc2007_i2c_board_info.irq =3D err;
>=20
> 	/* add in the devices on the bus */
> 	tsc2007_client =3D i2c_new_device(adapt, &tsc2007_i2c_board_info);
> 	if (!tsc2007_client)
> 		goto free_tsc2007_pin;
>=20
> 	i2c_put_adapter(adapt);
>=20
> 	return 0;
>=20
> free_tsc2007_pin:
> 	gpio_free(tsc2007_irq_pin);
> put_adapter:
> 	i2c_put_adapter(adapt);
>=20
> 	return err;
> }
>=20
> static void __exit the_module_exit(void)
> {
> 	i2c_unregister_device(tsc2007_client);
> }


--=20
Jean Delvare
