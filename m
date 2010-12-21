From: xulei <B33228-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH] I2C: Add support for 64bit system.
Date: Tue, 21 Dec 2010 15:32:01 +0800
Message-ID: <1292916721.1738.85.camel@xulei-desktop>
References: <1292830654-7056-1-git-send-email-B33228@freescale.com>
	 <20101220145954.GA1126@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101220145954.GA1126-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

yes, it has been built and could access the RTC well.

On =E4=B8=80, 2010-12-20 at 14:59 +0000, Ben Dooks wrote:
> On Mon, Dec 20, 2010 at 03:37:34PM +0800, Xulei wrote:
> > Currently I2C_MPC supports 32bit system only, then this
> > modification makes it support 32bit and 64bit system both.
> >=20
> > Signed-off-by: Xulei <B33228-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>=20
> This been build or run tested?
>=20
> > ---
> >  drivers/i2c/busses/Kconfig |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfi=
g
> > index 9c6170c..3392f4b 100644
> > --- a/drivers/i2c/busses/Kconfig
> > +++ b/drivers/i2c/busses/Kconfig
> > @@ -422,7 +422,7 @@ config I2C_IXP2000
> > =20
> >  config I2C_MPC
> >  	tristate "MPC107/824x/85xx/512x/52xx/83xx/86xx"
> > -	depends on PPC32
> > +	depends on PPC32 || PPC64
> >  	help
> >  	  If you say yes to this option, support will be included for the
> >  	  built-in I2C interface on the MPC107, Tsi107, MPC512x, MPC52xx,
> > --=20
> > 1.7.0.4
> >=20
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-i2c=
" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
