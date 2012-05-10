From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH V2 03/11] ASoC: imx-audmux: add pinctrl support
Date: Thu, 10 May 2012 10:27:34 +0100
Message-ID: <20120510092733.GH3908@opensource.wolfsonmicro.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <1336563190-19974-4-git-send-email-richard.zhao@freescale.com>
 <20120509160005.GG3955@opensource.wolfsonmicro.com>
 <20120510003532.GG2982@b20223-02.ap.freescale.net>
 <20120510063904.GB17875@S2101-09.ap.freescale.net>
 <20120510084403.GA3908@opensource.wolfsonmicro.com>
 <20120510090459.GH2982@b20223-02.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OpLPJvDmhXTZE4Lg"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120510090459.GH2982-iWYTGMXpHj9ITqJhDdzsOjpauB2SiJktrE5yTffgRl4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--OpLPJvDmhXTZE4Lg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 10, 2012 at 05:05:00PM +0800, Richard Zhao wrote:

> devm_pinctrl_get_select_default function is added in below commit which
> is in pinctrl/for-next.

Oh, dear.  That's unfortunate, I guess it's not on a branch in pinctl
which can be pulled separately (this is what I've been doing with things
like regmap and regulator - creating new interfaces on easily mergeable
branches)?  Looking at it from the other perspective, what goes wrong if
we defer this patch?

--OpLPJvDmhXTZE4Lg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPq4n/AAoJEBus8iNuMP3d5M0P/RDj66WQ1bLnOByWH42LHG3c
3b84MWRosN4uHlrjeSpdCOLfEa7FSxS/GNaYPWCa249Y/uB9VNOjWeNWJtzQibYD
ciiN4emmyIKl2lw8VkJgQICT1059o5R3GZKfHvbjAAfUR3LfSOVxvEE6XXilYtcq
XFhjEaPCMzUnMUp5IKeQ123JShjuxxOOGXeyl5AlL22cdGcvjI33qsH0/5zBFqgp
h6fKfMc9e0k7CK0GiRK9ZDOpEz+GNvAhpbyVRu8Sa1QivBu8OMlYEgWkr4F97eqA
lT0k5mlM1M1kzCZgMX5e5V4pZ9HVM6F32M10VcTkQb00hE8X7bLeV4OqlVm3b3GD
7MYSjbvI/D8gfqjUABcnzBRc8FTkaeTgmuHnBDgGPFCdBAxxwS2EhYgLnXP0UZfx
wwaD8QiKnRi9idoNWVfPT1smKzodybqJKbDPXooc2NQiXBjvZFADyhOIWaGEk/us
lQkV4tH5rl9B3e4s+5iePW0YAYVnRmn+fZO8raxsDh1LwG+fw/GqmCiHC3/+Uy1E
JrPAsKJWRT4lruRHvlVeCi22d2oT/u0k/xcnJSX1Npw9k9We4W2c+tp8fouSwZNr
WPVLbGAzvFCfLI57mkvg9+Q0xhlCCdMxVEol2o3wqnd5hCBEb20SW9RZTuAM+MRG
AstBwjvsWSGkgF+kef6k
=PZh4
-----END PGP SIGNATURE-----

--OpLPJvDmhXTZE4Lg--
