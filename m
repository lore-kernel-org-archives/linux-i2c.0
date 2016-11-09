From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 00/14] ARM: dts: r8a779x: use demuxer for I2C
Date: Wed, 9 Nov 2016 09:59:54 +0100
Message-ID: <20161109085954.GA1807@katana>
References: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
 <20161109084406.GA22213@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161109084406.GA22213@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Simon,

> I have tested these patches on alt, gose, lager and koelsch.

Wow, that was quick. Thank you!

> The switching part seems to work fine, in so far as my test script
> succeeds. However, it seems that some IP blocks are not able to handle
> this switching. In particular I needed to disable VIDEO_RCAR_VIN and=20
> REGULATOR_DA9210 to avoid errors shown in the logs below.

Yes. Probably we should activate the shiny new DEBUG_TEST_DRIVER_REMOVE
and if that passes, we should be safe.

> My suggestion is to drop the following patches until those problems
> can be sorted out, most likely via driver updates.
>=20
> ARM: dts: alt: use demuxer for I2C1
> ARM: dts: gose: use demuxer for I2C2
> ARM: dts: lager: use demuxer for IIC2/I2C2
> ARM: dts: lager: use demuxer for IIC3/I2C3
> ARM: dts: koelsch: use demuxer for I2C2

OK. I'll try to have a look at those drivers nonetheless, because
rebasing these patches is a bit of a hazzle once new i2c slaves were
added to the busses. But I'll juest resend the patches along with my
fixes if I really can find the time.

> I am not in a position to test silk or porter at this time.
> But by the same reasoning above I wonder if the following should
> be dropped for now.
>=20
> ARM: dts: gose: use demuxer for I2C2

I assume you mean 'porter' here.

> ARM: dts: silk: use demuxer for I2C1

Will you get access to these boards in the foreseeable future?

Thanks,

   Wolfram


--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYIuWJAAoJEBQN5MwUoCm2oRkQAKpVieJZoZU6XaNuQCLNcZMv
uXuwar79xNgbQGFbnhHeCcSOFMozy0VORdX1XAJrFydsMiBm38NsAWcQjdlwbz/w
5HkGfe+9hqd0+ftTqUxQoa8DJvwXZjRi3/6dauHCY+r9DikpkHEddAjObJtUv/Ek
ha7gUcFO/8qWpVcZ13x/DF60G1pdjXb/ZJvrqj2DDygte9Am6a3nZqhFyVZRIqBv
KBUZFrQJVJQSQaOaAcLRqjJ9/lxk34eRJPVtD0qP/FFdqmUl+z8MDzYuOUHPir/4
2jrVqxs5V1Acr95sKXhkbbaaygBids+C2+0Fs3eSOx0HVc6bMs0+Udwb32hPu/iD
WNXU2v0fq0g8HQoknKVhIItouSX47F4HraqK4PyZhSZMVN3xOlHRuj3Wdb15vwb3
u9MxRTJLW+xdC1ECesLAo8BBwZA4F6uMNd802S93gtXc7PFGyVcYRaQR4k+Jp2m0
D3qp24knmK6X+lHnKWL64xnT8b9E/tmgCXyOZs1bEZyZ1tggYWz2Bg7O3S8+X7fE
TxFo+xGxDmgzzEYh+AzHL89WKf9SgV2CLQ0/vQ6Ha74eM/KaF4nWzDQqbZ7FfWGq
yHZcEgFlGHW9Szy1Rrg7niy9TMxCP23p9WZ5NG5+BD8pNFrdTxg5XBQi10UZrZyT
0uSHEloGtkjIPlY+QkDh
=WRP5
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
