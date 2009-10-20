From: Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V1 1/3] i2c: imx: check busy bit when START/STOP
Date: Tue, 20 Oct 2009 18:03:31 +0800
Message-ID: <4e090d470910200303x598aac39n13be631225d01057@mail.gmail.com>
References: <1255772784-11387-1-git-send-email-linuxzsc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1255772784-11387-1-git-send-email-linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Oct 17, 2009 at 5:46 PM, Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrot=
e:
> The controller can't do anything else before it actually generates ST=
ART/STOP.
> So we check busy bit to make sure START/STOP is successfully finished=
=2E
>
> If we don't check busy bit, START/STOP may fail on some fast CPUs.
>
> Signed-off-by: Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-im=
x.c
> index 4afba3e..6055e92 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -120,19 +120,25 @@ struct imx_i2c_struct {
> =A0 =A0 =A0 =A0wait_queue_head_t =A0 =A0 =A0 queue;
> =A0 =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 i2csr;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0disable_delay;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 stopped;
> =A0};
>
> =A0/** Functions for IMX I2C adapter driver *************************=
**************
> =A0******************************************************************=
*************/
>
> -static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx)
> +static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_=
busy)
> =A0{
> =A0 =A0 =A0 =A0unsigned long orig_jiffies =3D jiffies;
> + =A0 =A0 =A0 unsigned int temp;
>
> =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
>
> - =A0 =A0 =A0 /* wait for bus not busy */
> - =A0 =A0 =A0 while (readb(i2c_imx->base + IMX_I2C_I2SR) & I2SR_IBB) =
{
> + =A0 =A0 =A0 while (1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D readb(i2c_imx->base + IMX_I2C_=
I2SR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (for_busy && (temp & I2SR_IBB))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!for_busy && !(temp & I2SR_IBB))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (signal_pending(current)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->adap=
ter.dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"<%s> =
I2C Interrupted\n", __func__);
> @@ -179,39 +185,55 @@ static int i2c_imx_acked(struct imx_i2c_struct =
*i2c_imx)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static void i2c_imx_start(struct imx_i2c_struct *i2c_imx)
> +static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
> =A0{
> =A0 =A0 =A0 =A0unsigned int temp =3D 0;
> + =A0 =A0 =A0 int result;
>
> =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
>
> =A0 =A0 =A0 =A0/* Enable I2C controller */
> + =A0 =A0 =A0 writeb(0, i2c_imx->base + IMX_I2C_I2SR);
> =A0 =A0 =A0 =A0writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
> +
> + =A0 =A0 =A0 /* Wait controller to be stable */
> + =A0 =A0 =A0 udelay(50);
> +
> =A0 =A0 =A0 =A0/* Start I2C transaction */
> =A0 =A0 =A0 =A0temp =3D readb(i2c_imx->base + IMX_I2C_I2CR);
> =A0 =A0 =A0 =A0temp |=3D I2CR_MSTA;
> =A0 =A0 =A0 =A0writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> + =A0 =A0 =A0 result =3D i2c_imx_bus_busy(i2c_imx, 1);
> + =A0 =A0 =A0 if (result)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return result;
> + =A0 =A0 =A0 i2c_imx->stopped =3D 0;
> +
> =A0 =A0 =A0 =A0temp |=3D I2CR_IIEN | I2CR_MTX | I2CR_TXAK;
> =A0 =A0 =A0 =A0writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> + =A0 =A0 =A0 return result;
> =A0}
>
> =A0static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
> =A0{
> =A0 =A0 =A0 =A0unsigned int temp =3D 0;
>
> - =A0 =A0 =A0 /* Stop I2C transaction */
> - =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> - =A0 =A0 =A0 temp =3D readb(i2c_imx->base + IMX_I2C_I2CR);
> - =A0 =A0 =A0 temp &=3D ~I2CR_MSTA;
> - =A0 =A0 =A0 writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> - =A0 =A0 =A0 /* setup chip registers to defaults */
> - =A0 =A0 =A0 writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
> - =A0 =A0 =A0 writeb(0, i2c_imx->base + IMX_I2C_I2SR);
> + =A0 =A0 =A0 if (!i2c_imx->stopped) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Stop I2C transaction */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "<%s>\n"=
, __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D readb(i2c_imx->base + IMX_I2C_=
I2CR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp &=3D ~(I2CR_MSTA | I2CR_MTX);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(temp, i2c_imx->base + IMX_I2C_I2=
CR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_imx->stopped =3D 1;
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * This delay caused by an i.MXL hardware bug.
> =A0 =A0 =A0 =A0 * If no (or too short) delay, no "STOP" bit will be g=
enerated.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0udelay(i2c_imx->disable_delay);
> +
> + =A0 =A0 =A0 if (!i2c_imx->stopped)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_imx_bus_busy(i2c_imx, 0);
> +
> =A0 =A0 =A0 =A0/* Disable I2C controller */
> =A0 =A0 =A0 =A0writeb(0, i2c_imx->base + IMX_I2C_I2CR);
> =A0}
> @@ -341,11 +363,15 @@ static int i2c_imx_read(struct imx_i2c_struct *=
i2c_imx, struct i2c_msg *msgs)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (result)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return result;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (i =3D=3D (msgs->len - 1)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* It must generate STO=
P before read I2DR to prevent
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0controller from =
generating another clock cycle */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->adap=
ter.dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"<%s> =
clear MSTA\n", __func__);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0temp =3D readb(i2c_imx=
->base + IMX_I2C_I2CR);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp &=3D ~I2CR_MSTA;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp &=3D ~(I2CR_MSTA |=
 I2CR_MTX);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0writeb(temp, i2c_imx->=
base + IMX_I2C_I2CR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_imx_bus_busy(i2c_im=
x, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_imx->stopped =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else if (i =3D=3D (msgs->len - 2)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->adap=
ter.dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"<%s> =
set TXAK\n", __func__);
> @@ -370,14 +396,11 @@ static int i2c_imx_xfer(struct i2c_adapter *ada=
pter,
>
> =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
>
> - =A0 =A0 =A0 /* Check if i2c bus is not busy */
> - =A0 =A0 =A0 result =3D i2c_imx_bus_busy(i2c_imx);
> + =A0 =A0 =A0 /* Start I2C transfer */
> + =A0 =A0 =A0 result =3D i2c_imx_start(i2c_imx);
> =A0 =A0 =A0 =A0if (result)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail0;
>
> - =A0 =A0 =A0 /* Start I2C transfer */
> - =A0 =A0 =A0 i2c_imx_start(i2c_imx);
> -
> =A0 =A0 =A0 =A0/* read/write data */
> =A0 =A0 =A0 =A0for (i =3D 0; i < num; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (i) {
> @@ -386,6 +409,9 @@ static int i2c_imx_xfer(struct i2c_adapter *adapt=
er,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0temp =3D readb(i2c_imx=
->base + IMX_I2C_I2CR);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0temp |=3D I2CR_RSTA;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0writeb(temp, i2c_imx->=
base + IMX_I2C_I2CR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D =A0i2c_imx_b=
us_busy(i2c_imx, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (result)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fa=
il0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->adapter.dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"<%s> transfer message=
: %d\n", __func__, i);
> --
> 1.6.0.4
>
>
Hello Sascha,

Could you please review this series of patch?

Thanks
Richard
