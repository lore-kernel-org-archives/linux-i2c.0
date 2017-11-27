From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH RFT] i2c: sh_mobile: make sure to not accidently trigger
 STOP
Date: Mon, 27 Nov 2017 18:57:08 +0100
Message-ID: <20171127175708.gxtlojckgrh7zozc@ninjato>
References: <20171115143221.30618-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e6mqw7qviecwrpib"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:47855 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753778AbdK0R5K (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 27 Nov 2017 12:57:10 -0500
Content-Disposition: inline
In-Reply-To: <20171115143221.30618-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Jacopo Mondi <jacopo@jmondi.org>


--e6mqw7qviecwrpib
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2017 at 03:32:21PM +0100, Wolfram Sang wrote:
> The datasheet was a bit vague, but after consultation with HW designers,
> we came to the conclusion that we should set the SCP bit always when
> dealing only with the ICE bit. A set SCP bit is ignored, and thus fine,
> a cleared one may trigger STOP on the bus.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--e6mqw7qviecwrpib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlocUfQACgkQFA3kzBSg
KbZuahAAqaR4TjVpw36fuqmGOk3OW7ujP2f4xwOoL1rfAi7g9y0/B+azQqZcT2Ys
usMdVvEZR7nGF6qGSLDhhKaHP1F2EUjNH20YnxzHwaiOW+hNMqeelcNDsLOGIIMz
uJFAZ5DEoV0Lq3qe83X14R+7QyCctoj5cPakIsxS+vIymfBnmzKcYnIknWMkxIyC
ZrYIjfbbTIs3nHjvB+x/fw6IJ4e5tSVPI+qyBbu0mbR3R+G7FiI5eG/rgMvDs54p
6M3zF7wreN1KT168GM+oGelDb2qXy33HKA9IZQiZvXOH71q9tJNx/1q6WFCZR7b7
UfdkovDn0i5kKgE/K3pw7fONN/CVJ1H+ybIVmpFa52WFYshNAzxG0ZbCb79TzWTt
w6VNIji+yf24BfPVYsogPYoUxBTSKFz2Nf9Ndnyr2vfRcEpX5qgT2JQVPBx0jqwL
1KrfXGaLr954j95Y9JIFcJ3tsCF44iDuouN7MkYpLU2VY0kUBcs0hBhjqMnXuwpu
uULDDJT5n8iuFUo6/iXFw6mgfOpLc3dWUPDHwyNMXfJvxtbogq+1GfBHAFZUHBUM
mbSfB9JIwZbQUleKKHH5hXhM3RhXid8ijqEbCpsvan5z1IG7VHVVXA4djncm+UHK
6Xg/+nNYslxhNizKRVn807Snr+Dl775qasy7Aolv5iFzy0rM628=
=iXYA
-----END PGP SIGNATURE-----

--e6mqw7qviecwrpib--
