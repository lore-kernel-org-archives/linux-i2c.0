From: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: bfin: turn to Resource-managed API in probe function
Date: Tue, 25 Mar 2014 16:42:11 +0800
Message-ID: <CAJxxZ0O_vA-awrE-dKq6cyCD6ac6RJkMMhT_Zj3e48YnJRejxg@mail.gmail.com>
References: <1394445784-4653-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1394445784-4653-1-git-send-email-sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

PING

On Mon, Mar 10, 2014 at 6:03 PM, Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>
> No need to free managed resources any more.
>
> Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-bfin-twi.c | 40 +++++++++++++--------------------------
>  1 file changed, 13 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
> index 3b9bd9a..a5630c6 100644
> --- a/drivers/i2c/busses/i2c-bfin-twi.c
> +++ b/drivers/i2c/busses/i2c-bfin-twi.c
> @@ -633,11 +633,11 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
>         int rc;
>         unsigned int clkhilow;
>
> -       iface = kzalloc(sizeof(struct bfin_twi_iface), GFP_KERNEL);
> +       iface = devm_kzalloc(&pdev->dev, sizeof(struct bfin_twi_iface),
> +                       GFP_KERNEL);
>         if (!iface) {
>                 dev_err(&pdev->dev, "Cannot allocate memory\n");
> -               rc = -ENOMEM;
> -               goto out_error_nomem;
> +               return -ENOMEM;
>         }
>
>         spin_lock_init(&(iface->lock));
> @@ -646,22 +646,19 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         if (res == NULL) {
>                 dev_err(&pdev->dev, "Cannot get IORESOURCE_MEM\n");
> -               rc = -ENOENT;
> -               goto out_error_get_res;
> +               return -ENOENT;
>         }
>
> -       iface->regs_base = ioremap(res->start, resource_size(res));
> -       if (iface->regs_base == NULL) {
> +       iface->regs_base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR((void *)iface->regs_base)) {
>                 dev_err(&pdev->dev, "Cannot map IO\n");
> -               rc = -ENXIO;
> -               goto out_error_ioremap;
> +               return PTR_ERR((void *)iface->regs_base);
>         }
>
>         iface->irq = platform_get_irq(pdev, 0);
>         if (iface->irq < 0) {
>                 dev_err(&pdev->dev, "No IRQ specified\n");
> -               rc = -ENOENT;
> -               goto out_error_no_irq;
> +               return -ENOENT;
>         }
>
>         p_adap = &iface->adap;
> @@ -679,15 +676,15 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
>                         "i2c-bfin-twi");
>         if (rc) {
>                 dev_err(&pdev->dev, "Can't setup pin mux!\n");
> -               goto out_error_pin_mux;
> +               return -EBUSY;
>         }
>
> -       rc = request_irq(iface->irq, bfin_twi_interrupt_entry,
> +       rc = devm_request_irq(&pdev->dev, iface->irq, bfin_twi_interrupt_entry,
>                 0, pdev->name, iface);
>         if (rc) {
>                 dev_err(&pdev->dev, "Can't get IRQ %d !\n", iface->irq);
>                 rc = -ENODEV;
> -               goto out_error_req_irq;
> +               goto out_error;
>         }
>
>         /* Set TWI internal clock as 10MHz */
> @@ -709,7 +706,7 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
>         rc = i2c_add_numbered_adapter(p_adap);
>         if (rc < 0) {
>                 dev_err(&pdev->dev, "Can't add i2c adapter!\n");
> -               goto out_error_add_adapter;
> +               goto out_error;
>         }
>
>         platform_set_drvdata(pdev, iface);
> @@ -719,17 +716,8 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
>
>         return 0;
>
> -out_error_add_adapter:
> -       free_irq(iface->irq, iface);
> -out_error_req_irq:
> -out_error_no_irq:
> +out_error:
>         peripheral_free_list(dev_get_platdata(&pdev->dev));
> -out_error_pin_mux:
> -       iounmap(iface->regs_base);
> -out_error_ioremap:
> -out_error_get_res:
> -       kfree(iface);
> -out_error_nomem:
>         return rc;
>  }
>
> @@ -740,8 +728,6 @@ static int i2c_bfin_twi_remove(struct platform_device *pdev)
>         i2c_del_adapter(&(iface->adap));
>         free_irq(iface->irq, iface);
>         peripheral_free_list(dev_get_platdata(&pdev->dev));
> -       iounmap(iface->regs_base);
> -       kfree(iface);
>
>         return 0;
>  }
> --
> 1.8.2.3
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
