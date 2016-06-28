From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/3] Documentation: dt: i2c: use correct
 STMicroelectronics vendor prefix
Date: Tue, 28 Jun 2016 23:37:48 +0200
Message-ID: <20160628213747.GC1598@katana>
References: <20160626093406.26785-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160626093406.26785-1-stefan-XLVq0VzYD2Y@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 26, 2016 at 02:34:04AM -0700, Stefan Agner wrote:
> The documentation currently uses the non-standard vendor prefix stm
> and st-micro for STMicroelectronics. The drivers do not specify the
> vendor prefixes since the I2C Core strips them away from the DT

Note that people are working on changing that behaviour. Shouldn't
affect this patch, though.

> provided compatible string. Therefor, changing documentation and
> existing device trees does not have any impact on device detection.
>=20
> Signed-off-by: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>

Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

I am fine with Rob taking this.


--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXcu4rAAoJEBQN5MwUoCm25hwP/3Neb1khwkDPrTEtRKif++sX
EKKboQAoOaHbZRG76rE5ZpT4SsbBqlO2uMCsLAIhP6wZ3maaaxjtCvIXy8LZBgMH
hGd84jWDSUpMEwfU5yUNbvIvFLO56VbFUor3SvkdW0sWR7ypohQoYveGJng/yyrm
oN8fgtLOSsrcwqC5SHUiMrtQB6sdKmjNzjk+76u1iItNN0NKvHk6+fWEiMped8Uz
M1H3vT3i9Qpltp1pRQDgFJGCnmVcMWaFjHK2omPmL114AQz6fzlq1ONn5DtpyZqv
FdhjMQt0YpUY5UXbJakICptKNBdnhsmSvx2j2ulcbll4Yr3Pv7MrLp0LDeJFrZc9
bLx2b7xpQ9AMWtJ/xzqCegCYrbw+R/RA6CjqrfDEUCQ3uUVLFPyD97AWbQRUC8E+
19Y9yV2U2tI4EPNUJj2iRb+akTWly6XSqqFpoJjTbv96G3q+vOFVXiyQFFxIe9MF
eUHIGgVy7IupliFEL+ixcJ7fDRCuSVlcdVisF6Dq2+ZA1llITI+ipfSKxNvdpVvg
aQqtY15fUmi0Ik/KaWaS3j3wcuJs/IXtZiMKlfrFt3b+daNwJ6jxoSj6nDAf3/t+
ji8GA3SaY/dfhKl5drMt84n1i7qUk0cLibsRqD+tQawOwEG6rBsnSkajPL14W9EM
AZck0wbS+M37N5Ztv2vr
=vpYY
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
