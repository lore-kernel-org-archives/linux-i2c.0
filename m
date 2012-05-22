From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH V2 00/11] enable imx6q_sabrelite sgtl5000 audio support
Date: Tue, 22 May 2012 10:56:35 +0100
Message-ID: <20120522095635.GD21999@opensource.wolfsonmicro.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <20120521125930.GC6206@b20223-02.ap.freescale.net>
 <20120521144543.GA4063@opensource.wolfsonmicro.com>
 <20120522013920.GE6206@b20223-02.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120522013920.GE6206-iWYTGMXpHj9ITqJhDdzsOjpauB2SiJktrE5yTffgRl4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 22, 2012 at 09:39:21AM +0800, Richard Zhao wrote:
> On Mon, May 21, 2012 at 03:45:44PM +0100, Mark Brown wrote:

> >  For the first patch it wasn't clear if the
> > changes in pinctrl were the actual dependencies or if there were more
> > things needed from the ARM tree,

> I remembered someone already explained the dependencies. It depends
> on imx pinctrl work and dummy pinctrl enabled in ARM platform code. It
> is why Shawn suggest it goes to ARM SoC.

There was mention of some changes but only a vauge description of them,
I've no idea where they are or anything, initially people had mentioned
an already cross-merged point in Linus' tree but apparently that wasn't
sufficient due to these arch specific bits and I don't know where those
are.

We should really have got this resolved in -next...

> > Guys, you really need to think about how you're organising what you're
> > doing more.  You need to split your work out into focused lines of
> > development rather than just having a single branch. =20

> Except the clean up patch, others are all related to enable audio. Do
> you mean I supposed to split them in advance?

Well, a lot of the time there's no actual dependency (eg, you add a
driver and add registration of that device so there's no need for them
to go in together since both are perfectly fine without the other) then
it is best to merge things separately.  If there are dependencies then
that needs to be handled differently but it needs communication and
ideally the dependencies would be on focused things that can just be
pulled in. =20

In the case of things like the devm_clk_get() cleanup if there's any
complexity at all then it's usually best just to punt for a release.

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPu2LIAAoJEBus8iNuMP3dTqwP/1LFWif8QvtvtZ9xTi7TKEDK
0Vx/QYnF6UaX8sGgoR25IAyJDJwsbesKaZdYRG7VBW7HDLdCu0AwPE3IQpyBCi7s
PsNr9OlecUu2UjpUP6AU+JI+f0/IMK0SE7IY0lp+soBd95MB1rp53XXQILUKqvq7
bPjDsR+o2+S355rbQUkHBwPTHvh6Sj3VhvMLTZZU262QozZiM3/J6CkzdWzgBKg0
8f9XkX87+7G7nA0r3VOyF+cm1cKuq2KGwvf97BhlUIup0v4ToYvl0ej7Cw9XaI0i
kszLiKGjYIYYz+pEk2WI3gJX7Ys+uUbHtEVgzfE8gYLqbA9eygF3Zo1yvGf6kJ1s
rp59zDdYcOSBK96NpAq0Lm7IZcaonorSKA7WJr/OeD0r1D+gewvMozg8Hu7KZfaj
/skzup73mdQWE3odttC8dbjKqI+Gr8qsgXtOhnmVz65z2rzidKfUc2RTK4oy/XUs
l+wdF3lk2cA5CSTJFXbxK0erpPOBwJlslEd0vxsgSP9RKLOBmAekukOGduzs7jQQ
XZXX0MXVE0oPbdSg44Z/JBol3rs60H/v1ivzWkQACXqdozWCt06NRWtbkx2D4QGB
ovBwqISudkCOhBX5TzRpG7UYzwa/AxrbBUNUXRJHdApLtuBHAk8QQIvglq4aH9Od
k6jcCdGtsUm0aAzoRG8l
=h82z
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--
