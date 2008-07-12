From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] gpio: max732x: add support for MAX7319,
 MAX7320-7327 I2C Port Expanders
Date: Sat, 12 Jul 2008 09:16:10 +0200
Message-ID: <20080712091610.4ec242c3@hyperion.delvare>
References: <4875A893.3090402@gmail.com>
	<f17812d70807110239q6c175f5cn70db966681ae387d@mail.gmail.com>
	<f17812d70807110248y7fab3328q59ea41084c491df@mail.gmail.com>
	<200807111425.00961.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200807111425.00961.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Jack Ren <jack.ren-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Fri, 11 Jul 2008 14:25:00 -0700, David Brownell wrote:
> On Friday 11 July 2008, eric miao wrote:
> > --- /dev/null
> > +++ b/drivers/gpio/max732x.c
> > @@ -0,0 +1,361 @@
> > ...
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/slab.h>
> > +#include <linux/i2c.h>
> > +#include <linux/i2c/max732x.h>
> > +
> > +#include <asm/gpio.h>
> 
> For consistency, make that <linux/gpio.h> and put it up above.
> I like to see blank lines delineating groups, like <linux/*>
> and <linux/i2c/*>, too.

You probably want to fix all gpio drivers to do the same then,
otherwise contributors will keep copying the wrong practice.

> > (...)
> > +static int __devinit max732x_probe(struct i2c_client *client,
> > +				   const struct i2c_device_id *id)
> > +{
> > +	struct max732x_platform_data *pdata;
> > +	struct max732x_chip *chip;
> > +	int ret;
> > +
> > +	pdata = client->dev.platform_data;
> > +	if (pdata == NULL)
> > +		return -ENODEV;
> > +
> > +	chip = kzalloc(sizeof(struct max732x_chip), GFP_KERNEL);
> > +	if (chip == NULL)
> > +		return -ENOMEM;
> > +
> > +	chip->client[0] = client;
> > +
> > +	switch (client->addr & 0x70) {
> > +	case 0x60:
> > +		chip->client[1] = i2c_new_dummy(client->adapter,
> > +					(client->addr & 0x0f) | 0x50);
> > +		chip->client_group_a = chip->client[0];
> > +		chip->client_group_b = chip->client[1];
> > +		break;
> > +	case 0x50:
> > +		chip->client[1] = i2c_new_dummy(client->adapter,
> > +					(client->addr & 0x0f) | 0x60);
> > +		chip->client_group_a = chip->client[1];
> > +		chip->client_group_b = chip->client[0];
> > +		break;
> 
> Why not just insist the 0x5x address be registered/probed?  This
> extra stuff is needless and confusing.

Because some of the chips supported by this driver (max7319, max7321,
max7322 and max7323) only use address 0x6x. Forcing 0x6x doesn't work
either, because the max7320 only uses address 0x5x.

I agree that the way the two clients are handled seems to be more
complex than it needs to be, but the diversity of supported chips is
such that even simplifying it as much as possible will still result in
non-trivial code.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
