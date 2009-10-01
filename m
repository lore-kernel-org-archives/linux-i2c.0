From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/4] i2c: imx: only imx1 needs disable delay
Date: Thu, 1 Oct 2009 09:57:02 +0200
Message-ID: <20091001075702.GZ27039@pengutronix.de>
References: <1254359613-21210-1-git-send-email-linuxzsc@gmail.com> <1254359613-21210-2-git-send-email-linuxzsc@gmail.com> <20091001072643.GW27039@pengutronix.de> <4e090d470910010052k37a0a4eep6d436e45e6524234@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4e090d470910010052k37a0a4eep6d436e45e6524234-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 01, 2009 at 03:52:15PM +0800, Richard Zhao wrote:
> On Thu, Oct 1, 2009 at 3:26 PM, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>=
 wrote:
> > On Thu, Oct 01, 2009 at 09:13:31AM +0800, Richard Zhao wrote:
> >> check cpu_is_mx1() when set disable_delay.
> >>
> >> Signed-off-by: Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>
> >> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c=
-imx.c
> >> index 156cc95..c1e541c 100644
> >> --- a/drivers/i2c/busses/i2c-imx.c
> >> +++ b/drivers/i2c/busses/i2c-imx.c
> >> @@ -254,14 +254,16 @@ static void __init i2c_imx_set_clk(struct im=
x_i2c_struct *i2c_imx,
> >> =A0 =A0 =A0 /* Write divider value to register */
> >> =A0 =A0 =A0 writeb(i2c_clk_div[i][1], i2c_imx->base + IMX_I2C_IFDR=
);
> >>
> >> - =A0 =A0 /*
> >> - =A0 =A0 =A0* There dummy delay is calculated.
> >> - =A0 =A0 =A0* It should be about one I2C clock period long.
> >> - =A0 =A0 =A0* This delay is used in I2C bus disable function
> >> - =A0 =A0 =A0* to fix chip hardware bug.
> >> - =A0 =A0 =A0*/
> >> - =A0 =A0 i2c_imx->disable_delay =3D (500000U * i2c_clk_div[i][0]
> >> - =A0 =A0 =A0 =A0 =A0 =A0 + (i2c_clk_rate / 2) - 1) / (i2c_clk_rat=
e / 2);
> >> + =A0 =A0 if (cpu_is_mx1()) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 /*
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* There dummy delay is calculated.
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* It should be about one I2C clock pe=
riod long.
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* This delay is used in I2C bus disab=
le function
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* to fix chip hardware bug.
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> >> + =A0 =A0 =A0 =A0 =A0 =A0 i2c_imx->disable_delay =3D (500000U * i2=
c_clk_div[i][0]
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 + (i2c_clk_rate / 2) - 1=
) / (i2c_clk_rate / 2);
> >> + =A0 =A0 }
> >
> > I think you should put the udelay(i2c_imx->disable_delay) in
> > cpu_is_mx1() rather than the calculation.
> >
> > Sascha
> >
> >
> > --
> > Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
> > Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http:/=
/www.pengutronix.de/ =A0|
> > Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917=
-0 =A0 =A0|
> > Amtsgericht Hildesheim, HRA 2686 =A0 =A0 =A0 =A0 =A0 | Fax: =A0 +49=
-5121-206917-5555 |
> >
> Do you think udelay(0) wast any more time than if()?

if (cpu_is_mx1()) is optimized out by the compiler.

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
