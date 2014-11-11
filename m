From: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5 1/2] i2c: Add Imagination Technologies I2C SCB driver
Date: Tue, 11 Nov 2014 17:37:16 -0300
Message-ID: <5462737C.2020202@imgtec.com>
References: <1415647816-16415-1-git-send-email-ezequiel.garcia@imgtec.com> <1415647816-16415-2-git-send-email-ezequiel.garcia@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415647816-16415-2-git-send-email-ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On 11/10/2014 04:30 PM, Ezequiel Garcia wrote:
[..]
> +static int img_i2c_init(struct img_i2c *i2c)
> +{
> +	unsigned int clk_khz, bitrate_khz, clk_period, tckh, tckl, tsdh;
> +	unsigned int i, ret, data, prescale, inc, int_bitrate;
> +	unsigned int filt, filt_disable, filt_bypass;
> +	struct img_i2c_timings timing;
> +	u32 rev;
> +
> +	ret = clk_prepare_enable(i2c->scb_clk);
> +	if (ret)
> +		return ret;
> +
> +	rev = img_i2c_readl(i2c, SCB_CORE_REV_REG);
> +	if ((rev & 0x00ffffff) < 0x00020200) {
> +		dev_info(i2c->adap.dev.parent,
> +			 "Unknown hardware revision (%d.%d.%d.%d)\n",
> +			 (rev >> 24) & 0xff, (rev >> 16) & 0xff,
> +			 (rev >> 8) & 0xff, rev & 0xff);
> +		clk_disable_unprepare(i2c->scb_clk);
> +		return -EINVAL;
> +	}
> +
> +	if (rev == REL_SOC_IP_SCB_2_2_1)
> +		i2c->need_wr_rd_fence = true;
> +

Maybe we can add a dev_info here:

dev_info(i2c->adap.dev.parent, "fence quirk enabled");

-- 
Ezequiel
