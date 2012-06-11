From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2 V3] MXS: Set I2C timing registers for mxs-i2c
Date: Mon, 11 Jun 2012 14:39:05 +0800
Message-ID: <20120611063903.GD2552@S2101-09.ap.freescale.net>
References: <1339242351-8797-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1339242351-8797-1-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Jun 09, 2012 at 01:45:50PM +0200, Marek Vasut wrote:
> This patch configures the I2C bus timing registers according
> to information passed via DT. Currently, 100kHz and 400kHz
> modes are supported.
> 
> Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

I gave it a test on imx28-evk board with audio playback.  It seems
the patch makes the first time playback non-functional, but the later
playback is still working.

> +static int mxs_i2c_get_ofdata(struct mxs_i2c_dev *i2c)
> +{
> +	uint32_t speed;
> +	struct device *dev = i2c->dev;
> +	struct device_node *node = dev->of_node;
> +
> +	if (!node)
> +		return -EINVAL;
> +
> +	i2c->speed = &mxs_i2c_95kHz_config;
> +	ret = of_property_read_u32(node, "clock-frequency", &speed);

"ret" is undeclared.

> +	if (ret)
> +		dev_warn(dev, "No I2C speed selected, using 100kHz\n");
> +	else if (speed == 400000)
> +		i2c->speed = &mxs_i2c_400kHz_config;
> +	else if (speed != 100000)
> +		dev_warn(dev, "Invalid I2C speed selected, using 100kHz\n");
> +
> +	return 0;
> +}
> +

-- 
Regards,
Shawn
