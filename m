From: Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v5 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
Date: Sun, 18 Jan 2015 10:14:04 +0100
Message-ID: <54BB795C.6040402@broadcom.com>
References: <Ray Jui <rjui@broadcom.com> <1421451737-7107-1-git-send-email-rjui@broadcom.com> <1421451737-7107-3-git-send-email-rjui@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1421451737-7107-3-git-send-email-rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 01/17/15 00:42, Ray Jui wrote:

[...]

> +/*
> + * Can be expanded in the future if more interrupt status bits are utilized
> + */
> +#define ISR_MASK (1<<  IS_M_START_BUSY_SHIFT)
> +
> +static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
> +{
> +	struct bcm_iproc_i2c_dev *iproc_i2c = data;
> +	u32 status = readl(iproc_i2c->base + IS_OFFSET);
> +
> +	status&= ISR_MASK;
> +
> +	if (!status)
> +		return IRQ_NONE;
> +
> +	writel(status, iproc_i2c->base + IS_OFFSET);
> +	complete_all(&iproc_i2c->done);

Looking over this code it seems to me there is always a single process 
waiting for iproc_i2c->done to complete. So using complete() here would 
suffice.

Regards,
Arend

> +
> +	return IRQ_HANDLED;
> +}

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
