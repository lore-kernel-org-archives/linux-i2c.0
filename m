From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH 1/1] iio: ak8975: Add Ak8975 magnetometer sensor
Date: Thu, 2 Sep 2010 23:19:42 +0100
Message-ID: <20100902231942.21375cc0@lxorguk.ukuu.org.uk>
References: <1283463351-15816-1-git-send-email-achew@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1283463351-15816-1-git-send-email-achew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: achew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> +/*
> + * Shows the device's mode.  0 = off, 1 = on.
> + */

Should this not be handled by runtime pm nowdays ?

> +	if ((oval < 0) || (oval > 1)) {
> +		dev_err(dev, "mode value is not supported\n");
> +		return -EINVAL;
> +	}

ulong cannot be < 0 and doesn't need all the brackets


> +	/* Wait for the conversion to complete. */
> +	while (timeout_ms) {
> +		msleep(AK8975_CONVERSION_DONE_POLL_TIME);
> +		state = (gpio_get_value(data->eoc_gpio) ? 1 : 0);
> +		if (state)
> +			break;
> +		timeout_ms -= AK8975_CONVERSION_DONE_POLL_TIME;
> +	}

This makes some fairly specific wiring assumptions about how the ak8975
is configured. I'm looking at the ak8974 driver in our tree and also
wondering if they can be combined sanely.

> +	status = ak8975_read_data(client, AK8975_REG_ST1, 1, &read_status);
> +	if (!status) {
> +		dev_err(&client->dev, "Error in reading ST1\n");
> +		return false;

I would have expected these to return a meaningful error code not 0 ?

> +static IIO_DEVICE_ATTR(mode, S_IRUGO | S_IWUSR, show_mode, store_mode, 0);
> +static IIO_DEVICE_ATTR(magn_x_calibscale, S_IRUGO, show_calibscale, NULL, 0);
> +static IIO_DEVICE_ATTR(magn_y_calibscale, S_IRUGO, show_calibscale, NULL, 1);
> +static IIO_DEVICE_ATTR(magn_z_calibscale, S_IRUGO, show_calibscale, NULL, 2);
> +static IIO_DEV_ATTR_MAGN_X(show_raw, AK8975_REG_HXL);
> +static IIO_DEV_ATTR_MAGN_Y(show_raw, AK8975_REG_HYL);
> +static IIO_DEV_ATTR_MAGN_Z(show_raw, AK8975_REG_HZL);

This seems odd as an interface as it's raw when the maths to provide
non-raw (and thus abstract and easy for user space) data is trivial
enough to do in kernel

(but then I still suspect it should jusst be an input device of course)

> +static int ak8975_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct ak8975_data *data;
> +	int err;
> +
> +	/* Allocate our device context. */
> +	data = kzalloc(sizeof(struct ak8975_data), GFP_KERNEL);
> +	if (!data) {
> +		dev_err(&client->dev, "Memory allocation fails\n");
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	i2c_set_clientdata(client, data);
> +	data->client = client;
> +
> +	mutex_init(&data->lock);
> +
> +	/* Grab and set up the supplied GPIO. */
> +	data->eoc_irq = client->irq;
> +	data->eoc_gpio = irq_to_gpio(client->irq);

It may not be via a GPIO. Better to do the GPIO handling in platform
abstraction or accept passing IRQ and no GPIO value to mean "just use the
IRQ". Ie do all the gpio foo if (data->eoc_gpio) { ... }


> +
> +	err = gpio_request(data->eoc_gpio, "ak_8975");
> +	if (err < 0) {
> +		dev_err(&client->dev, "failed to request GPIO %d, error %d\n",
> +			data->eoc_gpio, err);
> +		goto exit_free;
> +	}
> +
> +	err = gpio_direction_input(data->eoc_gpio);
> +	if (err < 0) {
> +		dev_err(&client->dev, "Failed to configure input direction for"
> +			" GPIO %d, error %d\n", data->eoc_gpio, err);
> +		gpio_free(data->eoc_gpio);

This frees the GPIO twice ?

Looks basically sound to me.

Alan
