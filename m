From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH v4 2/2] i2c: Add Spreadtrum I2C controller driver
Date: Sun, 27 Aug 2017 17:30:54 +0200
Message-ID: <20170827153054.ijqxbjk25zpskojl@ninjato>
References: <eda1f25512db9c6946b303dd43f518ae2f0f3b26.1500021045.git.baolin.wang@spreadtrum.com>
 <acbfda522aa806284b86f8935278cc7f7133e876.1500021046.git.baolin.wang@spreadtrum.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gvxh3z3vm35cohlm"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:37511 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751174AbdH0Pa4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 27 Aug 2017 11:30:56 -0400
Content-Disposition: inline
In-Reply-To: <acbfda522aa806284b86f8935278cc7f7133e876.1500021046.git.baolin.wang@spreadtrum.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Baolin Wang <baolin.wang@spreadtrum.com>
Cc: mark.rutland@arm.com, robh+dt@kernel.org, andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org, baolin.wang@linaro.org


--gvxh3z3vm35cohlm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

thanks for your submission.

> +static void sprd_i2c_dump_reg(struct sprd_i2c *i2c_dev)
> +{
> +	dev_err(&i2c_dev->adap.dev, ": ======dump i2c-%d reg=======\n",
> +		i2c_dev->adap.nr);
> +	dev_err(&i2c_dev->adap.dev, ": I2C_CTRL:0x%x\n",
> +		readl(i2c_dev->base + I2C_CTL));
> +	dev_err(&i2c_dev->adap.dev, ": I2C_ADDR_CFG:0x%x\n",
> +		readl(i2c_dev->base + I2C_ADDR_CFG));
> +	dev_err(&i2c_dev->adap.dev, ": I2C_COUNT:0x%x\n",
> +		readl(i2c_dev->base + I2C_COUNT));
> +	dev_err(&i2c_dev->adap.dev, ": I2C_RX:0x%x\n",
> +		readl(i2c_dev->base + I2C_RX));
> +	dev_err(&i2c_dev->adap.dev, ": I2C_STATUS:0x%x\n",
> +		readl(i2c_dev->base + I2C_STATUS));
> +	dev_err(&i2c_dev->adap.dev, ": ADDR_DVD0:0x%x\n",
> +		readl(i2c_dev->base + ADDR_DVD0));
> +	dev_err(&i2c_dev->adap.dev, ": ADDR_DVD1:0x%x\n",
> +		readl(i2c_dev->base + ADDR_DVD1));
> +	dev_err(&i2c_dev->adap.dev, ": ADDR_STA0_DVD:0x%x\n",
> +		readl(i2c_dev->base + ADDR_STA0_DVD));
> +	dev_err(&i2c_dev->adap.dev, ": ADDR_RST:0x%x\n",
> +		readl(i2c_dev->base + ADDR_RST));

I really thing register dumps should be dev_dbg().

> +}
> +
> +static void sprd_i2c_set_count(struct sprd_i2c *i2c_dev, u32 count)
> +{
> +	writel(count, i2c_dev->base + I2C_COUNT);
> +}
> +
> +static void sprd_i2c_send_stop(struct sprd_i2c *i2c_dev, int stop)
> +{
> +	unsigned int tmp = readl(i2c_dev->base + I2C_CTL);

u32? Here and in many other places?

...

> +static irqreturn_t sprd_i2c_isr_thread(int irq, void *dev_id)
> +{
> +	struct sprd_i2c *i2c_dev = dev_id;
> +	struct i2c_msg *msg = i2c_dev->msg;
> +	int ack = readl(i2c_dev->base + I2C_STATUS) & I2C_RX_ACK;
> +	u32 i2c_count = readl(i2c_dev->base + I2C_COUNT);
> +	u32 i2c_tran;
> +
> +	if (msg->flags & I2C_M_RD)
> +		i2c_tran = i2c_dev->count >= I2C_FIFO_FULL_THLD;
> +	else
> +		i2c_tran = i2c_count;
> +
> +	/*
> +	 * If we got one ACK from slave when writing data, and we did not

Here you say: "If we get ack..."

> +	 * finish this transmission (i2c_tran is not zero), then we should
> +	 * continue to write data.
> +	 *
> +	 * For reading data, ack is always 0, if i2c_tran is not 0 which
> +	 * means we still need to contine to read data from slave.
> +	 */
> +	if (i2c_tran && !ack) {

... but the code gives the assumption you did NOT get an ack. So, either
rename the variable to 'ack_err' or keep it 'ack' and invert the logic
when initializing the variable.

> +		sprd_i2c_data_transfer(i2c_dev);
> +		return IRQ_HANDLED;
> +	}
> +
> +	i2c_dev->err = 0;
> +
> +	/*
> +	 * If we did not get one ACK from slave when writing data, we should
> +	 * dump all registers to check I2C status.

Why? I would say no. NACK from a slave can always happen, e.g. when an
EEPROM is busy erasing a page.

> +	 */
> +	if (ack) {
> +		i2c_dev->err = -EIO;
> +		sprd_i2c_dump_reg(i2c_dev);
> +	} else if (msg->flags & I2C_M_RD && i2c_dev->count) {
> +		sprd_i2c_read_bytes(i2c_dev, i2c_dev->buf, i2c_dev->count);
> +	}
> +
> +	/* Transmission is done and clear ack and start operation */
> +	sprd_i2c_clear_ack(i2c_dev);
> +	sprd_i2c_clear_start(i2c_dev);
> +	complete(&i2c_dev->complete);
> +
> +	return IRQ_HANDLED;
> +}

...

> +
> +	pm_runtime_set_autosuspend_delay(i2c_dev->dev, SPRD_I2C_PM_TIMEOUT);
> +	pm_runtime_use_autosuspend(i2c_dev->dev);
> +	pm_runtime_set_active(i2c_dev->dev);
> +	pm_runtime_enable(i2c_dev->dev);
> +
> +	ret = pm_runtime_get_sync(i2c_dev->dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "i2c%d pm runtime resume failed!\n",
> +			pdev->id);

Error message has wrong text.

> +		goto err_rpm_put;
> +	}
> +
> +static int sprd_i2c_init(void)
> +{
> +	return platform_driver_register(&sprd_i2c_driver);
> +}
> +arch_initcall_sync(sprd_i2c_init);

arch_initcall? and no exit() function? Why is it that way and/or why
can't you use platform_module_driver()?

Rest looks good. I like the comments you added to the code.

Regards,

   Wolfram


--gvxh3z3vm35cohlm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmi5aoACgkQFA3kzBSg
KbbzdhAAsYRkg//YqirAsz/ZCIwikmTQAg2I87/sGSXvBwQcbHjX64eC9z1+T8E7
us7LXkw+vv6aB30AIotzM8PlgAO+EI/V8r2x7c2zy10Fv3Bg+jw+5snLiWk0zf3F
/Vs9WQ5M5GSzHnYI0s3MZSGa//eZb9CzfRw0U7e6Hy5MG83qJTR4oce2GVcp/TkQ
NpWNPw1qbB3yrEUcicx1fnSeHpEfamz7wAMTKOBaXkT5yXhi91OVS/MiFw9D5WgH
hFog903ijysV86K7MEtRe1NDuUawEA0LniTr1cxnTFQaCdiv3kEWMc6+FZ0ovgj8
xAADzCl2RHmZs+N+J79+mFWoiUCpYDlf/bJzgaYGqmhsL6W5nen24BWU4VpiCtn5
kJytDjl8ZfqnF7yS/0mUDQnxc7Vy4vEzEUK/EGQJG/4+sPOBOncBZ1E0VZiaZWoi
nZWRlhtWlxY2/y8xDpVc2B9iASVb+sBKFW3SAwVs4dZPqsr2haX5ST8Tx8UP3942
oG24S8vLmIcFmF+bGoc4/m+gZDk8kO0Dvq93urCXO1W+yqshJKX2g+oGpV9ZVefm
vC/Ux4QIgfJPYyepQdiuF+yVbmSuR1+rbc5RN3WrSq57NauhfO1AM7SqIxEgY0fo
yLd/juWR2nrqRIvKJ63t126QeO26mtcFNmwCofHlSE8WpUXYETk=
=ugXr
-----END PGP SIGNATURE-----

--gvxh3z3vm35cohlm--
