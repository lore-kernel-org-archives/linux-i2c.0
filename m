From: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Subject: Re: [PATCH v2] i2c: i2c-bcm2708: fixes cdiv uneven number
Date: Tue, 12 May 2015 17:54:56 +0200
Message-ID: <20150512155456.GB4448@schokonusskuchen.bad>
References: <1430516629-32692-1-git-send-email-linux_wi@tinag.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1430516629-32692-1-git-send-email-linux_wi-ADq4ffItWIY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2015 at 11:43:49PM +0200, Silvan Wicki wrote:
> Prevents that cdiv can be an uneven number as per datasheet cdiv is
> always rounded down to an even number.
>=20
> Datasheet at page 34 on
> http://www.raspberrypi.org/wp-content/uploads/2012/02/BCM2835-ARM-Periphe=
rals.pdf
>=20
> Signed-off-by: Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-bcm2708.c | 13 +++++++++++--

Which kernel are you using? We don't have such a driver in upstream.


--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJVUiJQAAoJEBQN5MwUoCm2hMIQAKV1Ad4pkaZ4/I3egJxNBHJT
7YlhMs/7/E2rU8cN+JJp2FUxhwFCz1PItgOYr8aqafPvQDTEPkJYYl4CEDvR0nZe
XD8CGm+aVJxDa6yNWEqeHAwqVR1x0o7yro4Dbq74i+7uGal2fokNxN6Bic1TJfX6
d8IUPQojwuxL2zhZYh4MXuxBrBOnHhIlOUzofAj5jch+zCh1PooEu088CXQkj9pL
ssihhrn3RNRNyjqmE7sDoWPsfA7eyH4+3LD/4yrG8GoWtkqe4hfHejibUhmt9Y5r
RwwkFPlcgWwBzH3rWXs3apedaKkUwb7PUqSHpzek54JflqwW9cbbfH/rOLAmijkO
oTsviO4uMpp4MEcFuCR+qZjO+AQaK8mTxftc6O+Bbb7DxP0WeWfG6ETTx32NE3se
5p8uUsDn9u4xe4mEhUQwtDZLL8DUn+NRse3JzKIrbR6viCfeXFMSqQk1WEGC3AG/
xntWnDYw358obEajkCCEUmFOrjs4nK+438C8YJugBTvCRuQaPd8ZtZAn1NeO+f8v
AkUsQw9Snh1KPD0v+88WVTQNaRAjfJLB/Cg1wMezfAJTZ4T02oX0x9xCenJ97DLG
GNnXEVCNI3C8JbidVByJ/15eUVumT+68a07C94QJFPtEQsDw/9wDKOrK3MaIDoHK
TlhYJl2qKovmt3LveR/t
=7EWo
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
