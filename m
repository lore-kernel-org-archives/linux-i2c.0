From: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 1/2] i2c: Add Imagination Technologies I2C SCB driver
Date: Wed, 5 Nov 2014 09:37:47 +0200
Message-ID: <5459D3CB.9060204@mentor.com>
References: <1415133430-25355-1-git-send-email-ezequiel.garcia@imgtec.com> <1415133430-25355-2-git-send-email-ezequiel.garcia@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415133430-25355-2-git-send-email-ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ezequiel,

On 04.11.2014 22:37, Ezequiel Garcia wrote:
> From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> 
> Add support for the IMG I2C Serial Control Bus (SCB) found on the
> Pistachio and TZ1090 SoCs.
> 
> Signed-off-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> [Ezequiel: code cleaning and rebasing]
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/i2c/busses/Kconfig       |   10 +
>  drivers/i2c/busses/Makefile      |    1 +
>  drivers/i2c/busses/i2c-img-scb.c | 1410 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1421 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-img-scb.c
> 
> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
> new file mode 100644
> index 0000000..79ad85e
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-img-scb.c
> @@ -0,0 +1,1410 @@
> +/*
> + * I2C adapter for the IMG Serial Control Bus (SCB) IP block.
> + *

[snip]

> +	/*
> +	 * Get the bus number from the devicetree. Other I2C adapters may be
> +	 * reserved for non-Linux core. Instead of letting Linux pick any
> +	 * number, it's useful to fix the bus number so users get a consistent
> +	 * view.
> +	 */
> +	ret = of_property_read_u32(node, "linux,i2c-index", &val);
> +	if (!ret)
> +		i2c->adap.nr = val;
> +	else
> +		i2c->adap.nr = pdev->id;
> +

if I'm not mistaken "linux,i2c-index" property is redundant, talking
about Linux you can set up an arbitrary bus number by specifying a DTS
alias.

Most probably just

    i2c->adap.nr = pdev->id;

may serve your purposes.

[snip]

> +
> +	ret = i2c_add_numbered_adapter(&i2c->adap);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to add adapter\n");
> +		goto disable_clk;
> +	}
> +
> +	return 0;
> +
> +disable_clk:
> +	clk_disable_unprepare(i2c->sys_clk);
> +	return ret;
> +}
> +

With best wishes,
Vladimir
