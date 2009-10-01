From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/4] i2c: imx: check busy bit when START/STOP
Date: Thu, 1 Oct 2009 10:38:31 +0200
Message-ID: <20091001083831.GD27039@pengutronix.de>
References: <1254359613-21210-1-git-send-email-linuxzsc@gmail.com> <4e090d470910010103o611d9fb2t3acf93632216fc88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4e090d470910010103o611d9fb2t3acf93632216fc88-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 01, 2009 at 04:03:20PM +0800, Richard Zhao wrote:
> On Thu, Oct 1, 2009 at 9:13 AM, Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wro=
te:
> > After START/RESTART, wait for busy bit to be set and
> > after STOP, wait for busy bit to be clear.
> >
> > Signed-off-by: Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >
> > diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-=
imx.c
> > index 4afba3e..156cc95 100644
> > --- a/drivers/i2c/busses/i2c-imx.c
> > +++ b/drivers/i2c/busses/i2c-imx.c
> > @@ -125,14 +125,19 @@ struct imx_i2c_struct {
> > =A0/** Functions for IMX I2C adapter driver ***********************=
****************
> > =A0****************************************************************=
***************/
> >
> > -static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx)
> > +static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int fo=
r_busy)
> > =A0{
> > =A0 =A0 =A0 =A0unsigned long orig_jiffies =3D jiffies;
> > + =A0 =A0 =A0 unsigned int temp;
> >
> > =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> >
> > - =A0 =A0 =A0 /* wait for bus not busy */
> > - =A0 =A0 =A0 while (readb(i2c_imx->base + IMX_I2C_I2SR) & I2SR_IBB=
) {
> > + =A0 =A0 =A0 temp =3D readb(i2c_imx->base + IMX_I2C_I2SR);
> > + =A0 =A0 =A0 while (1) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (for_busy && (temp & I2SR_IBB))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!for_busy && !(temp & I2SR_IBB))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (signal_pending(current)) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->ad=
apter.dev,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"<%s=
> I2C Interrupted\n", __func__);
> > @@ -144,6 +149,7 @@ static int i2c_imx_bus_busy(struct imx_i2c_stru=
ct *i2c_imx)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EIO;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0schedule();
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D readb(i2c_imx->base + IMX_I2=
C_I2SR);
> > =A0 =A0 =A0 =A0}
> >
> > =A0 =A0 =A0 =A0return 0;
> > @@ -179,20 +185,32 @@ static int i2c_imx_acked(struct imx_i2c_struc=
t *i2c_imx)
> > =A0 =A0 =A0 =A0return 0;
> > =A0}
> >
> > -static void i2c_imx_start(struct imx_i2c_struct *i2c_imx)
> > +static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
> > =A0{
> > =A0 =A0 =A0 =A0unsigned int temp =3D 0;
> > + =A0 =A0 =A0 int result;
> >
> > =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> >
> > =A0 =A0 =A0 =A0/* Enable I2C controller */
> > + =A0 =A0 =A0 writeb(0, i2c_imx->base + IMX_I2C_I2SR);
> > =A0 =A0 =A0 =A0writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
> > +
> > + =A0 =A0 =A0 result =3D i2c_imx_bus_busy(i2c_imx, 0);
> > + =A0 =A0 =A0 if (result)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return result;
> > +
> > =A0 =A0 =A0 =A0/* Start I2C transaction */
> > =A0 =A0 =A0 =A0temp =3D readb(i2c_imx->base + IMX_I2C_I2CR);
> > =A0 =A0 =A0 =A0temp |=3D I2CR_MSTA;
> > =A0 =A0 =A0 =A0writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> > + =A0 =A0 =A0 result =3D i2c_imx_bus_busy(i2c_imx, 1);
> > + =A0 =A0 =A0 if (result)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return result;
> > +
> > =A0 =A0 =A0 =A0temp |=3D I2CR_IIEN | I2CR_MTX | I2CR_TXAK;
> > =A0 =A0 =A0 =A0writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> > + =A0 =A0 =A0 return result;
> > =A0}
> >
> > =A0static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
> > @@ -202,16 +220,16 @@ static void i2c_imx_stop(struct imx_i2c_struc=
t *i2c_imx)
> > =A0 =A0 =A0 =A0/* Stop I2C transaction */
> > =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> > =A0 =A0 =A0 =A0temp =3D readb(i2c_imx->base + IMX_I2C_I2CR);
> > - =A0 =A0 =A0 temp &=3D ~I2CR_MSTA;
> > + =A0 =A0 =A0 temp &=3D ~(I2CR_MSTA | I2CR_MTX);
> > =A0 =A0 =A0 =A0writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> > - =A0 =A0 =A0 /* setup chip registers to defaults */
> > - =A0 =A0 =A0 writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
> > - =A0 =A0 =A0 writeb(0, i2c_imx->base + IMX_I2C_I2SR);
> > =A0 =A0 =A0 =A0/*
> > =A0 =A0 =A0 =A0 * This delay caused by an i.MXL hardware bug.
> > =A0 =A0 =A0 =A0 * If no (or too short) delay, no "STOP" bit will be=
 generated.
> > =A0 =A0 =A0 =A0 */
> > =A0 =A0 =A0 =A0udelay(i2c_imx->disable_delay);
> > +
> > + =A0 =A0 =A0 i2c_imx_bus_busy(i2c_imx, 0);
> > +
> > =A0 =A0 =A0 =A0/* Disable I2C controller */
> > =A0 =A0 =A0 =A0writeb(0, i2c_imx->base + IMX_I2C_I2CR);
> > =A0}
> > @@ -344,7 +362,7 @@ static int i2c_imx_read(struct imx_i2c_struct *=
i2c_imx, struct i2c_msg *msgs)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->ad=
apter.dev,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"<%s=
> clear MSTA\n", __func__);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0temp =3D readb(i2c_i=
mx->base + IMX_I2C_I2CR);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp &=3D ~I2CR_MSTA;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp &=3D ~(I2CR_MSTA=
 | I2CR_MTX);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0writeb(temp, i2c_imx=
->base + IMX_I2C_I2CR);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else if (i =3D=3D (msgs->len - 2))=
 {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->ad=
apter.dev,
> > @@ -370,14 +388,11 @@ static int i2c_imx_xfer(struct i2c_adapter *a=
dapter,
> >
> > =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> >
> > - =A0 =A0 =A0 /* Check if i2c bus is not busy */
> > - =A0 =A0 =A0 result =3D i2c_imx_bus_busy(i2c_imx);
> > + =A0 =A0 =A0 /* Start I2C transfer */
> > + =A0 =A0 =A0 result =3D i2c_imx_start(i2c_imx);
> > =A0 =A0 =A0 =A0if (result)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail0;
> >
> > - =A0 =A0 =A0 /* Start I2C transfer */
> > - =A0 =A0 =A0 i2c_imx_start(i2c_imx);
> > -
> > =A0 =A0 =A0 =A0/* read/write data */
> > =A0 =A0 =A0 =A0for (i =3D 0; i < num; i++) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (i) {
> > @@ -386,6 +401,9 @@ static int i2c_imx_xfer(struct i2c_adapter *ada=
pter,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0temp =3D readb(i2c_i=
mx->base + IMX_I2C_I2CR);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0temp |=3D I2CR_RSTA;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0writeb(temp, i2c_imx=
->base + IMX_I2C_I2CR);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D =A0i2c_imx=
_bus_busy(i2c_imx, 1);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (result)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto =
fail0;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->adapter.dev,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"<%s> transfer messa=
ge: %d\n", __func__, i);
> > --
> > 1.6.0.4
> >
> >
>=20
> Hi Sascha,
>=20
> So I assume you have no comments about this patch ?

No, I'm still thinking about it. The commit message says *what* you're
doing, but not *why*. Is it a concrete bug that you fix or is it just
because it might be a good idea to do so?
Also, we leave i2c_imx_xfer with the controller in a well defined state=
=2E
So if we leave this function with the controller in non busy state, why
do we have to check for non busy again when we enter it again?

Sascha


--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
