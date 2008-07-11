From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] gpio: max732x: add support for MAX7319,
 MAX7320-7327 I2C Port Expanders
Date: Fri, 11 Jul 2008 13:15:50 +0200
Message-ID: <20080711131550.6910fc47@hyperion.delvare>
References: <4875A893.3090402@gmail.com>
	<20080711102952.31d2d943@hyperion.delvare>
	<f17812d70807110157p5e421222sc9ef420ceb80970c@mail.gmail.com>
	<20080711113114.79d80212@hyperion.delvare>
	<f17812d70807110239q6c175f5cn70db966681ae387d@mail.gmail.com>
	<f17812d70807110248y7fab3328q59ea41084c491df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <f17812d70807110248y7fab3328q59ea41084c491df-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Fri, 11 Jul 2008 17:48:10 +0800, eric miao wrote:
> +static int __devinit max732x_probe(struct i2c_client *client,
> +				   const struct i2c_device_id *id)
> +{
> +	struct max732x_platform_data *pdata;
> +	struct max732x_chip *chip;
> +	int ret;
> +
> +	pdata = client->dev.platform_data;
> +	if (pdata == NULL)
> +		return -ENODEV;
> +
> +	chip = kzalloc(sizeof(struct max732x_chip), GFP_KERNEL);
> +	if (chip == NULL)
> +		return -ENOMEM;
> +
> +	chip->client[0] = client;
> +
> +	switch (client->addr & 0x70) {
> +	case 0x60:
> +		chip->client[1] = i2c_new_dummy(client->adapter,
> +					(client->addr & 0x0f) | 0x50);
> +		chip->client_group_a = chip->client[0];
> +		chip->client_group_b = chip->client[1];
> +		break;
> +	case 0x50:
> +		chip->client[1] = i2c_new_dummy(client->adapter,
> +					(client->addr & 0x0f) | 0x60);
> +		chip->client_group_a = chip->client[1];
> +		chip->client_group_b = chip->client[0];
> +		break;
> +	default:
> +		dev_err(&client->dev, "invalid I2C address specified %02x\n",
> +				client->addr);
> +		kfree(chip);
> +		return -EINVAL;
> +	}

Not all chips use 2 I2C addresses. You must only call i2c_new_dummy for
those which do. Otherwise you may prevent another driver from binding
to its device.

Also note that you don't use chip->client[0] except in this function,
so I'm not sure why you store it. Having just chip->dummy_client to
remember on which client to call i2c_unregister_device would be enough.

> +
> +	chip->gpio_start = pdata->gpio_base;
> +
> +	max732x_setup_gpio(chip, id->driver_data);
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
> +
> +static int max732x_remove(struct i2c_client *client)

max732x_probe is __devinit but this one isn't __devexit?

> +{
> +	struct max732x_platform_data *pdata = client->dev.platform_data;
> +	struct max732x_chip *chip = i2c_get_clientdata(client);
> +	int ret;
> +
> +	if (pdata->teardown) {
> +		ret = pdata->teardown(client, chip->gpio_chip.base,
> +				chip->gpio_chip.ngpio, pdata->context);
> +		if (ret < 0) {
> +			dev_err(&client->dev, "%s failed, %d\n",
> +					"teardown", ret);
> +			return ret;
> +		}
> +	}
> +
> +	ret = gpiochip_remove(&chip->gpio_chip);
> +	if (ret) {
> +		dev_err(&client->dev, "%s failed, %d\n",
> +				"gpiochip_remove()", ret);
> +		return ret;
> +	}
> +
> +	/* unregister the dummy i2c_client */
> +	i2c_unregister_device(chip->client[1]);
> +
> +	kfree(chip);
> +	return 0;
> +}

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
