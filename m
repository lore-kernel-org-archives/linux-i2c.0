From: Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: Re: Fwd: [PATCH 1/3] i2c: Add Device Tree support to the Nomadik
 I2C driver
Date: Fri, 15 Jun 2012 17:20:43 +0530
Message-ID: <20120615115042.GA27480@bnru02>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-10-git-send-email-lee.jones@linaro.org>
 <CACRpkdaMDbH4NkiHRLAfbJZ_j4QXbwg94bvaWsdYRPH+dSfc8Q@mail.gmail.com>
 <4FD8BAD2.50703@linaro.org>
 <CACRpkdZFi34nChnMEo6yik67zk9owZLk-6zcdP7mmOXyLz8uqQ@mail.gmail.com>
 <4FDAFA17.6050502@linaro.org>
 <CAE2-_9rRYxjU9QQgtBv9ReMY5x+oRiJG1cDQahYHanjDrwVUYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAE2-_9rRYxjU9QQgtBv9ReMY5x+oRiJG1cDQahYHanjDrwVUYA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

[...]
> 
> 
> From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Date: Tue, 17 Apr 2012 16:04:13 +0100
> Subject: [PATCH 1/1] i2c: Add Device Tree support to the Nomadik I2C driver
> 
> Here we apply the bindings required for successful Device Tree
> probing of the i2c-nomadik driver. We also apply a fall-back
> configuration in case either one is not provided, or a required
> element is missing from the one supplied.
> 
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-nomadik.c |   82 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 80 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
> index a92440d..58e8114 100644
> --- a/drivers/i2c/busses/i2c-nomadik.c
> +++ b/drivers/i2c/busses/i2c-nomadik.c
> @@ -23,6 +23,7 @@
>  #include <linux/io.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/of.h>
> 
>  #include <plat/i2c.h>
> 
> @@ -899,15 +900,86 @@ static const struct i2c_algorithm nmk_i2c_algo = {
>        .functionality  = nmk_i2c_functionality
>  };
> 
> +static struct nmk_i2c_controller u8500_i2c = {
> +       /*
> +        * Slave data setup time; 250ns, 100ns, and 10ns, which
> +        * is 14, 6 and 2 respectively for a 48Mhz i2c clock.
> +        */
> +       .slsu           = 0xe,
> +       .tft            = 1,      /* Tx FIFO threshold */
> +       .rft            = 8,      /* Rx FIFO threshold */
> +       .clk_freq       = 100000, /* std. mode operation */
> +       .timeout        = 200,    /* Slave response timeout(ms) */
> +       .sm             = I2C_FREQ_MODE_FAST,

How is this possible? you are setting clk_freq as 100kb/s and mode
as fast mode which is supposed to be 400kb/s.

> +};
> +
> +static int __devinit
> +nmk_i2c_of_probe(struct device_node *np, struct nmk_i2c_controller *pdata)
> +{
> +       of_property_read_u32(np, "clock-frequency", (u32*)&pdata->clk_freq);
> +       if (!pdata->clk_freq) {
> +               pr_warn("%s: Clock frequency not found\n", np->full_name);
> +               return -EINVAL;
> +       }
> +
> +       of_property_read_u32(np, "stericsson,slsu", (u32*)&pdata->slsu);
> +       if (!pdata->slsu) {
> +               pr_warn("%s: Data line delay not found\n", np->full_name);
> +               return -EINVAL;
> +       }
> +
> +       of_property_read_u32(np, "stericsson,tft", (u32*)&pdata->tft);
> +       if (!pdata->tft) {
> +               pr_warn("%s: Tx FIFO threshold not found\n", np->full_name);
> +               return -EINVAL;
> +       }
> +
> +       of_property_read_u32(np, "stericsson,rft", (u32*)&pdata->rft);
> +       if (!pdata->rft) {
> +               pr_warn("%s: Rx FIFO threshold not found\n", np->full_name);
> +               return -EINVAL;
> +       }
> +
> +       of_property_read_u32(np, "stericsson,timeout", (u32*)&pdata->timeout);
> +       if (!pdata->timeout) {
> +               pr_warn("%s: Timeout not found\n", np->full_name);
> +               return -EINVAL;
> +       }
> +
> +       if (of_get_property(np, "stericsson,i2c_freq_mode_fast", NULL))
> +               pdata->sm = I2C_FREQ_MODE_FAST;
> +       else
> +               pdata->sm = I2C_FREQ_MODE_STANDARD;

The controller has more modes like fast mode plus and high speed mode. You can't make
assumptions like this.

> +
> +       return 0;
> +}
> +
>  static int __devinit nmk_i2c_probe(struct platform_device *pdev)
>  {
>        int ret = 0;
>        struct resource *res;
> -       struct nmk_i2c_controller *pdata =
> -                       pdev->dev.platform_data;
> +       struct nmk_i2c_controller *pdata = pdev->dev.platform_data;
> +       struct device_node *np = pdev->dev.of_node;
>        struct nmk_i2c_dev      *dev;
>        struct i2c_adapter *adap;
> 
> +       if (np) {
> +               if (!pdata) {
> +                       pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +                       if (!pdata) {
> +                               ret = -ENOMEM;
> +                               goto err_no_mem;
> +                       }
> +               }
> +               ret = nmk_i2c_of_probe(np, pdata);
> +               if (ret)
> +                       kfree(pdata);
> +       }
> +
> +       if (!pdata)
> +               /* No i2c configuration found, using the default. */
> +               pdata = &u8500_i2c;

There are redundant fallback configurations exists in the driver. You might need to remove 
those, if you want to fallback here.

> +
>        dev = kzalloc(sizeof(struct nmk_i2c_dev), GFP_KERNEL);
>        if (!dev) {
>                dev_err(&pdev->dev, "cannot allocate memory\n");
> @@ -1038,11 +1110,17 @@ static int __devexit nmk_i2c_remove(struct platform_device *pdev)
>        return 0;
>  }
> 
> +static const struct of_device_id nmk_gpio_match[] = {
> +       { .compatible = "st,nomadik-i2c", },
> +       {},
> +};
> +
>  static struct platform_driver nmk_i2c_driver = {
>        .driver = {
>                .owner = THIS_MODULE,
>                .name = DRIVER_NAME,
>                .pm = &nmk_i2c_pm,
> +               .of_match_table = nmk_gpio_match,
>        },
>        .probe = nmk_i2c_probe,
>        .remove = __devexit_p(nmk_i2c_remove),
> --
> 1.7.9.5
> 

/srinidhi 
