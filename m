From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 1/2 V3] MXS: Set I2C timing registers for mxs-i2c
Date: Sun, 10 Jun 2012 13:53:05 +0200
Message-ID: <201206101353.06018.marex@denx.de>
References: <1339242351-8797-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1339242351-8797-1-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Marek Vasut,

> This patch configures the I2C bus timing registers according
> to information passed via DT. Currently, 100kHz and 400kHz
> modes are supported.

[...]

> +struct mxs_i2c_speed_config {
> +	uint32_t	timing0;
> +	uint32_t	timing1;
> +	uint32_t	timing2;
> +};
> +
> +/* Timing values for the default 24MHz clock supplied into the i2c block.

Thinking about these further -- does anyone have any idea how these numbers were 
derived? And possibly even formula for that?

And maybe we should somehow make sure the source runs on 24MHz (how?).

> */ +const struct mxs_i2c_speed_config mxs_i2c_95kHz_config = {
> +	.timing0	= 0x00780030,
> +	.timing1	= 0x00800030,
> +	.timing2	= 0x0015000d,
> +};
> +
> +const struct mxs_i2c_speed_config mxs_i2c_400kHz_config = {
> +	.timing0	= 0x000f0007,
> +	.timing1	= 0x001f000f,
> +	.timing2	= 0x0015000d,
> +};

[...]

Best regards,
Marek Vasut
