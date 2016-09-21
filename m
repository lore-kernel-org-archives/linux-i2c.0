From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/5] i2c: octeon,thunderx: Fix high-level controller
 status check
Date: Wed, 21 Sep 2016 23:01:24 +0200
Message-ID: <20160921210124.GF1513@katana>
References: <cover.1474439371.git.jglauber@cavium.com>
 <3d2e2e4e91e2245318a278b19f22e9b1af3204d1.1474439371.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+jhVVhN62yS6hEJ8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3d2e2e4e91e2245318a278b19f22e9b1af3204d1.1474439371.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--+jhVVhN62yS6hEJ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2016 at 08:51:04AM +0200, Jan Glauber wrote:
> In case the high-level controller (HLC) is used the status code is
> reported at a different location. Check that location after HLC
> write operations if the ready bit is not set and return an appropriate
> error code instead of always returning -EAGAIN.
>=20
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Applied to for-next, thanks!


--+jhVVhN62yS6hEJ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX4vUkAAoJEBQN5MwUoCm2sqcQAKn7QUiMy4FbciCm7E9YL0Wu
gYQStrkJarHUU3QdmHyx3Q8l7NWysImbXZzhJbIgxHm4Vt9uJO2Fm6NuIo/zTtt1
/kBy669VfCBHmShkLnIZeVW8gXXGnnGiUNs4e8s58nhHssX7BT5Dc3YNOTAu6yXw
OK7v+iG/ZaoXBvaFAkrM1iZ3l2hC69wl7i7lnxsAmblUd2WsMtQtLIF5DbleivrI
O8yvRiCuZ3FrUKNh+KLFGlsGK7L83oGdXiD7y6TOwV0NDMd6CC3p9q9n/HFH8Xze
C7DtkfhggwTpZy0SdeojvAxm8liqV0r0PLCAeEI1N8Q4FRDLEdF4Ni0zewtCtAUg
AuOckwY2wAoV9M5MtrKgdlw5IEDypPysP96ApdNmWUrwRTrZ9WBJkG1MwTbIcWu9
YFe2lEj0weGd0/xexC/u6d6NH1v7Mw1p8vHVZpNcXe7qNa7SS0doVqFexqBtWdG6
CCtuvwWgjXd9j2eNUuLBExkWmzXPtRTdAFCtP4lbtSWS/6jBm8uJJ4Ensw33gyb+
TSHeY8yWWnQLOw5bPaSj2T91SXAAwrysLXxXU8Ywgdkys/SEP765L7S/f/AHU+C0
5QwvHn063+Br6uGk2uU70oh5lL1JxFzvze02wcEEB3pgytqiW/fS0bE5U5Zg1P2o
W8ie8t4OmpVFCtSNWdiv
=a0Td
-----END PGP SIGNATURE-----

--+jhVVhN62yS6hEJ8--
