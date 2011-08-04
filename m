From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c-designware: add OF binding support
Date: Thu, 4 Aug 2011 10:12:24 +0100
Message-ID: <20110804091223.GA19115@trinity.fluff.org>
References: <1312401863-25822-1-git-send-email-robherring2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1312401863-25822-1-git-send-email-robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Aug 03, 2011 at 03:04:23PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> 
> Add of_match_table and DT style i2c registration to designware i2c
> driver.
> 
> Signed-off-by: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> ---
>  Documentation/devicetree/bindings/i2c/dw-i2c.txt |   23 ++++++++++++++++++++++
>  drivers/i2c/busses/i2c-designware.c              |   13 ++++++++++++
>  2 files changed, 36 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/i2c/dw-i2c.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/dw-i2c.txt b/Documentation/devicetree/bindings/i2c/dw-i2c.txt
> new file mode 100644
> index 0000000..cbcb404
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/dw-i2c.txt
> @@ -0,0 +1,23 @@
> +* Synopsys DesignWare I2C
> +
> +Required properties :
> +
> + - compatible : should be "snps,designware-i2c"
> + - reg : Offset and length of the register set for the device
> + - interrupts : <IRQ> where IRQ is the interrupt number.
> +
> +Recommended properties :
> +
> + - clock-frequency : desired I2C bus clock frequency in Hz.
> +
> +Example :
> +
> +	i2c@f0000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "snps,designware-i2c";
> +		reg = <0xf0000 0x1000>;
> +		interrupts = <11>;
> +		clock-frequency = <400000>;
> +	};
> +

looks good to me.

> diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
> index b7a51c4..2911a49 100644
> --- a/drivers/i2c/busses/i2c-designware.c
> +++ b/drivers/i2c/busses/i2c-designware.c
> @@ -37,6 +37,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
> +#include <linux/of_i2c.h>
>  
>  /*
>   * Registers offset
> @@ -770,12 +771,17 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
>  	adap->algo = &i2c_dw_algo;
>  	adap->dev.parent = &pdev->dev;
>  
> +#ifdef CONFIG_OF
> +	r = i2c_add_adapter(adap);
> +#else
>  	adap->nr = pdev->id;
>  	r = i2c_add_numbered_adapter(adap);
> +#endif

I would say that doing the #ifdef CONFIG_OF is dangerous here when we
are in a mixed OF/platform enviromnent as we're depending on compile
time selection.

I'm also wondering whether we have an of helper macro which takes
a pdev and gives you an adapter number either given on pdev->id or
-1 for the case when we're using the OF bindings.

It might be worth talking to Grant about setting pdev->id to -1 if we
are using an OF device.

>  	if (r) {
>  		dev_err(&pdev->dev, "failure adding adapter\n");
>  		goto err_free_irq;
>  	}
> +	of_i2c_register_devices(adap);

If we did that, we could add a of_i2c_register_adapter() call which
would take the platform device and then do the of_i2c_register_devices()
and do these steps.

>  	return 0;
>  
> @@ -819,6 +825,12 @@ static int __devexit dw_i2c_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct of_device_id dw_i2c_of_match[] = {
> +	{ .compatible = "snps,designware-i2c", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, dw_i2c_of_match);
> +
>  /* work with hotplug and coldplug */
>  MODULE_ALIAS("platform:i2c_designware");
>  
> @@ -827,6 +839,7 @@ static struct platform_driver dw_i2c_driver = {
>  	.driver		= {
>  		.name	= "i2c_designware",
>  		.owner	= THIS_MODULE,
> +		.of_match_table = dw_i2c_of_match,

If my patch for of_match_ptr() is accepted, it will be needed here
otherwise you will need to do something about remvoing the of table
above if not config of.

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
