From: christian.ruppert-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org
Subject: Re: [PATCH v2] i2c: designware: Suppress error message if platform_get_irq() < 0
Date: Mon, 9 Mar 2015 17:34:51 +0100
Message-ID: <OFBD47D4C1.937484E0-ONC1257E03.005AABCB-C1257E03.005B051D@alitech.com>
References: <1425891792-9248-1-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425891792-9248-1-git-send-email-abrodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org> wrote on 03/09/2015 10:03:12 
AM:

> From: Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
> To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 
> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexey Brodkin 
> <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Vineet Gupta 
> <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Christian Ruppert 
> <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Mika Westerberg 
> <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
> Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Date: 03/09/2015 10:03 AM
> 
> As discussed here https://lkml.org/lkml/2015/3/3/568 and here
> https://lkml.org/lkml/2015/3/3/453 we're looking forward for
> implementing warnings and errors outputs right in platform_get_irq()
> instead of having all kind of different outputs in each and every driver
> that uses platform_get_irq().
> 
> Signed-off-by: Alexey Brodkin <abrodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
> Cc: Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
> Cc: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Acked-by: Christian Ruppert <christian.ruppert-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org>

Please note that my email address has changed and use the alitech one in 
future. The abilis address might be switched off soon.

> Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/
> i2c/busses/i2c-designware-platdrv.c
> index c270f5f..fa4e2b5 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -143,10 +143,8 @@ static int dw_i2c_probe(struct platform_device 
*pdev)
>     u32 clk_freq, ht = 0;
> 
>     irq = platform_get_irq(pdev, 0);
> -   if (irq < 0) {
> -      dev_err(&pdev->dev, "no irq resource?\n");
> -      return irq; /* -ENXIO */
> -   }
> +   if (irq < 0)
> +      return irq;
> 
>     dev = devm_kzalloc(&pdev->dev, sizeof(struct dw_i2c_dev), 
GFP_KERNEL);
>     if (!dev)
> -- 
> 2.1.0
> 
