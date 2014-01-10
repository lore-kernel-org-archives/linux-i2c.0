From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/5] i2c: mv64xxx: Add reset deassert call
Date: Fri, 10 Jan 2014 18:24:02 +0100
Message-ID: <20140110172402.GR2941@lukather>
References: <1389288003-23187-1-git-send-email-maxime.ripard@free-electrons.com>
 <1389288003-23187-2-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v6663ARKwmJ4Ypzi=m-J7UMvUFRq1=qLbqgQ0vrN_gC18w@mail.gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RpDyejMaDGJhP2PU"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRB4OZYCLAKGQE44NYBDY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v6663ARKwmJ4Ypzi=m-J7UMvUFRq1=qLbqgQ0vrN_gC18w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, duanmintao-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--RpDyejMaDGJhP2PU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 10, 2014 at 01:48:41PM +0800, Chen-Yu Tsai wrote:
> On Fri, Jan 10, 2014 at 1:19 AM, Maxime Ripard
> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> > The Allwinner A31 SoC using that IP has a reset controller maintaining
> > it reset unless told otherwise.
> >
> > Add some optional reset support to the driver.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 1 +
> >  drivers/i2c/busses/Kconfig                            | 1 +
> >  drivers/i2c/busses/i2c-mv64xxx.c                      | 6 ++++++
> >  3 files changed, 8 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Do=
cumentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> > index 82e8f6f..603003a 100644
> > --- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> > @@ -12,6 +12,7 @@ Optional properties :
> >
> >   - clock-frequency : Desired I2C bus clock frequency in Hz. If not set=
 the
> >  default frequency is 100kHz
> > + - resets          : phandle to the parent reset controller
> >
> >  Examples:
> >
> > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> > index 3b26129..69aa599 100644
> > --- a/drivers/i2c/busses/Kconfig
> > +++ b/drivers/i2c/busses/Kconfig
> > @@ -528,6 +528,7 @@ config I2C_MPC
> >  config I2C_MV64XXX
> >         tristate "Marvell mv64xxx I2C Controller"
> >         depends on (MV64X60 || PLAT_ORION || ARCH_SUNXI)
> > +       select RESET_CONTROLLER
> >         help
> >           If you say yes to this option, support will be included for t=
he
> >           built-in I2C interface on the Marvell 64xxx line of host brid=
ges.
> > diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-=
mv64xxx.c
> > index 8be7e42..d4e2f32 100644
> > --- a/drivers/i2c/busses/i2c-mv64xxx.c
> > +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/mv643xx_i2c.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/reset.h>
> >  #include <linux/io.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> > @@ -743,6 +744,7 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
> >  #else
> >         const struct of_device_id *device;
> >         struct device_node *np =3D dev->of_node;
> > +       struct reset_control *rstc;
> >         u32 bus_freq, tclk;
> >         int rc =3D 0;
> >
> > @@ -763,6 +765,10 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_dat=
a,
> >         }
> >         drv_data->irq =3D irq_of_parse_and_map(np, 0);
> >
> > +       rstc =3D devm_reset_control_get(dev, NULL);
> > +       if (!IS_ERR(rstc))
> > +               reset_control_deassert(rstc);
> > +
>=20
> Do we need to handle -EPROBE_DEFER here?

Hmmm, true.

> Also no reset_control_assert() in the exit path?
> I'm asking because I have similar code in my stmmac patches.

That might be a good idea indeed.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--RpDyejMaDGJhP2PU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJS0CyyAAoJEBx+YmzsjxAgCEYQAKmWYkLiBoLqoJQQoIkUaAi7
u7cWTWq2kO0/U1hQL4RcK19u0P5cAvAuTMa51DCO9xyxc++/nKL3VCZ6Mrr505hk
II6UoE6f99yy2mc8IhLu8LQ+i0YKx+P2Z5IYHQt684p2T6GBAP7YUwLhRN4mzYOj
S8Gg1qRTe/58cJJNGmHxY1dnPHKurlNRB3LYUWuXi7XdoZLgIPdU430T3NPIsnlg
/69E3aigdRKYP77kNbioFXW1WXLa/Af62T24UNgFKIicyAu5SXUOBi20rdPYQ8bG
/ayF3VqNbNq8Y3KjiUtUKX+TOIny22WEdzt/SGdttaeqO1Tgt8755kEjQegHqtw9
N2NV5DbP+Uo0kwscrTcytsel+e/cvo1182R4WJMeOas5EHqYPzwqFdSjqiXVVR7N
3AeWCDi/xfxTDU72qpYass2bqtPCsf1j1oMg+jFeKSBrg/9D3oh2xuDf6GsQI2hn
eKvpGgMdwK7niYpcWKVTgM10613E0U3VvglLSYYMmxSBDzg3uYs0FrchBoCPDAG5
9XaT2fo6QG4z1El2+fLyp3RBKehcQ3+2DFVbr/YeBN5lpKt+Qq5z846PNE+R5GcZ
enpavOf8Z/YkvgWVn9iGmZCAP1UVgyE+RMRdPMFghQXm+3EFK5Ky4i2NGydeLrZV
MzCiFczyF5wUIGeuSpjQ
=KM9L
-----END PGP SIGNATURE-----

--RpDyejMaDGJhP2PU--
