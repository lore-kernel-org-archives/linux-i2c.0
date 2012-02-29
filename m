From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-mpc: avoid I2C abnormal after resuming from deep sleep
Date: Wed, 29 Feb 2012 18:32:05 +0530
Message-ID: <CAM=Q2ctLm8FKgTek6u9H0jzWJv1bbBUnvDHZfEA=p2ReK8ybUQ@mail.gmail.com>
References: <1330511961-22498-1-git-send-email-chenhui.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1330511961-22498-1-git-send-email-chenhui.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhao Chenhui <chenhui.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Li Yang <leoli-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Zhao,

On Wed, Feb 29, 2012 at 4:09 PM, Zhao Chenhui
<chenhui.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> When entering deep sleep, the value in the registers I2CFDR and
> I2CDFSRR are lost. This causes I2C access to fail after resuming.
>
> Add suspend/resume routines to save/restore the registers
> I2CFDR and I2CDFSRR.
>
> Signed-off-by: Zhao Chenhui <chenhui.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Signed-off-by: Li Yang <leoli-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
> =A0drivers/i2c/busses/i2c-mpc.c | =A0 34 ++++++++++++++++++++++++++++=
+++++-
> =A01 files changed, 33 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mp=
c.c
> index a8ebb84..f95a647 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -1,7 +1,9 @@
> =A0/*
> =A0* (C) Copyright 2003-2004
> =A0* Humboldt Solutions Ltd, adrian-nKrwMtk+6WksDtB2XHyCLA@public.gmane.org
> -
> + *
> + * Copyright 2012 Freescale Semiconductor, Inc.
> + *
> =A0* This is a combined i2c adapter and algorithm driver for the
> =A0* MPC107/Tsi107 PowerPC northbridge and processors that include
> =A0* the same I2C unit (8240, 8245, 85xx).
> @@ -64,6 +66,9 @@ struct mpc_i2c {
> =A0 =A0 =A0 =A0struct i2c_adapter adap;
> =A0 =A0 =A0 =A0int irq;
> =A0 =A0 =A0 =A0u32 real_clk;
> +#ifdef CONFIG_PM
> + =A0 =A0 =A0 u8 fdr, dfsrr;
How about having  a structure here ?
> +#endif
> =A0};
>
> =A0struct mpc_i2c_divider {
> @@ -668,6 +673,30 @@ static int __devexit fsl_i2c_remove(struct platf=
orm_device *op)
> =A0 =A0 =A0 =A0return 0;
> =A0};
>
> +#ifdef CONFIG_PM
> +static int mpc_i2c_suspend(struct device *dev)
> +{
> + =A0 =A0 =A0 struct mpc_i2c *i2c =3D dev_get_drvdata(dev);
> +
> + =A0 =A0 =A0 i2c->fdr =3D readb(i2c->base + MPC_I2C_FDR);
> + =A0 =A0 =A0 i2c->dfsrr =3D readb(i2c->base + MPC_I2C_DFSRR);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int mpc_i2c_resume(struct device *dev)
> +{
> + =A0 =A0 =A0 struct mpc_i2c *i2c =3D dev_get_drvdata(dev);
> +
> + =A0 =A0 =A0 writeb(i2c->fdr, i2c->base + MPC_I2C_FDR);
> + =A0 =A0 =A0 writeb(i2c->dfsrr, i2c->base + MPC_I2C_DFSRR);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +SIMPLE_DEV_PM_OPS(mpc_i2c_pm_ops, mpc_i2c_suspend, mpc_i2c_resume);
> +#endif
> +
> =A0static struct mpc_i2c_data mpc_i2c_data_512x __devinitdata =3D {
> =A0 =A0 =A0 =A0.setup =3D mpc_i2c_setup_512x,
> =A0};
> @@ -712,6 +741,9 @@ static struct platform_driver mpc_i2c_driver =3D =
{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =3D THIS_MODULE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D DRV_NAME,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.of_match_table =3D mpc_i2c_of_match,
> +#ifdef CONFIG_PM
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =3D &mpc_i2c_pm_ops,
> +#endif
> =A0 =A0 =A0 =A0},
> =A0};
>
> --
> 1.6.4.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
