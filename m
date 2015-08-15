From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] driver/i2c/mux: Add register based mux i2c-mux-reg
Date: Sat, 15 Aug 2015 22:23:05 +0200
Message-ID: <20150815202302.GB3463@katana>
References: <1434475692-4611-1-git-send-email-yorksun@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434475692-4611-1-git-send-email-yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 16, 2015 at 10:28:12AM -0700, York Sun wrote:
> Based on i2c-mux-gpio driver, similarly the register based mux
> switch from one bus to another by setting a single register.
> The register can be on PCIe bus, local bus, or any memory-mapped
> address.
> 
> Signed-off-by: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> CC: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> CC: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>

Mostly good.

> +static int i2c_mux_reg_probe(struct platform_device *pdev)
> +{
> +	struct regmux *mux;
> +	struct i2c_adapter *parent;
> +	struct resource *res;
> +	int (*deselect)(struct i2c_adapter *, void *, u32);
> +	unsigned int initial_state, class;

gcc says:

drivers/i2c/muxes/i2c-mux-reg.c:182:15: warning: variable 'initial_state' set but not used [-Wunused-but-set-variable]

It seens you prepared for setting the initial state but don't do the
actual set?

> +static struct platform_driver i2c_mux_reg_driver = {
> +	.probe	= i2c_mux_reg_probe,
> +	.remove	= i2c_mux_reg_remove,
> +	.driver	= {
> +		.owner	= THIS_MODULE,

coccicheck says:

drivers/i2c/muxes/i2c-mux-reg.c:288:3-8: No need to set .owner here. The core will do it.

> +		.name	= "i2c-mux-reg",
> +	},
> +};

Thanks,

   Wolfram
