From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: [Patch] MPC Adapter: read class attribute from device tree
Date: Tue, 21 Apr 2009 09:00:19 +0200
Message-ID: <49ED6F03.5050107@grandegger.com>
References: <49ED6AD3.2060808@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49ED6AD3.2060808-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Delvare, Jean " <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Sang, Wolfram" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

sorry for jumping in late. I just recently subscribed to this list.

Michael Lawnick wrote:
> For MPC adapter there is no class assigned as it is done in other
> adapters. This way no new-style client will ever be instantiated. With
> this patch class assignment is read from device tree.
> Necessary entry:
> class = <1>; /* I2C_CLASS_HWMON (iic.h) */

Do we really need that? Probing is dangerous and not necessary. Does it
not work with a proper DTS entry? But maybe I have missed something?

> Based on 2.6.29
> 
> Signed-off-by: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Sang, Wolfram <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-mpc.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -318,6 +318,7 @@ static int __devinit fsl_i2c_probe(struct of_device
> *op, const struct of_device_
>  {
>  	int result = 0;
>  	struct mpc_i2c *i2c;
> +	int *of_val;
> 
>  	i2c = kzalloc(sizeof(*i2c), GFP_KERNEL);
>  	if (!i2c)
> @@ -354,6 +355,10 @@ static int __devinit fsl_i2c_probe(struct of_device
> *op, const struct of_device_
>  	dev_set_drvdata(&op->dev, i2c);
> 
>  	i2c->adap = mpc_ops;
> +	of_val = of_get_property(op->node, "class", NULL);
> +	if(of_val)
> +		i2c->adap.class = *of_val;
> +
>  	i2c_set_adapdata(&i2c->adap, i2c);
>  	i2c->adap.dev.parent = &op->dev;

The CPM I2C bus driver uses "linux,i2c-class" for that purpose. See:

http://lxr.linux.no/linux+v2.6.29/Documentation/powerpc/dts-bindings/fsl/cpm_qe/cpm/i2c.txt

A consistent binding would be nice and the default should be "0", if we
really need legacy probing.

Furthermore, the new binding needs to be documented and published on the
Devicetree-discuss ML.

Wolfgang.
