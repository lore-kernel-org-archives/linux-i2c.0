From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH V2 00/11] enable imx6q_sabrelite sgtl5000 audio support
Date: Mon, 21 May 2012 15:45:44 +0100
Message-ID: <20120521144543.GA4063@opensource.wolfsonmicro.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <20120521125930.GC6206@b20223-02.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120521125930.GC6206-iWYTGMXpHj9ITqJhDdzsOjpauB2SiJktrE5yTffgRl4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 21, 2012 at 08:59:31PM +0800, Richard Zhao wrote:

> >   ASoC: imx-audmux: add pinctrl support
> >   ASoC: fsl_ssi: convert to use devm_clk_get

> Linus has sent out pull request for pinctrl. So is that ok for you
> to pick up the above two patch?

No, apart from anything else the second patch depends on clkdev which is
nothing to do with pinctrl!  For the first patch it wasn't clear if the
changes in pinctrl were the actual dependencies or if there were more
things needed from the ARM tree, and in any case until those patches are
actually in the ASoC tree we'll break the build if they get applied.

Guys, you really need to think about how you're organising what you're
doing more.  You need to split your work out into focused lines of
development rather than just having a single branch. =20

This patch series contains a whole bunch of different changes (the
devm_clk_get() change is as far as I can tell completely unrelated to
the rest for example) with unclear dependencies on multiple external
trees.  You should be splitting unrelated changes out, trying to
minimise interdependencies, and clearly identifying the dependencies
that are there we can get things applied in a timely fashion.

Please resend these patches *after* their dependencies are in mainline.

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPulUMAAoJEBus8iNuMP3dsRIQAJOjCbTwC8gkha4rRxBKkT1o
4Xq1ea/Y/UU7QyVezyj+fF+KzMzNiJFRVhqhY5v6fNADq0Koq7nKGAAse0XbLzhk
L4C5QumRe/hgn1FmELYMcAmzsckFo/ySc5XKuxsQamXn3d8fTFMwQb2LaPHU/BtQ
/jsHcsuYYLi3OeARqSZvYQSlvJO9Y+dqbfTK4d8dnzdwI8Et92/Qac4m+r4u0ddL
Hqj4LNtfvD8niyBEq4tMcSiPcnSa9J7Ou2o++zBM46AJDfAxCKRxsulOFi8S84Xu
0H1LyoSoXSxpLK4q+8AF72MIXJJa01WGvxqH6la4lqT8ByH+trcTcdHWY5LPEVpK
GkAY7OFN/KAD54BW/HitJLBLmoysksyJZcYgkQJ118FQF83SZevm20ixH33EWf4Z
8U6//W7yU/5TCgQgCaUIBx97L7NVZFEh4uFDNYA3M0YByzJYyee4LuNVH2hse1iV
uaNddgZEQhHH2BwS6vDVIe7dD5qA5aR0NpzYzoDGqATK64f3o/h7/JFH/vyKz2Zy
Oh3e0/YkGpCu84u8L3eT6xh6jEuINU1nzZZpMz1iMq4y5Qe3/MR7+2ZKctcVIz9J
R0B0dJlcxFPo6FCLx6U3BCO/m0Is70Oh9Rc6cPMTel9Y1Ll7YTR/R4MpGZ187VXp
6o/AG+OCHa9XscBTdA4b
=n+BS
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
