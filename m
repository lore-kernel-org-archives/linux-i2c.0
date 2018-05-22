From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/4] i2c: xlp9xx: Make sure the transfer size is not more
 than I2C_SMBUS_BLOCK_SIZE
Date: Tue, 22 May 2018 14:08:41 +0200
Message-ID: <20180522120841.xtyw7g7s6rgcncbk@ninjato>
References: <1526454019-32714-1-git-send-email-george.cherian@cavium.com>
 <1526454019-32714-4-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uddql2xo6t67nggg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1526454019-32714-4-git-send-email-george.cherian@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: George Cherian <george.cherian@cavium.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, jglauber@cavium.com, kamlakant.patel@cavium.com, mchehab+samsung@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org, akpm@linux-foundation.org, linus.walleij@linaro.org, rdunlap@infradead.org, Jayachandran C <jnair@caviumnetworks.com>
List-Id: linux-i2c@vger.kernel.org


--uddql2xo6t67nggg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 16, 2018 at 12:00:18AM -0700, George Cherian wrote:
> For SMBus transactions the max permissible transfer size is
> I2C_SMBUS_BLOCK_SIZE. It is possible that some clients might
> not follow it strictly occasionally.
> This would lead to stack corruption if the driver copies more than
> I2C_SMBUS_BLOCK_SIZE bytes. Add a check to avoid such conditions.
>=20
> Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
> Signed-off-by: George Cherian <george.cherian@cavium.com>

Applied to for-next, thanks!


--uddql2xo6t67nggg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsECEkACgkQFA3kzBSg
KbYq9A/7B4HTTO6hBkJ6oXeL7VadcJD24v2z0ldMhOnkxA7gXigqPawheb1bwa6q
xmfj8faoeRkn2EdQcAMIiS5AgbZTle2ZZdu3JCnze2ntfGUQye6dJ88rd7jc2tM5
HLWk7vqwZeYGQcoVVRsg0MPORkbueVnAPjKGuclRtJ4ZrwMacO7/hKPhhZIH9ETY
RArWcYYH2iInxdocH+FRqBPresKnF0Gf6V5L7xmbIxq+RKNAjX7M27Q+SC0wO5yN
AJZYDDsJEdJsculSymCg3CQL7KHoeUry21xdtzQMw2egMfOsFoKjDZIV143AY3PH
S0jpQIjlT8xsTGo5M1rkUR2D1P0WpRl0C9sO+LOYWcaCP08QR6LCuUUAWCPqO92r
UXk4lQ0EY8uhaiucVFXWfTzVy63+z+tEYkf3grAKtta83TT/51ndWSU0z440Zyt1
RxJf6LtW/sgQcFXgXmx8db1g5nlZ92aGOrh2UuGkIjMLBqO9a0FM6/yoPTmHjmnv
WC7DIvHm1iYpBpyLALJPmPR8dqLXUpE8vSh6SLC7jUzi+L/wjtP9wKwfIpdm+T/W
/KlXW9dXf2WFcG1TO6Wq1ZBDReN+OdyD/mCu4ZZcIFV/fjM30VD0JlFau90kDLaQ
kzRqwer2+9i90SuQQ64cWtkonLNPxfVXXbjRPptQRG7XyEsB/68=
=0rM2
-----END PGP SIGNATURE-----

--uddql2xo6t67nggg--
