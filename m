From: "eric miao" <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] gpio: max732x: add support for MAX7319,
	MAX7320-7327 I2C Port Expanders
Date: Fri, 11 Jul 2008 16:57:36 +0800
Message-ID: <f17812d70807110157p5e421222sc9ef420ceb80970c@mail.gmail.com>
References: <4875A893.3090402@gmail.com>
	<20080711102952.31d2d943@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080711102952.31d2d943-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Jack Ren <jack.ren-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jul 11, 2008 at 4:29 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> Hi Eric, David,
>
> On Thu, 10 Jul 2008 14:13:39 +0800, Eric Miao wrote:
>>
>> Signed-off-by: Jack Ren <jack.ren-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>
> David, maybe you should create an entry for the gpio subsystem in
> MAINTAINERS?

I don't mind, this patch actually requires joint review :-)

>> +config GPIO_MAX732X
>> +     tristate "MAX7319, MAX7320-7327 8/16-bit I2C Port Expanders"
>> +     depends on I2C
>> +     help
>> +       Say yes here to support the MAX7319, MAX7320-7327 series of I2C
>> +       Port Expanders. Each IO port on these chips has a fixed role of
>
> I have a personal preference for "I/O" over "IO", but maybe that's just
> me.

OK

>
>> +       Input (designated by 'I'), Push-Pull Output ('O'), or Open-Drain
>> +       Input and Output (designed by 'P'). The combinations are listed
>> +       below:
>
> 'O' for push-pull and 'P' for open-drain, this is brilliant! :(

This is how MAXIM named those pins in their datasheets, I think
it's acceptable, at least to make thing clear in a simple way.

>> @@ -7,3 +7,4 @@ obj-$(CONFIG_HAVE_GPIO_LIB)   += gpiolib.o
>>  obj-$(CONFIG_GPIO_MCP23S08)  += mcp23s08.o
>>  obj-$(CONFIG_GPIO_PCA953X)   += pca953x.o
>>  obj-$(CONFIG_GPIO_PCF857X)   += pcf857x.o
>> +obj-$(CONFIG_GPIO_MAX732X)   += max732x.o
>
> Alphabetical order?

OK

>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/i2c.h>
>> +#include <linux/i2c/max732x.h>
>
> You also need to include <linux/slab.h> for kzalloc and kfree.

OK

>> + * There are two groups of I/O ports, each group usually includes
>> + * up to 8 I/O ports, and is accessed by different I2C address:
>
> "by a specific I2C address"?

OK

>
>> + *
>> + *   - Group A : by I2C address 0b'110xxxx
>> + *   - Group B : by I2C address 0b'101xxxx
>> + *
>> + * where 'xxxx' is decided by the connections of pin AD2/AD0.
>
> AD2-AD0 (assuming there there is an AD1 pin)

Unfortunately, no AD1 pin

>
>> + *
>> + * Within each group of ports, there are five known combinations of
>> + * I/O ports: 4I4O, 4P4O, 8I, 8P, 8O, see the definitions below for
>> + * the detailed organization of these ports.
>> + *
>> + * GPIO numbers start from 'gpio_base + 0' to 'gpio_base + 8/16',
>> + * and GPIOs from GROUP_A are numbered before those from GROUP_B
>> + * (if there are two groups).
>> + *
>> + * NOTE: MAX7328/MAX7329, however, resembles much closer to PCF8574,
>> + * they are not supported by this driver.
>> + */
>> +
>> +#define PORT_NONE    0x0     /* '/' No Port */
>
> You don't use this define anywhere.

Just defined here to illustrate the purpose of the "0" here means
NO PORT exist in that bit position, it helps people to better
understand the port organization and initialization sequence

>
>> +#define PORT_OUTPUT  0x1     /* 'O' Push-Pull, Output Only */
>> +#define PORT_INPUT   0x2     /* 'I' Input Only */
>> +#define PORT_OPENDRAIN       0x3     /* 'P' Open-Drain, I/O */
>> +
>> +#define IO_4I4O              0x5AA5  /* O7 O6 I5 I4 I3 I2 O1 O0 */
>> +#define IO_4P4O              0x5FF5  /* O7 O6 P5 P4 P3 P2 O1 O0 */
>> +#define IO_8I                0xAAAA  /* I7 I6 I5 I4 I3 I2 I1 I0 */
>> +#define IO_8P                0xFFFF  /* P7 P6 P5 P4 P3 P2 P1 P0 */
>> +#define IO_8O                0x5555  /* O7 O6 O5 O4 O3 O2 O1 O0 */
>> +
>> +#define GROUP_A(x)   ((x) & 0xffff)  /* I2C Addr: 0b'110xxxx */
>
> The masking doesn't seem necessary.
>

No it doesn't. But to keep here for the readability, i.e. to make
things clear what upper/lower 16bit means

>> +/* NOTE:  we can't currently rely on fault codes to come from SMBus
>> + * calls, so we map all errors to EIO here and return zero otherwise.
>> + */
>
> With David's patches which will be merged in 2.6.27, you actually can
> in most cases:
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-adapters-return-proper-error-codes.patch
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-core-return-proper-error-codes.patch
>
> So I would suggest that you do not overwrite the error codes in your
> driver. If you notice problems with the error codes that come from a
> specific i2c bus driver, please fix that bus driver instead.
>

OK

>> +static int max732x_write(struct max732x_chip *chip, int group_a, uint8_t val)
>> +{
>> +     struct i2c_client *client = chip->client;
>> +     int ret;
>> +
>> +     client->addr = group_a ? chip->addr_group_a : chip->addr_group_b;
>
> This is prohibited. The i2c client is registered with i2c-core with a
> given address, which it marks as busy so that other drivers can't
> attach. Changing the client address on the fly defeats these safety
> checks.
>
> If you need more than one i2c_client, you can get the extra ones using
> i2c_new_dummy() at device probe time. The new at24 eeprom driver is
> doing this very well:
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-at24-new-eeprom-driver.patch
>

OK

>> +
>> +     nr_port = port;
>
> Why do you need 2 variables for that?

Again, better readability :-)

I can remove that if you mind.

>
>> +
>> +     if (nr_port > 7) {
>> +             max732x_read(chip, is_group_a(chip, 0), &chip->reg_out[0]);
>> +             max732x_read(chip, is_group_a(chip, 8), &chip->reg_out[1]);
>> +     } else
>> +             max732x_read(chip, is_group_a(chip, 0), &chip->reg_out[0]);
>
> Isn't this better written:
>
>        max732x_read(chip, is_group_a(chip, 0), &chip->reg_out[0]);
>        if (nr_port > 7)
>                max732x_read(chip, is_group_a(chip, 8), &chip->reg_out[1]);
>
> ?

OK

>> +     chip->gpio_start = pdata->gpio_base;
>> +     chip->addr_group_a = (client->addr & 0x0f) | 0x60;
>> +     chip->addr_group_b = (client->addr & 0x0f) | 0x50;
>
> As written above, this needs some rework. For one thing, you should
> check that client->addr actually matches either chip->addr_group_a or
> chip->addr_group_b. For another, for chips which use 2 addresses, you
> must get a client for the second one by calling i2c_new_dummy (and
> i2c_unregister_device at remove time.)

OK

>> +static int max732x_remove(struct i2c_client *client)
>> +{
>> +     struct max732x_platform_data *pdata = client->dev.platform_data;
>> +     struct max732x_chip *chip = i2c_get_clientdata(client);
>> +     int ret = 0;
>
> Initialization of ret isn't needed as far as I can tell.

OK

Thanks, Jean. I'll come up with a patch updated soon.

-- 
Cheers
- eric

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
