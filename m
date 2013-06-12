From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCHv4 2/9] i2c: mv64xxx: make the registers offset
	configurable
Date: Wed, 12 Jun 2013 14:57:35 +0100
Message-ID: <20130612135735.GR18614@n2100.arm.linux.org.uk>
References: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com> <1371024438-16631-3-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1371024438-16631-3-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 12, 2013 at 10:07:11AM +0200, Maxime Ripard wrote:
> The Allwinner i2c controller uses the same logic as the Marvell one, but
> with slightly different register offsets.
> 
> Introduce a structure that will be passed by either the pdata or
> associated to the compatible strings, and that holds the various
> registers that might be needed.

I don't like this change.  It introduces further indirection where it's
not really necessary, and it's also using platform data to specify this
which is in the opposite direction to what's required for moving towards
DT.

> @@ -154,13 +147,13 @@ mv64xxx_i2c_prepare_for_io(struct mv64xxx_i2c_data *drv_data,
>  static void
>  mv64xxx_i2c_hw_init(struct mv64xxx_i2c_data *drv_data)
>  {
> -	writel(0, drv_data->reg_base + MV64XXX_I2C_REG_SOFT_RESET);
> +	writel(0, drv_data->reg_base + drv_data->regs->soft_reset);

It'd be much better to copy the offsets themselves in drv_data.  You're
only talking about 7 bytes here, so there's no worry about bloating the
drv_data structure.

> @@ -611,8 +619,9 @@ mv64xxx_i2c_probe(struct platform_device *pd)
>  		drv_data->freq_n = pdata->freq_n;
>  		drv_data->irq = platform_get_irq(pd, 0);
>  		drv_data->adapter.timeout = msecs_to_jiffies(pdata->timeout);
> +		drv_data->regs = pdata->regs;
>  	} else if (pd->dev.of_node) {
> -		rc = mv64xxx_of_config(drv_data, pd->dev.of_node);
> +		rc = mv64xxx_of_config(drv_data, &pd->dev);

I'd suggest making the default register offsets be the drivers existing
offsets, and allowing it to be overriden.  That nicely sorts out the
next comment below, and also gets rid of it in platform data.  Moreover,
if you're going to re-use this driver, you should do it via a different
"compatible" name in DT, which the driver can then use to identify the
different register set layout.

> +struct mv64xxx_i2c_regs mv64xxx_i2c_regs_mv64xxx = {
> +	.addr		= 0x00,
> +	.ext_addr	= 0x10,
> +	.data		= 0x04,
> +	.control	= 0x08,
> +	.status		= 0x0c,
> +	.clock		= 0x0c,
> +	.soft_reset	= 0x1c,
> +};

No, this means every file which includes this header ends up defining
this structure, which is globally visiable, and therefore its a recipe
for link failures.
