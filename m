From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] gpio: max732x: add support for MAX7319,
 MAX7320-7327 I2C Port Expanders
Date: Sun, 13 Jul 2008 09:20:50 +0200
Message-ID: <20080713092050.6dffd8d3@hyperion.delvare>
References: <4875A893.3090402@gmail.com>
	<200807111425.00961.david-b@pacbell.net>
	<20080712091610.4ec242c3@hyperion.delvare>
	<200807120046.29389.david-b@pacbell.net>
	<f17812d70807122304o533d8af9k1384db653b264912@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <f17812d70807122304o533d8af9k1384db653b264912-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: eric miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Jack Ren <jack.ren-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Eric,

On Sun, 13 Jul 2008 14:04:28 +0800, eric miao wrote:
> From 562e78eec627092610db817e28c4ff9be6af13e1 Mon Sep 17 00:00:00 2001
> From: Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Date: Thu, 10 Jul 2008 13:37:59 +0800
> Subject: [PATCH] gpio: max732x: add support for MAX7319, MAX7320-7327
> I2C Port Expanders
> 
> Signed-off-by: Jack Ren <jack.ren-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> ---
> 
> Updated as below. i2c_new_dummy() is called _only_ when necessary
> (there's 8-bit IO expander). mutex is used to protect the update to
> chip->reg_out[].
> 
> Actually, I don't quite like the idea of i2c_new_dummy(), which creates
> several i2c_client for one device. Due to:
> 
> 1. i2c_client should really be 1:1 with the device
> 2. a dummy i2c_client just wastes another several bytes

I don't like i2c_new_dummy much either, and I agree with the 2 points
above. However...

> 3. for chips like max732x, actually, the range of 0x50 - 0x5F will be
> monitored by the I2C chips at startup to decide the connections of
> AD2/AD0 pins to GND/VCC/SCL/SDA, so actually, even if the chip
> is finally decided at, say 0x56, no sane hardware designers will put
> another chip whose address falls between 0x50-0x5F together with
> such a max732x chip, ugly, but true.

Why do these chips have a selectable address at all then, if they
virtually use all the range of possible addresses? I don't buy this
point at all. I see no reason why putting another chip in the same
range would cause any problem.

> One i2c_client requesting a group of address could somehow be
> more reasonable, and requested address can be changed at
> run-time.

It would be more reasonable, but it would be racy (as your original
driver was, now that I come to think of it.) Without a mutex (or
equivalent) to protect the i2c_client structure, two concurrent
accesses at different addresses would break. And if you add a mutex to
the i2c_client, and take it for every access, then you have a
performance degradation. I definitely prefer to waste a few hundreds
bytes in memory.

One possible solution to this problem would be to split the few fields
needed by i2c_smbus_* and friends, to a separate structure (say,
i2c_handle). One i2c_client structure would include one i2c_handle, and
could have an optional array of extra ones for multi-address chips.
This would however require that we change the prototype of all
i2c_smbus_* helper functions, this is a big change, so it better be
well considered and deemed worth the effort.

> 
> Anyway, here's the one for i2c_new_dummy().
> (...)
> +static int __devinit max732x_probe(struct i2c_client *client,
> +				   const struct i2c_device_id *id)
> +{
> +	struct max732x_platform_data *pdata;
> +	struct max732x_chip *chip;
> +	struct i2c_client *c;
> +	uint16_t addr_a, addr_b;
> +	int ret, nr_port;
> +
> +	pdata = client->dev.platform_data;
> +	if (pdata == NULL)
> +		return -ENODEV;
> +
> +	chip = kzalloc(sizeof(struct max732x_chip), GFP_KERNEL);
> +	if (chip == NULL)
> +		return -ENOMEM;
> +
> +	nr_port = max732x_setup_gpio(chip, id, pdata->gpio_base);
> +
> +	addr_a = (client->addr & 0x0f) | 0x60;
> +	addr_b = (client->addr & 0x0f) | 0x50;
> +
> +	switch (client->addr & 0x70) {
> +	case 0x60:
> +		chip->client_group_a = client;
> +		if (nr_port > 7) {
> +			c = i2c_new_dummy(client->adapter, addr_b);
> +			chip->client_group_b = chip->client_dummy = c;
> +		}
> +		break;
> +	case 0x50:
> +		chip->client_group_b = client;
> +		if (nr_port > 7) {
> +			c = i2c_new_dummy(client->adapter, addr_a);
> +			chip->client_group_a = chip->client_dummy = c;
> +		}
> +		break;
> +	default:
> +		dev_err(&client->dev, "invalid I2C address specified %02x\n",
> +				client->addr);
> +		return -EINVAL;
> +	}
> +
> +	mutex_init(&chip->lock);
> +
> +	max732x_read(chip, is_group_a(chip, 0), &chip->reg_out[0]);
> +	if (nr_port > 7)
> +		max732x_read(chip, is_group_a(chip, 8), &chip->reg_out[1]);
> +
> +	ret = gpiochip_add(&chip->gpio_chip);
> +	if (ret)
> +		goto out_failed;
> +
> +	if (pdata->setup) {
> +		ret = pdata->setup(client, chip->gpio_chip.base,
> +				chip->gpio_chip.ngpio, pdata->context);
> +		if (ret < 0)
> +			dev_warn(&client->dev, "setup failed, %d\n", ret);
> +	}
> +
> +	i2c_set_clientdata(client, chip);
> +	return 0;
> +
> +out_failed:
> +	kfree(chip);
> +	return ret;
> +}

Looks OK to me.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
