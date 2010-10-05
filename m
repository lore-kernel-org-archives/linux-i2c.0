From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH 3/5] misc: Driver for APDS990X ALS and proximity sensors
Date: Tue, 5 Oct 2010 12:23:23 +0100
Message-ID: <20101005122323.2d2870ee@lxorguk.ukuu.org.uk>
References: <1286271779-19819-1-git-send-email-samu.p.onkalo@nokia.com>
	<1286271779-19819-4-git-send-email-samu.p.onkalo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1286271779-19819-4-git-send-email-samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> +static int apds990x_refresh_athres(struct apds990x_chip *chip)
> +{
> +	int ret;
> +	/* If the chip is not in use, don't try to access it */
> +	if (pm_runtime_suspended(&chip->client->dev))
> +		return 0;
> +
> +	ret = apds990x_write_word(chip, APDS990X_AILTL,
> +			apds990x_lux_to_threshold(chip, chip->lux_thres_lo));
> +	ret |= apds990x_write_word(chip, APDS990X_AIHTL,
> +			apds990x_lux_to_threshold(chip, chip->lux_thres_hi));
> +

What is the locking theory in the driver for things like these multi word
writes. It's not clear from a first read how you guaranteed the refreshes
don't get tangled up or how you know there won't be an interrupt half way
through one of these pairs of accesses

> +static void apds990x_force_a_refresh(struct apds990x_chip *chip)
> +{
> +	/* This will force ALS interrupt after the next measurement. */
> +	apds990x_write_word(chip, APDS990X_AILTL, APDS_LUX_DEF_THRES_LO);
> +	apds990x_write_word(chip, APDS990X_AIHTL, APDS_LUX_DEF_THRES_HI);
> +}
> +
> +static void apds990x_force_p_refresh(struct apds990x_chip *chip)
> +{
> +	/* This will force proximity interrupt after the next measurement. */
> +	apds990x_write_word(chip, APDS990X_PILTL, APDS_PROX_DEF_THRES - 1);
> +	apds990x_write_word(chip, APDS990X_PIHTL, APDS_PROX_DEF_THRES);
> +}
> +

> +
> +	if (ret < 0)
> +		apds990x_force_a_refresh(chip); /* Bad result -> re-measure */

What stops this getting stuck forever - I admit it would probably need a
drastic case of strobe lighting but people do take phones to raves ..


> +static DEVICE_ATTR(lux0_input, S_IRUGO, apds990x_lux_show, NULL);

Are well all agreed on lux0_input ? I'm just putting some of the other
bits together to submit and using the same spec

> +static DEVICE_ATTR(lux0_input10x, S_IRUGO, apds990x_lux10x_show, NULL);

This seems daft. No doubt we'll want lux0_input100x next year

What's wrong with outputting %d.%d format to lux0_input - existing apps
will read the integer bit fine and we've not defined the interface yet
anyway.


> +	if ((value > APDS_RANGE) || (value == 0) ||
> +		(value < APDS_PROX_HYSTERESIS))
> +		return -EINVAL;

Excess brackets


> +	chip->regs[0].supply = reg_vcc;
> +	chip->regs[1].supply = reg_vled;

Shouldn't these come from the provided platform data ? and again if there
isn't a platform one supplied just skip the regulators. There are going
to be cases of boxes with regulator API stuff in use but who don't have
regulators for that device.



On the sysfs side

- not clear how power_state and runtime pm interact - do we in fact need
  power state ?
- lux0_input range being fixed seems inconvenient, the sensors I've got
  queued here use lux0_input as you do but also provide a read (and
  optionally writable) range limit in lux

static DEVICE_ATTR(lux0_sensor_range, S_IRUGO | S_IWUSR,
	als_sensing_range_show, als_sensing_range_store);

and in your case you could just return 65535


The sampling rate stuff is a bit different to what I have - in my case
writing to the sensing range alters the sampling rate requirements. I can
easily make either one adjust the other however so that fits nicely
