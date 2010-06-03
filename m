From: =?UTF-8?B?UmljaGFyZCBSw7ZqZm9ycw==?=
	<richard.rojfors.lists-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Subject: Re: Registering I2C devices on X86
Date: Thu, 03 Jun 2010 14:39:08 +0200
Message-ID: <4C07A26C.3070708@pelagicore.com>
References: <4C062E70.3090409@pelagicore.com>	<20100602103650.GA4876@pengutronix.de>	<20100602130408.1e732a0a@hyperion.delvare>	<4C0640A0.9070103@pelagicore.com> <20100603082103.4bdccd85@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100603082103.4bdccd85-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 06/03/2010 08:21 AM, Jean Delvare wrote:
> On Wed, 02 Jun 2010 13:29:36 +0200, Richard R=C3=B6jfors wrote:
>> On 06/02/2010 01:04 PM, Jean Delvare wrote:
>>> Richard, look at drivers/i2c/busses/i2c-i801.c, function i801_probe=
():
>>> you'll see an example of per-platform I2C device instantiation on x=
86.
>>> I'm not claiming it is elegant, but it works.
>>
>> The "problem" I see is that the CPU and the chipset + I2C chip will =
be populated on several
>> different boards. It would mean that the I2C bus driver would need k=
nowledge of all the boards where
>> it is used. And the bus driver itself can not really detect which bo=
ard it's running on.
>>
>> That is why I kept the I2C device setup in a separate driver. So eac=
h board would have a separate
>> "setup" driver. Isn't that the most clean solution right now?
>
> I have to admit I don't clearly understand what you are doing. It
> should become clearer when I see your code.
>

The I2C bus driver used is a standard one and the setup of I2C devices =
depends on the actual board=20
the chips are deployed on.

I do stuff like this, example of a driver for one specific board (there=
 are more I2C devices to come):

#include <linux/gpio.h>
#include <linux/i2c.h>
#include <linux/i2c/tsc2007.h>

#define DRIVER_NAME "the_module"

static int	i2c_bus =3D 0;
static unsigned	tsc2007_irq_pin =3D 102;

static __devinitdata struct tsc2007_platform_data tsc2007_platform_data=
 =3D {
	.model =3D 2007,
	.x_plate_ohms =3D 200
};

static __initdata struct i2c_board_info tsc2007_i2c_board_info =3D {
	I2C_BOARD_INFO("tsc2007", 0x48),
	.platform_data =3D &tsc2007_platform_data,
	/* irq to be filled in runtime */
};

static struct i2c_client *tsc2007_client;

static __init int the_module_get_irq(unsigned gpio_pin)
{
	int err;

	err =3D gpio_request(gpio_pin, DRIVER_NAME);
	if (err)
		return err;

	err =3D gpio_direction_input(gpio_pin);
	if (err)
		goto err;

	err =3D gpio_to_irq(gpio_pin);
	if (err < 0)
		goto err;

	return err;
err:
	gpio_free(tsc2007_irq_pin);
	return err;
}

static __init int the_module_init(void)
{
	struct i2c_adapter *adapt;
	int err;

	adapt =3D i2c_get_adapter(i2c_bus);
	if (!adapt) {
		printk(KERN_ERR "%s: Failed to get I2C adapter\n", __func__);
		return -ENODEV;
	}

	err =3D the_module_get_irq(tsc2007_irq_pin);
	if (err < 0)
		goto put_adapter;
	tsc2007_i2c_board_info.irq =3D err;

	/* add in the devices on the bus */
	tsc2007_client =3D i2c_new_device(adapt, &tsc2007_i2c_board_info);
	if (!tsc2007_client)
		goto free_tsc2007_pin;

	i2c_put_adapter(adapt);

	return 0;

free_tsc2007_pin:
	gpio_free(tsc2007_irq_pin);
put_adapter:
	i2c_put_adapter(adapt);

	return err;
}

static void __exit the_module_exit(void)
{
	i2c_unregister_device(tsc2007_client);
}
