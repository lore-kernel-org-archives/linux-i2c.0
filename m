From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] i2c: imx: convert to use managed functions
Date: Mon, 4 Jun 2012 10:29:11 +0530
Message-ID: <CAM=Q2ctTNs0hq9tO5NW0QGsGaOVMNobRSBg_TmCjbaV+hNaoAw@mail.gmail.com>
References: <1338776481-23710-1-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1338776481-23710-1-git-send-email-richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Richard Zhao <richard.zhao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi  Richard,

On Mon, Jun 4, 2012 at 7:51 AM, Richard Zhao <richard.zhao-KZfg59tc24x4beGV+Eop3g@public.gmane.org=
m> wrote:
> From: Richard Zhao <richard.zhao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
nit: A small description would have helped.
Otherwise Looks good to me.
Reviewed-by: Shubhrajyoti D <Shubhrajyoti-l0cyMroinI0@public.gmane.org>
>
> Signed-off-by: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>
> Changes since v1:
> =A0- rebase to 3.5rc1
> =A0- remove unused imx_i2c_struct.irq.
>
> =A0drivers/i2c/busses/i2c-imx.c | =A0 67 ++++++++++------------------=
-------------
> =A01 files changed, 17 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-im=
x.c
> index 8d6b504..7f4da2d 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -118,10 +118,8 @@ static u16 __initdata i2c_clk_div[50][2] =3D {
>
> =A0struct imx_i2c_struct {
> =A0 =A0 =A0 =A0struct i2c_adapter =A0 =A0 =A0adapter;
> - =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 *res;
> =A0 =A0 =A0 =A0struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*clk;
> =A0 =A0 =A0 =A0void __iomem =A0 =A0 =A0 =A0 =A0 =A0*base;
> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq;
> =A0 =A0 =A0 =A0wait_queue_head_t =A0 =A0 =A0 queue;
> =A0 =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 i2csr;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0disable_delay;
> @@ -473,7 +471,6 @@ static int __init i2c_imx_probe(struct platform_d=
evice *pdev)
> =A0 =A0 =A0 =A0struct imxi2c_platform_data *pdata =3D pdev->dev.platf=
orm_data;
> =A0 =A0 =A0 =A0struct pinctrl *pinctrl;
> =A0 =A0 =A0 =A0void __iomem *base;
> - =A0 =A0 =A0 resource_size_t res_size;
> =A0 =A0 =A0 =A0int irq, bitrate;
> =A0 =A0 =A0 =A0int ret;
>
> @@ -490,25 +487,16 @@ static int __init i2c_imx_probe(struct platform=
_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOENT;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 res_size =3D resource_size(res);
> -
> - =A0 =A0 =A0 if (!request_mem_region(res->start, res_size, DRIVER_NA=
ME)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "request_mem_region=
 failed\n");
> + =A0 =A0 =A0 base =3D devm_request_and_ioremap(&pdev->dev, res);
> + =A0 =A0 =A0 if (!base)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EBUSY;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 base =3D ioremap(res->start, res_size);
> - =A0 =A0 =A0 if (!base) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "ioremap failed\n")=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EIO;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail1;
> - =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 i2c_imx =3D kzalloc(sizeof(struct imx_i2c_struct), GFP_=
KERNEL);
> + =A0 =A0 =A0 i2c_imx =3D devm_kzalloc(&pdev->dev, sizeof(struct imx_=
i2c_struct),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KER=
NEL);
> =A0 =A0 =A0 =A0if (!i2c_imx) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "can't allocate in=
terface\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -ENOMEM;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
nit : why not return ENOMEM directly, the copy to ret is redundant.
feel free to ignore if you  feel so.
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Setup i2c_imx driver structure */
> @@ -518,29 +506,28 @@ static int __init i2c_imx_probe(struct platform=
_device *pdev)
> =A0 =A0 =A0 =A0i2c_imx->adapter.dev.parent =A0 =A0 =3D &pdev->dev;
> =A0 =A0 =A0 =A0i2c_imx->adapter.nr =A0 =A0 =A0 =A0 =A0 =A0 =3D pdev->=
id;
> =A0 =A0 =A0 =A0i2c_imx->adapter.dev.of_node =A0 =A0=3D pdev->dev.of_n=
ode;
> - =A0 =A0 =A0 i2c_imx->irq =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D=
 irq;
> =A0 =A0 =A0 =A0i2c_imx->base =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D =
base;
> - =A0 =A0 =A0 i2c_imx->res =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D=
 res;
>
> =A0 =A0 =A0 =A0pinctrl =3D devm_pinctrl_get_select_default(&pdev->dev=
);
> =A0 =A0 =A0 =A0if (IS_ERR(pinctrl)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D PTR_ERR(pinctrl);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Get I2C clock */
> - =A0 =A0 =A0 i2c_imx->clk =3D clk_get(&pdev->dev, "i2c_clk");
> + =A0 =A0 =A0 i2c_imx->clk =3D devm_clk_get(&pdev->dev, "i2c_clk");
> =A0 =A0 =A0 =A0if (IS_ERR(i2c_imx->clk)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D PTR_ERR(i2c_imx->clk);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "can't get I2C clo=
ck\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Request IRQ */
> - =A0 =A0 =A0 ret =3D request_irq(i2c_imx->irq, i2c_imx_isr, 0, pdev-=
>name, i2c_imx);
> + =A0 =A0 =A0 ret =3D devm_request_irq(&pdev->dev, irq, i2c_imx_isr, =
0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev->n=
ame, i2c_imx);
> =A0 =A0 =A0 =A0if (ret) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "can't claim irq %d=
\n", i2c_imx->irq);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "can't claim irq %d=
\n", irq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Init queue */
> @@ -565,7 +552,7 @@ static int __init i2c_imx_probe(struct platform_d=
evice *pdev)
> =A0 =A0 =A0 =A0ret =3D i2c_add_numbered_adapter(&i2c_imx->adapter);
> =A0 =A0 =A0 =A0if (ret < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "registration fail=
ed\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail5;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0of_i2c_register_devices(&i2c_imx->adapter);
> @@ -573,28 +560,16 @@ static int __init i2c_imx_probe(struct platform=
_device *pdev)
> =A0 =A0 =A0 =A0/* Set up platform driver data */
> =A0 =A0 =A0 =A0platform_set_drvdata(pdev, i2c_imx);
>
> - =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "claimed irq %d\n", i2c_=
imx->irq);
> + =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "claimed irq %d\n", irq)=
;
> =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->adapter.dev, "device resources from =
0x%x to 0x%x\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_imx->res->start, i2c_imx->res->end)=
;
> - =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "allocated %d bytes at 0=
x%x \n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 res_size, i2c_imx->res->start);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->start, res->end);
> + =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "allocated %d bytes at 0=
x%x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 resource_size(res), res->start);
> =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->adapter.dev, "adapter name: \"%s\"\n=
",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i2c_imx->adapter.name);
> =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->adapter.dev, "IMX I2C adapter regist=
ered\n");
>
> =A0 =A0 =A0 =A0return 0; =A0 /* Return OK */
> -
> -fail5:
> - =A0 =A0 =A0 free_irq(i2c_imx->irq, i2c_imx);
> -fail4:
> - =A0 =A0 =A0 clk_put(i2c_imx->clk);
> -fail3:
> - =A0 =A0 =A0 kfree(i2c_imx);
> -fail2:
> - =A0 =A0 =A0 iounmap(base);
> -fail1:
> - =A0 =A0 =A0 release_mem_region(res->start, resource_size(res));
> - =A0 =A0 =A0 return ret; /* Return error number */
> =A0}
>
> =A0static int __exit i2c_imx_remove(struct platform_device *pdev)
> @@ -606,20 +581,12 @@ static int __exit i2c_imx_remove(struct platfor=
m_device *pdev)
> =A0 =A0 =A0 =A0i2c_del_adapter(&i2c_imx->adapter);
> =A0 =A0 =A0 =A0platform_set_drvdata(pdev, NULL);
>
> - =A0 =A0 =A0 /* free interrupt */
> - =A0 =A0 =A0 free_irq(i2c_imx->irq, i2c_imx);
> -
> =A0 =A0 =A0 =A0/* setup chip registers to defaults */
> =A0 =A0 =A0 =A0writeb(0, i2c_imx->base + IMX_I2C_IADR);
> =A0 =A0 =A0 =A0writeb(0, i2c_imx->base + IMX_I2C_IFDR);
> =A0 =A0 =A0 =A0writeb(0, i2c_imx->base + IMX_I2C_I2CR);
> =A0 =A0 =A0 =A0writeb(0, i2c_imx->base + IMX_I2C_I2SR);
>
> - =A0 =A0 =A0 clk_put(i2c_imx->clk);
> -
> - =A0 =A0 =A0 iounmap(i2c_imx->base);
> - =A0 =A0 =A0 release_mem_region(i2c_imx->res->start, resource_size(i=
2c_imx->res));
> - =A0 =A0 =A0 kfree(i2c_imx);
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> --
> 1.7.5.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
