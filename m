From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: davinci: raw read and write endian fix
Date: Tue, 26 Nov 2013 13:39:34 +0100
Message-ID: <20131126123934.GB7427@katana>
References: <1384971824-7707-1-git-send-email-taras.kondratiuk@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1384971824-7707-1-git-send-email-taras.kondratiuk-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Taras Kondratiuk <taras.kondratiuk-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-networking-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2013 at 08:23:44PM +0200, Taras Kondratiuk wrote:
> I2C IP block expect LE data, but CPU may operate in BE mode.
> Need to use endian neutral functions to read/write h/w registers.
> I.e instead of __raw_read[lw] and __raw_write[lw] functions code
> need to use read[lw]_relaxed and write[lw]_relaxed functions.
> If the first simply reads/writes register, the second will byteswap
> it if host operates in BE mode.
>=20
> Changes are trivial sed like replacement of __raw_xxx functions
> with xxx_relaxed variant.
>=20
> Signed-off-by: Taras Kondratiuk <taras.kondratiuk-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Applied to for-current, thanks!


--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSlJaGAAoJEBQN5MwUoCm2RkQP/ivFJqKxoUQg6fHiZQ7/Gx8j
qhe4XrmwSAhK6IrfztgRTDyrzB5kNa11Uj0mcX63dSnRUllOPsnGnn6XMNbQzu/a
QZqztrlB9QF5PEgddLn48I04ARm5xKlMp9iS9RM8+sh/qpcWc5aNGmoQdGtPfRgB
vqF72XFvNjrlpO7omo3oT5Lvcc6dpNP//RWeYB6t68GvNxzbaXLMtCVV4YOLGU6z
0K6TKkpQVZ4h8VURHObnqV3CygP4XfU36/9OInQAjtWS/KwPCvFoDEnyP4kWWXIz
ElDvFiBoVY9WK+tFty00+1vBRvSdn8sVhy+uIafaLsBkAc/KQa6ooewLmM/I/mLq
S3RcLL773AKrxMttCVvORwheUiScLmSHRBJcfPJjW0gIk3Pk/Lnlq6S/VwnUjs+C
Ov30LMjnWs6UpGtUVt9whmlwoOy0E3lnpp/5k+fnOd3A7lzvBYavtWINPTGqHnWX
Te37PVTHf41Ihk7cEIkpAir7K1oHoN/037jxxFdKMQbL/u1F1M6Dg9wRiXH8HHm9
QS/wsPPnTtZqjwTO3YWfHWH2NMAEaXoTBagxwhIFf4xcMg2mrVEt1cDWGDgb6p0s
Vse74Y/oH3w5AIYiwaiXnnkEzvC3ckWMCeHuMVJsHKcs5m1nSUtlcEjbfJt1KejB
Hw6gXSqTCtPJ5YDDSqSb
=kyNw
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
