From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 3/3] i2c: i2c-qcom-geni: Simplify irq handler
Date: Thu, 11 Oct 2018 23:11:26 +0200
Message-ID: <20181011211126.r7sxqvrxce22wdk5@katana>
References: <20180924235235.182649-1-swboyd@chromium.org>
 <20180924235235.182649-3-swboyd@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gw4hxvqsow7do7fv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180924235235.182649-3-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, Sagar Dharia <sdharia@codeaurora.org>, Girish Mahadevan <girishm@codeaurora.org>, Doug Anderson <dianders@chromium.org>
List-Id: linux-i2c@vger.kernel.org


--gw4hxvqsow7do7fv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 04:52:35PM -0700, Stephen Boyd wrote:
> We don't need to use goto here, we can just collapse the if statement
> and goto chain into multiple branches and then combine some duplicate
> completion calls into one big if statement. Let's do it to clean up code
> some more.
>=20
> Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> Cc: Sagar Dharia <sdharia@codeaurora.org>
> Cc: Girish Mahadevan <girishm@codeaurora.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Applied to for-next, thanks!


--gw4hxvqsow7do7fv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu/vH4ACgkQFA3kzBSg
KbYdcg/9EmvZmbD3Pll1WJOOnuCOWr1DMUsz3YGx6HbchQySbJvNtY7+CB8U3xHT
RzLhjeMpSty7FfCM1WxV2TeKQMJNytYIuQfq/mGQVbJvcCQ1T7VCuAfYGyQutUIL
Y5ZhJGbNEMZ0pzv7f/qEG656wyyOtTRB+/UrzQtwKG2U+YLFm0l3r76Se2uUqPmg
h/+brH4Wlr7hYmAwwHBeVQt+gjFdGxS3zCjSPeyPmgD0Ab577dMh/pLN+3LjU4XS
dNnXvoG158udEzF+ELtq32mTmdVuo08KcvTeF9oY5uSVlhS0nAQSlGtF4vSRr9jg
vlKI451sUtIR0VDMrbD+A1Dqd5hR2GBR5tn7W6gqqSvZ7B50EhcMw7qDf/27KpmW
ZUNI2N9PhMMPSRphcu2ert45bxruPiA1q7+4IyUovqZbj33Xul94BjEJW0j0ZYnB
gjaO167U5P0lkrGUBE4t/tHHOUSVqt1G99Y+gd3FRg+jh9iqU0bfjF+WzBT0lUTS
bh2tb6EoJjYDmmXIl0zR0SZnBpoGHBrRHq3/pgIhZPBvksNkV5ODTwO7XO5ulWkt
9b+hV/HQ2x1m0TbN/c1RO0LiT3ZJxb8tNucMWsVizznDb5YaKecKsQ7Yax9p7NAa
dreRUpu07L9xlCeY8oduVhRdWDpvscNMzJ4IDbeg6wkGbkGkAb4=
=rDgc
-----END PGP SIGNATURE-----

--gw4hxvqsow7do7fv--
