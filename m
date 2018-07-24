From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH/RFT 2/6] i2c: imx: use open drain for recovery GPIO
Date: Tue, 24 Jul 2018 15:01:52 +0200
Message-ID: <20180724130152.sisk6dplm74imak7@ninjato>
References: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
 <20180713210920.3648-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="balstfvoi46gcqas"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180713210920.3648-3-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--balstfvoi46gcqas
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 13, 2018 at 11:09:14PM +0200, Wolfram Sang wrote:
> I2C is open drain, so set up the GPIO accordingly.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Updated the commit message with the pinmux info from Lucas and applied
to for-current, thanks!


--balstfvoi46gcqas
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltXI0AACgkQFA3kzBSg
KbZw6RAAswbkKo8Lzz3CF3raJ5PXNAbc3n3ZOMLbKZ2cjxb0Wd10+jijXUsehtoe
yWdNUxc0f91Brsap/Tg6SAK1FVXuYTiQyMk6WLT+1gx7ggkldMjXqryp6JYsvgb+
OTJEd7cRjB48QIsGs7VNJtksd7MWpzuIaYYQQ44KHFf+yk28Uzx5l52ro/5tpHZN
PPs35EyJgodlllV+xe3OJaJdJgO6piqDVMH7cRoue4JmzmrHVvDT/f7OOxIygp8J
eShcSry6Cg4p/3G24ncrkyqcDIH+WhQvpTyYys7IaybGSKU/JfP6ARufojDej1ob
S73BM65q5VltjfGPeI7gkJFBTAodP3Swa9WWHpRDLOBDUAIi/1eTckdaS6c5Kw8U
bBLpsFnaYHJc6C1OQLZUIyoCFIp4BBAghs7/Gm2wtZlxQa2l4LjnXx0W8qMrWQj6
rXuMeSsZTc6zICD153zJg+xCKsGvScrQ+dFFJlqwyWMWH8Gkuv7p8UFaA9E6Opat
Vd4g13XIpudAMlqwTXZAj3/jyjjXqJQGGGlCB53v1EWHOk7XWrFYs60tvQMGKsPX
GEPog5FYsrgtvrwxjc8a1GhnGVtk0vux+1EBpyTrXif35BDi0NkT9YqX4eYX7T3p
YSl63o+jIHpi6swKssr7Dg7eNuPFP8OKZdde0fG3daCeSsvT8hc=
=JNBs
-----END PGP SIGNATURE-----

--balstfvoi46gcqas--
