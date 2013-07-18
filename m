From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] i2c: mpc: Define unique I2C adapter names
Date: Thu, 18 Jul 2013 14:34:24 -0700
Message-ID: <20130718213424.GB6237@roeck-us.net>
References: <1373483001-24951-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1373483001-24951-1-git-send-email-linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jul 10, 2013 at 12:03:21PM -0700, Guenter Roeck wrote:
> The I2C adapters on Freescale MPC107/824x/85xx/512x/52xx/83xx/86xx all
> have the same name "MPC adapter". Since I2C adapter numbers can change
> across reboots and even after loading/unloading an I2C bus master driver,
> adapter names have to be used to identify adapters and thus should be
> unique and well defined. Since this is not the case with this driver,
> it is difficult if not impossible to identify a specific adapter from
> user space on affected platforms.
> 
> To remedy the problem, use the adapter memory address as part of the
> adapter name.
> 
ping ... any comments on this patch ?

Thanks,
Guenter

> With this patch, adapter names are:
> On P2020:
> MPC adapter at 0xfff703000
> MPC adapter at 0xfff703100
> 
> On P5040:
> MPC adapter at 0xffe118000
> MPC adapter at 0xffe118100
> MPC adapter at 0xffe119000
> MPC adapter at 0xffe119100
> 
> Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-mpc.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> index 7607dc0..99acf63 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -609,7 +609,6 @@ static const struct i2c_algorithm mpc_algo = {
>  
>  static struct i2c_adapter mpc_ops = {
>  	.owner = THIS_MODULE,
> -	.name = "MPC adapter",
>  	.algo = &mpc_algo,
>  	.timeout = HZ,
>  };
> @@ -623,6 +622,7 @@ static int fsl_i2c_probe(struct platform_device *op)
>  	u32 clock = MPC_I2C_CLOCK_LEGACY;
>  	int result = 0;
>  	int plen;
> +	struct resource res;
>  
>  	match = of_match_device(mpc_i2c_of_match, &op->dev);
>  	if (!match)
> @@ -682,6 +682,9 @@ static int fsl_i2c_probe(struct platform_device *op)
>  	platform_set_drvdata(op, i2c);
>  
>  	i2c->adap = mpc_ops;
> +	of_address_to_resource(op->dev.of_node, 0, &res);
> +	scnprintf(i2c->adap.name, sizeof(i2c->adap.name),
> +		  "MPC adapter at 0x%llx", (unsigned long long)res.start);
>  	i2c_set_adapdata(&i2c->adap, i2c);
>  	i2c->adap.dev.parent = &op->dev;
>  	i2c->adap.dev.of_node = of_node_get(op->dev.of_node);
> -- 
> 1.7.9.7
> 
> 
