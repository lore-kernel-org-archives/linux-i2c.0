From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 01/11] dma: imx-sdma: make channel0 operations atomic
Date: Fri, 27 Apr 2012 12:20:30 +0100
Message-ID: <20120427112030.GF18260@opensource.wolfsonmicro.com>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
 <1335510185-7906-2-git-send-email-richard.zhao@freescale.com>
 <1335514900.31825.132.camel@vkoul-udesk3>
 <20120427084109.GO28063@b20223-02.ap.freescale.net>
 <1335522130.31825.135.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yRA+Bmk8aPhU85Qt"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1335522130.31825.135.camel@vkoul-udesk3>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vinod Koul <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--yRA+Bmk8aPhU85Qt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 27, 2012 at 03:52:10PM +0530, Vinod Koul wrote:
> On Fri, 2012-04-27 at 16:41 +0800, Richard Zhao wrote:

> > Then, could you please doc it somewhere? I think I'm not the only one
> > confused.

> See the soc-dmaengine.c for correct behavior!

Better yet, convert your code to use it if it's not doing so already!

--yRA+Bmk8aPhU85Qt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPmoD3AAoJEBus8iNuMP3dTioP/RORjusMnksmYxxAEL3cKq7G
wvpDubEvmYy2xYASQULcqCJCbon2yFAifiO7zWlrHm42x2/wNwKHC8o/XhIkm2CL
F+Eu9af0hH1sQYqkkcoTgKiQSQ6yGX4C3z7C0uq7NQX4ZZE0QmYHYewdhODvdTee
TmxUmL0iyNJBlKzQpqDs54AjMDJwf9F4c+F5vrwAuzYWWOXz16SADd9O9nkCTb71
yEjvQB11HRyuLILLo2Cf4uYPgKhTXAivlAYpA+Py2b+QcaW4fA8KA+pyKHvFpzgm
MNc6Wy8Jbb2/tn5jwyPDo2TvWewJgMKc1waDsvj64RMdDuRJnY4aVDCV8RgQSGzg
weLW4FNDDrEs/lDnHESFV3lPRMQBwAT5bgaooUHVusnCqxeTFCssSm8QcaJpBj+C
BEEs8wAExBWrw0w5MAv5KjOIPFOlUAxDLPKXwiB5aN9rKKGC42Y+lkkbifsgGGDS
zHQPSPQxgGf5xhgR1ZjfZnphVsrB8MrQ6+06vOW9WiyCOHVbgQBHycUHIHXcJRzK
OYEtc/FLVO+IXpbX+X/jRpkKaS43TUCMy/w13q/iVkDGc9asJSL3eCctjdKEXGjE
mHgI89IraFWhy4op9GynuXjWvkEVQp+Vu2dhpPk19fPb2DfdLyEo5tqyQ4Jwn4Ph
az2gg2E2Bxpiv21AdIFf
=/BI7
-----END PGP SIGNATURE-----

--yRA+Bmk8aPhU85Qt--
