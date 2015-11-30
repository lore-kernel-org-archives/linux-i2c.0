From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v5 5/5] iio: humidity: si7020: add No Hold read mode
Date: Mon, 30 Nov 2015 18:33:24 +0100
Message-ID: <20151130173324.GG9554@katana>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1446118467-26453-1-git-send-email-nicola@corna.info>
 <1446118467-26453-5-git-send-email-nicola@corna.info>
 <56349644.2060308@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f5QefDQHtn8hx44O"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56349644.2060308-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Nicola Corna <nicola-V0pQiMyom5mh6J55Ss3d3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--f5QefDQHtn8hx44O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2015 at 10:21:56AM +0000, Jonathan Cameron wrote:
> On 29/10/15 11:34, Nicola Corna wrote:
> > The Si7013/20/21 modules support 2 read modes:
> >  * Hold mode (blocking), where the device stretches the clock until the=
 end
> > of the measurement
> >  * No Hold mode (non-blocking), where the device replies NACK for every=
 I2C
> > call during the measurement
> > Here the No Hold mode is implemented, selectable with the blocking_io
> > variable within si7020_platform_data. The default mode is Hold, unless =
the
> > adapter does not support clock stretching, in which case the No Hold mo=
de
> > is used.
> >=20
> > Signed-off-by: Nicola Corna <nicola-V0pQiMyom5mh6J55Ss3d3w@public.gmane.org>
> I'm fine with this.  The dependency below should I think show up in the
> coming merge window, so this lot might as well go via Wolfram.
>=20
> Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Not sure, will think about it...


--f5QefDQHtn8hx44O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXIhkAAoJEBQN5MwUoCm2b3gP/A9z8+qAvT5LFoWQCeeHd5/S
m+v5NNmT/7GiqkP8RwvdC01NEzJRzv4D+ovCHFI6olU4pPzsPTYIKEUppOALF1Gh
8tRi+a0fJ0GaFxab5kMbWnd5Vl1ycsuvRxFYxgZukKaUvtnLsl3dEDDXkgiJDTGJ
RCZwyFxWsT3KpatEFmT6u+++HYkN9QdqKl1N0cPLlaBqWZpUqTaC5w8waIXsJrC1
SsJf9m+4AC6mysUv/3N5k1GCPRIAF3BImfr3DBnM+3kRwjeF0a2sPOwvoxHB9fgi
4JuLMxSazSafo1KCrVtIVVS3gkO+Lo5diIegDoNO4gbsZpQ8xyECdHENSzY7fbjm
cxWyoN6f03HbUI2sQfKwaI/Styk5kXYRSXDj+E1Cb877NFo4nIuRHjEo8/Suhb7x
xT/Ar4P5KR5FWsyXrZLgsj+ZZB8Smmz/gRyNa1xW0zQ0ESrO6iWQgcQPv51dV+2j
1AW8SeCJjq5WaMcn5Fy1KIwydHQ1E8HhKAs9vQ79BrAV36ovangrAL5n3nFf3YOa
xJKxY7nLzLeP4Vrd25uUeKkJZrikN93eooc37+8csD/O08pUm0WTCUD+Xmbehxcb
AeD0eS3zzv0ih9J9xEnAGCtU70kdX3IJFLGCsAq06H2flzb3jg4QgvyFgKAd7p2m
1gwIooh1nlVYgfm+P+fn
=COCH
-----END PGP SIGNATURE-----

--f5QefDQHtn8hx44O--
