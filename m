From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: imx: double check IIF in case interrupt lost
Date: Thu, 14 Aug 2014 21:27:02 +0200
Message-ID: <20140814192702.GC5134@pengutronix.de>
References: <1408004954-29418-1-git-send-email-b38611@freescale.com>
 <20140814094204.GW5134@pengutronix.de>
 <96d6e524bc524305904730df24bf878f@BLUPR03MB373.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <96d6e524bc524305904730df24bf878f-GeMU99GfrrsHjcGqcGfFzOO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

On Thu, Aug 14, 2014 at 10:09:42AM +0000, fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org wro=
te:
> From: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> Sent: Thurs=
day, August 14, 2014 5:42 PM
> >On Thu, Aug 14, 2014 at 04:29:14PM +0800, Fugang Duan wrote:
> >> diff --git a/drivers/i2c/busses/i2c-imx.c
> >> b/drivers/i2c/busses/i2c-imx.c index aa8bc14..4b63771 100644
> >> --- a/drivers/i2c/busses/i2c-imx.c
> >> +++ b/drivers/i2c/busses/i2c-imx.c
> >> @@ -285,11 +285,17 @@ static int i2c_imx_bus_busy(struct
> >> imx_i2c_struct *i2c_imx, int for_busy)
> >>
> >>  static int i2c_imx_trx_complete(struct imx_i2c_struct *i2c_imx)  =
{
> >> +	unsigned int temp;
> >> +
> >>  	wait_event_timeout(i2c_imx->queue, i2c_imx->i2csr & I2SR_IIF, HZ=
 /
> >> 10);
> >>
> >>  	if (unlikely(!(i2c_imx->i2csr & I2SR_IIF))) {
> >> -		dev_dbg(&i2c_imx->adapter.dev, "<%s> Timeout\n", __func__);
> >> -		return -ETIMEDOUT;
> >> +		/* Double check IIF to avoid interrupt lost */
> >> +		temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> >> +		if (!(temp & I2SR_IIF)) {
> >> +			dev_dbg(&i2c_imx->adapter.dev, "<%s> Timeout\n",
> >__func__);
> >> +			return -ETIMEDOUT;
> >> +		}
> >This smells fishy. If possible the fix should be not to loose an int=
errupt.
> >Can you
> >
> >If I2SR_IIF is unset in i2c_imx->i2csr this means that
> >i2c_imx_trx_complete was already run before since the last irq trigg=
ered.
> >But if then imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR) returns the IIF =
flag
> >set why doesn't the irq trigger? That would mean there is a hardware=
 bug,
> >doesn't it? Is there a related Errata? Does it apply to all SoCs usi=
ng
> >this driver? Did you check that the irq handling in the driver isn't=
 racy?
> After we debug, it seems that irq lost in the stress case.
> Because we increase the timeout value to one "HZ" in wait_event_timeo=
ut(), and it=20
> Return "0" means no interrupt. But when we read I2SR, IIF bit is set.
> There have no racy in the driver code, so we judge there have interru=
pt lost.=20
>=20
> After apply the patch, it really solve the issue.
I'm still not convinced. Either there is a hardware problem (then
=46reescale should emit a proper errata for it when it's completely
understood) or there is a software problem and then your fix looks
wrong. Can you do the following please:

Make the code read:

	static int i2c_imx_trx_complete(struct imx_i2c_struct *i2c_imx)
	{
		wait_event_timeout(i2c_imx->queue, i2c_imx->i2csr & I2SR_IIF, HZ / 10=
);

		if (unlikely(!(i2c_imx->i2csr & I2SR_IIF))) {
			unsigned int temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
			if (!(temp & I2SR_IFF)) {
				dev_dbg(&i2c_imx->adapter.dev, "<%s> Timeout\n", __func__);
				return -ETIMEDOUT;
			} else {
				dev_info(&i2c_imx->adapter.dev, "<%s> Disable tracing\n", __func__)=
;
				tracing_off();
			}
		}

		dev_dbg(&i2c_imx->adapter.dev, "<%s> TRX complete\n", __func__);
		i2c_imx->i2csr =3D 0;
		return 0;
	}

Then compile a kernel with CONFIG_FUNCTION_TRACER=3Dy and before repeat=
ing
your tests do:

	cd /sys/kernel/debug/tracing # assuming you have debugfs mounted accor=
dingly
	echo function > current_tracer
	echo 1 > tracing_on

And once the "Disable tracing" message appears extract

	/sys/kernel/debug/tracing/trace

and send it to me.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
