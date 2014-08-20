From: Romain Baeriswyl <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: deduce speed mode from device tree
 setting
Date: Wed, 20 Aug 2014 11:49:37 +0200 (CEST)
Message-ID: <944257148.1724.1408528177642.JavaMail.root@abilis.com>
References: <20140820092257.GA21174@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140820092257.GA21174@leverpostej>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, mika westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, grant likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, rafael j wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, delicious quinoa <delicious.quinoa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, yvanderv-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

With the patch "i2c designware add support of I2C standard mode" I already proposed:
- I2C standard mode is selected with 100kHz clock frequency.
- I2C fast mode is selected with 400kHy clock frequency.
- EINVAL error is returned if clock frequency is not 100000 and not 400000.

but this patch seems not available yet.
What about the other patch "i2c designware make SCL and SDA falling time configurable" ?

In i2c-designware_platdrv.c the flag DW_IC_CON_SPEED_xxx is well set
depending on the mode:

  if (clk_freq == 100000)
     dev->master_cfg =  DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
       DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_STD;
   else
     dev->master_cfg =  DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
       DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;


So for me everything should be fine if there patches are applied.

Regards,

Romain

----- Original Message -----
From: "Mark Rutland" <mark.rutland-5wv7dgnIgG8@public.gmane.org>
To: atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, "mika westerberg" <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "grant likely" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, "Romain Baeriswyl" <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, "rafael j wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "delicious quinoa" <delicious.quinoa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, yvanderv-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org
Sent: Wednesday, August 20, 2014 11:22:57 AM
Subject: Re: [PATCH] i2c: designware: deduce speed mode from device tree setting

On Tue, Aug 19, 2014 at 09:18:49PM +0100, atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org wrote:
> From: Alan Tull <atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
> 
> Use the documented, but unimplemented "clock-frequency"
> Device Tree setting as a guide on whether to set the speed
> mode bits in DW_IC_CON to standard or fast i2c mode.
> 
> Previously, the driver was hardwired to fast mode.  Default
> to fast mode if the "clock-frequency" property is not present
> for backwards compatiblity.
> 
> Signed-off-by: Alan Tull <atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index bc87733..18cd3d9 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -122,7 +122,8 @@ static int dw_i2c_probe(struct platform_device *pdev)
>  	struct dw_i2c_dev *dev;
>  	struct i2c_adapter *adap;
>  	struct resource *mem;
> -	int irq, r;
> +	int irq, r, ret, speed = DW_IC_CON_SPEED_FAST;
> +	u32 bus_rate;
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> @@ -167,6 +168,11 @@ static int dw_i2c_probe(struct platform_device *pdev)
>  		of_property_read_u32(pdev->dev.of_node,
>  				     "i2c-scl-falling-time-ns",
>  				     &dev->scl_falling_time);
> +
> +		ret = of_property_read_u32(pdev->dev.of_node,
> +					   "clock-frequency", &bus_rate);
> +		if (!ret && (bus_rate <= 100000))
> +			speed = DW_IC_CON_SPEED_STD;

This looks a bit odd.

If the device only supports two particular speeds why do we accept any
other speed in the clock-frequency property? Surely we should at least
warn that something was off?

Thanks,
Mark

>  	}
>  
>  	dev->functionality =
> @@ -177,7 +183,7 @@ static int dw_i2c_probe(struct platform_device *pdev)
>  		I2C_FUNC_SMBUS_WORD_DATA |
>  		I2C_FUNC_SMBUS_I2C_BLOCK;
>  	dev->master_cfg =  DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
> -		DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
> +		DW_IC_CON_RESTART_EN | speed;
>  
>  	/* Try first if we can configure the device from ACPI */
>  	r = dw_i2c_acpi_configure(pdev);
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
