From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v8 1/2] i2c: i2c-qcom-geni: Add bus driver for the
 Qualcomm GENI I2C controller
Date: Tue, 31 Jul 2018 21:20:04 +0200
Message-ID: <20180731192004.acg5jnbj5wg55mpl@ninjato>
References: <1532971432-16784-1-git-send-email-kramasub@codeaurora.org>
 <1532971432-16784-2-git-send-email-kramasub@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4qhevqwx622auvc6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1532971432-16784-2-git-send-email-kramasub@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc: gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, evgreen@chromium.org, acourbot@chromium.org, swboyd@chromium.org, dianders@chromium.org, Sagar Dharia <sdharia@codeaurora.org>, Girish Mahadevan <girishm@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org


--4qhevqwx622auvc6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 30, 2018 at 11:23:51AM -0600, Karthikeyan Ramasubramanian wrote:
> This bus driver supports the GENI based i2c hardware controller in the
> Qualcomm SOCs. The Qualcomm Generic Interface (GENI) is a programmable
> module supporting a wide range of serial interfaces including I2C. The
> driver supports FIFO mode and DMA mode of transfer and switches modes
> dynamically depending on the size of the transfer.
>=20
> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Tested-by: Stephen Boyd <swboyd@chromium.org>

Applied to for-next, thanks!

As discussed, I squashed the MAINTAINER addition and the RPM fix by Evan
into this commit. Please check later that I resolved the conflict
correctly (once I pushed out).


--4qhevqwx622auvc6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltgtmAACgkQFA3kzBSg
KbZB/w/9HH8s4ZoLSwSh1QhdKUiRR9aiOmooUw0N695JNV2axlbODP0Mki6l3NfA
GjPUniZRBjHCUgzpKPYtau/bE9g5uZvNUsS/kT3hVHdrOxQNs3ViHrK/bj91j3OL
SsYkPwfW8jv+lEKK4JhAm/aub/7DmaSBhK7or35yAEKCUaQ/QT04RPa32VCGth17
LE9u+ShVmJ/TsT6lr8NJ9SJvN+jeMgiXLDjvNyFBl+BuH81YfPcIZy2GvhH9vp6E
bjaJqjMlidj9W2PjhemrwcdDUCWyV4TU4Qm9zh4h0usdEkbhyGRSzXTdttCqjg5l
kGQ6vDQ1uClX5Om0kayv4TOnXRpVFB+9e84duPQiq6Q9bhRS6+ni92HrPeDv2y3u
j8eNBdB5YxIyx3AJ6rdLR8v9xvojoyq5PY8MpPEiLvFdnsGFHJTU56CmY4+Z6aZf
5jBqNf2DkDXjJD3JX5A63UqdwQaNuvq+lVEmUwLsa/Xjbin7bCTpWxaXUFxzdYrS
Nzun+YXWGcb2mOXIlizeXGRZPAhWyj3AvswGXbD+EbeN0jUDoT1oS5F+844H8ooI
QQyANoY3jXpN5MPhNJncN40EM/lY/Zm3C/oJf97Y6Sr05M88afMP2ln1Zc0gP9C6
9csA6zBBKj+zJhQcqM56TzDLGStDePe5o1YVnDc1OEyNG5FAC6g=
=QotW
-----END PGP SIGNATURE-----

--4qhevqwx622auvc6--
