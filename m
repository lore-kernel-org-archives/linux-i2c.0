From: Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] i2c: imx: check busy bit when START/STOP
Date: Thu, 1 Oct 2009 22:54:46 +0800
Message-ID: <4e090d470910010754r1ebc4455u6220ccfd803491b0@mail.gmail.com>
References: <1254359613-21210-1-git-send-email-linuxzsc@gmail.com>
	 <4e090d470910010103o611d9fb2t3acf93632216fc88@mail.gmail.com>
	 <20091001083831.GD27039@pengutronix.de>
	 <4e090d470910010211k4ce78763i1a5163ec6ea57fe8@mail.gmail.com>
	 <20091001095239.GE27039@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091001095239.GE27039-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 1, 2009 at 5:52 PM, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> w=
rote:
> On Thu, Oct 01, 2009 at 05:11:30PM +0800, Richard Zhao wrote:
>> On Thu, Oct 1, 2009 at 4:38 PM, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org=
> wrote:
>> > On Thu, Oct 01, 2009 at 04:03:20PM +0800, Richard Zhao wrote:
>> >> On Thu, Oct 1, 2009 at 9:13 AM, Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>=
 wrote:
>> >> > After START/RESTART, wait for busy bit to be set and
>> >> > after STOP, wait for busy bit to be clear.
>> >> >
>> >> > Signed-off-by: Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> >> >
>> >> > diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/=
i2c-imx.c
>> >> > index 4afba3e..156cc95 100644
>> >> > --- a/drivers/i2c/busses/i2c-imx.c
>> >> > +++ b/drivers/i2c/busses/i2c-imx.c
>> >> > @@ -125,14 +125,19 @@ struct imx_i2c_struct {
>> >> > =A0/** Functions for IMX I2C adapter driver *******************=
********************
>> >> > =A0************************************************************=
*******************/
>> >> >
>> >> > -static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx)
>> >> > +static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, in=
t for_busy)
>> >> > =A0{
>> >> > =A0 =A0 =A0 =A0unsigned long orig_jiffies =3D jiffies;
>> >> > + =A0 =A0 =A0 unsigned int temp;
>> >> >
>> >> > =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func_=
_);
>> >> >
>> >> > - =A0 =A0 =A0 /* wait for bus not busy */
>> >> > - =A0 =A0 =A0 while (readb(i2c_imx->base + IMX_I2C_I2SR) & I2SR=
_IBB) {
>> >> > + =A0 =A0 =A0 temp =3D readb(i2c_imx->base + IMX_I2C_I2SR);
>> >> > + =A0 =A0 =A0 while (1) {
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (for_busy && (temp & I2SR_IBB)=
)
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!for_busy && !(temp & I2SR_IB=
B))
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (signal_pending(current)) {
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&i2c_imx=
->adapter.dev,
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"<%s> I2C Interrupted\n", __func__);
>> >> > @@ -144,6 +149,7 @@ static int i2c_imx_bus_busy(struct imx_i2c_=
struct *i2c_imx)
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EIO;
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0schedule();
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D readb(i2c_imx->base + IM=
X_I2C_I2SR);
>> >> > =A0 =A0 =A0 =A0}
>> >> >
>> >> > =A0 =A0 =A0 =A0return 0;
>> >> > @@ -179,20 +185,32 @@ static int i2c_imx_acked(struct imx_i2c_s=
truct *i2c_imx)
>> >> > =A0 =A0 =A0 =A0return 0;
>> >> > =A0}
>> >> >
>> >> > -static void i2c_imx_start(struct imx_i2c_struct *i2c_imx)
>> >> > +static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
>> >> > =A0{
>> >> > =A0 =A0 =A0 =A0unsigned int temp =3D 0;
>> >> > + =A0 =A0 =A0 int result;
>> >> >
>> >> > =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func_=
_);
>> >> >
>> >> > =A0 =A0 =A0 =A0/* Enable I2C controller */
>> >> > + =A0 =A0 =A0 writeb(0, i2c_imx->base + IMX_I2C_I2SR);
>> >> > =A0 =A0 =A0 =A0writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
>> >> > +
>> >> > + =A0 =A0 =A0 result =3D i2c_imx_bus_busy(i2c_imx, 0);
>> >> > + =A0 =A0 =A0 if (result)
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return result;
>> >> > +
>> >> > =A0 =A0 =A0 =A0/* Start I2C transaction */
>> >> > =A0 =A0 =A0 =A0temp =3D readb(i2c_imx->base + IMX_I2C_I2CR);
>> >> > =A0 =A0 =A0 =A0temp |=3D I2CR_MSTA;
>> >> > =A0 =A0 =A0 =A0writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
>> >> > + =A0 =A0 =A0 result =3D i2c_imx_bus_busy(i2c_imx, 1);
>> >> > + =A0 =A0 =A0 if (result)
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return result;
>> >> > +
>> >> > =A0 =A0 =A0 =A0temp |=3D I2CR_IIEN | I2CR_MTX | I2CR_TXAK;
>> >> > =A0 =A0 =A0 =A0writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
>> >> > + =A0 =A0 =A0 return result;
>> >> > =A0}
>> >> >
>> >> > =A0static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
>> >> > @@ -202,16 +220,16 @@ static void i2c_imx_stop(struct imx_i2c_s=
truct *i2c_imx)
>> >> > =A0 =A0 =A0 =A0/* Stop I2C transaction */
>> >> > =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func_=
_);
>> >> > =A0 =A0 =A0 =A0temp =3D readb(i2c_imx->base + IMX_I2C_I2CR);
>> >> > - =A0 =A0 =A0 temp &=3D ~I2CR_MSTA;
>> >> > + =A0 =A0 =A0 temp &=3D ~(I2CR_MSTA | I2CR_MTX);
>> >> > =A0 =A0 =A0 =A0writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
>> >> > - =A0 =A0 =A0 /* setup chip registers to defaults */
>> >> > - =A0 =A0 =A0 writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
>> >> > - =A0 =A0 =A0 writeb(0, i2c_imx->base + IMX_I2C_I2SR);
>> >> > =A0 =A0 =A0 =A0/*
>> >> > =A0 =A0 =A0 =A0 * This delay caused by an i.MXL hardware bug.
>> >> > =A0 =A0 =A0 =A0 * If no (or too short) delay, no "STOP" bit wil=
l be generated.
>> >> > =A0 =A0 =A0 =A0 */
>> >> > =A0 =A0 =A0 =A0udelay(i2c_imx->disable_delay);
>> >> > +
>> >> > + =A0 =A0 =A0 i2c_imx_bus_busy(i2c_imx, 0);
>> >> > +
>> >> > =A0 =A0 =A0 =A0/* Disable I2C controller */
>> >> > =A0 =A0 =A0 =A0writeb(0, i2c_imx->base + IMX_I2C_I2CR);
>> >> > =A0}
>> >> > @@ -344,7 +362,7 @@ static int i2c_imx_read(struct imx_i2c_stru=
ct *i2c_imx, struct i2c_msg *msgs)
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&i2c_imx=
->adapter.dev,
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"<%s> clear MSTA\n", __func__);
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0temp =3D readb(i=
2c_imx->base + IMX_I2C_I2CR);
>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp &=3D ~I2CR_M=
STA;
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp &=3D ~(I2CR_=
MSTA | I2CR_MTX);
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0writeb(temp, i2c=
_imx->base + IMX_I2C_I2CR);
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else if (i =3D=3D (msgs->len -=
 2)) {
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&i2c_imx=
->adapter.dev,
>> >> > @@ -370,14 +388,11 @@ static int i2c_imx_xfer(struct i2c_adapte=
r *adapter,
>> >> >
>> >> > =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func_=
_);
>> >> >
>> >> > - =A0 =A0 =A0 /* Check if i2c bus is not busy */
>> >> > - =A0 =A0 =A0 result =3D i2c_imx_bus_busy(i2c_imx);
>> >> > + =A0 =A0 =A0 /* Start I2C transfer */
>> >> > + =A0 =A0 =A0 result =3D i2c_imx_start(i2c_imx);
>> >> > =A0 =A0 =A0 =A0if (result)
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail0;
>> >> >
>> >> > - =A0 =A0 =A0 /* Start I2C transfer */
>> >> > - =A0 =A0 =A0 i2c_imx_start(i2c_imx);
>> >> > -
>> >> > =A0 =A0 =A0 =A0/* read/write data */
>> >> > =A0 =A0 =A0 =A0for (i =3D 0; i < num; i++) {
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (i) {
>> >> > @@ -386,6 +401,9 @@ static int i2c_imx_xfer(struct i2c_adapter =
*adapter,
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0temp =3D readb(i=
2c_imx->base + IMX_I2C_I2CR);
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0temp |=3D I2CR_R=
STA;
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0writeb(temp, i2c=
_imx->base + IMX_I2C_I2CR);
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D =A0i2c=
_imx_bus_busy(i2c_imx, 1);
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (result)
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 g=
oto fail0;
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&i2c_imx->adapter.dev,
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"<%s> transfer m=
essage: %d\n", __func__, i);
>> >> > --
>> >> > 1.6.0.4
>> >> >
>> >> >
>> >>
>> >> Hi Sascha,
>> >>
>> >> So I assume you have no comments about this patch ?
>> >
>> > No, I'm still thinking about it. The commit message says *what* yo=
u're
>> > doing, but not *why*. Is it a concrete bug that you fix or is it j=
ust
>> > because it might be a good idea to do so?
>> The driver doesn't work with mx51, which is a fast cpu. So I checked
>> the driver, and find it didn't check IBB.
>
> Ah, so 'make the driver work on i.MX51' is a good statement which sho=
uld
> be part of the commit message.
Well, maybe I can mention it.
But I think the good point is to present what you modified, not the sid=
e effect.
>
>> > Also, we leave i2c_imx_xfer with the controller in a well defined =
state.
>> > So if we leave this function with the controller in non busy state=
, why
>> > do we have to check for non busy again when we enter it again?
>> I2C is a multi-master bus.
>
> So you say with this patch the driver becomes multi master capable? I=
f
> so, it should also be part of the commit message.
Yes. But I don't have multi-master system. So I can't say that.
The code is just taken from Freescale latest code. Without it, It
could also cause a device error. I forget the details.  Anyway, it
doesn't make anything wrong.

Thanks
Richard
>
> Sascha
>
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://w=
ww.pengutronix.de/ =A0|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0=
 =A0 =A0|
> Amtsgericht Hildesheim, HRA 2686 =A0 =A0 =A0 =A0 =A0 | Fax: =A0 +49-5=
121-206917-5555 |
>
