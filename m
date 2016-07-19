From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] staging: iio: light: isl29018/28: remove I2C_CLASS_HWMON
 .class setting
Date: Tue, 19 Jul 2016 09:13:51 +0200
Message-ID: <20160719071343.GA2086@tetsubishi>
References: <20160716022831.GA7636@d830.WORKGROUP>
 <578C9843.10408@nvidia.com>
 <dff1e871-de49-654f-5e9b-c9b230a35b0a@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <dff1e871-de49-654f-5e9b-c9b230a35b0a-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Alison Schofield <amsfield22-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 18, 2016 at 02:30:46PM +0100, Jonathan Cameron wrote:
> On 18/07/16 09:50, Laxman Dewangan wrote:
> >=20
> > On Saturday 16 July 2016 07:58 AM, Alison Schofield wrote:
> >> I2C_CLASS_HWMON is for a hardware monitoring chip wanting
> >> auto-detection.  IIO drivers don't typically use .class.
> >> Remove it.
> >>
> >> Signed-off-by: Alison Schofield <amsfield22-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> Cc: Daniel Baluta <daniel.baluta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>
> >=20
> > Agree.
> > Acked-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Any resulting ABI change from dropping it?

What do you mean with ABI? This is only relevant for "automatic"
instantiation. From me:

Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>


--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXjdMuAAoJEBQN5MwUoCm2TGsQALDVdnG4ebAv1h4u01UDFIrP
XOX7DMa3vznfDCi+FDQ7kBGI0kt2q/rwNKkVe468mtyFQHfzfVeHsgaEQ1XCoIkZ
e8U7nOhxLwgkSPy81jy0gij//gik5cw7AyMa3rNMxtNoWf0m+26Fk11L7WgcGbYP
s4qrZLRVdR/6VEXAI3vu7PBFXVI+Lf7dyA3gOMjUpo2lTv6caeUORhiTUjGbS/1g
moe01F0YXPaU+OMoiPHQ6t7y/AWpngGWn2aHWhERDjoMoe59GriMp9ExDIP5cJeo
jybS55IPmZwmciDfvJ105yFRtgN6xaAsuX50MbwCae9jFSZfwLYcUk6iKmulhZtm
ouG7vp3tnkn4P2GZNpTX0ZtaFSLc6OfLarANhyUmR/oInyZh0EOxZ2lgMfYkWnvK
XAsE0Gs17h2c9cws9yZJppzlWtdsoxP7wlEndmYdC5li90RiWHfeaZGQ2jaX7rCb
96pK7y1CTP7A6CIxs+LuIb0rcUredk+Q8ypswnn1HTyb1wj/YvUkih0sBPuS/XCC
WLu/Hc1ZQG0/PXj2gbwM4bfGwDbpQwpoaiIhwhGDwNoza7mV+1mj5SaTGUzNo4NS
2E1P2nxUOHFJpFp6u08wv4PDvDpD6orljpPXTTb/BVBn2OlTGS7BuY5gfOCpLzuY
2RySVuv5usvfTO80Jkm6
=WEHl
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
