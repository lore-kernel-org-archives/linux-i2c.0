From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i2c-mux-pca954x: retry updating the mux selection
 on failure
Date: Wed, 21 Sep 2016 23:11:24 +0200
Message-ID: <20160921211124.GH1513@katana>
References: <1473859452-8069-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AqCDj3hiknadvR6t"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46790 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751501AbcIUVLa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 21 Sep 2016 17:11:30 -0400
Content-Disposition: inline
In-Reply-To: <1473859452-8069-1-git-send-email-peda@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: "open list:I2C MUXES" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>


--AqCDj3hiknadvR6t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 14, 2016 at 03:24:12PM +0200, Peter Rosin wrote:
> The cached value of the last selected channel prevents retries on the
> next call, even on failure to update the selected channel. Fix that.
>=20
> Signed-off-by: Peter Rosin <peda@axentia.se>

Applied to for-current and added stable, thanks!


--AqCDj3hiknadvR6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX4vd8AAoJEBQN5MwUoCm23GoP/0esxMi9r3WpISPXjtXjomJG
m7Kjz8r5hAEDWBDrSuhNr7q2tqEKgcojQRC1zFcaA9FezDF8Dr7OBEVgjNur3ajD
y08yWEWbtGyMpflH8V5RrNwdG8GPeTrYbhf0Gi2TL6i/kke5FuabdLSmUeqKi6I6
s19efZmJejbamOXginR/d7o/IEy4HankfrCHTYnnzM4HeX0WgMu18dFkdhGA+Ty3
iU8uFEgpyCUae1SnTpNRgOrJFpOx0a8UnsDBiZ01xj/AKWKGfqhn7Sm1F9AmGdGd
SsQiIJnG/Qpd32ltpxEJTtoSJS2JdIA/5ZkZn64ZTq3qa9J7bLLZPzLTZ1p8O3Xq
lOIxGy3yeQJosOXCejR0FNaeo9Jzoi5Ankk5H4J8S2sgPvx/lxQBryb2dsuxQM4V
dYAfYCneoS1RCtVz0GU3G4em/zf56rsBN6WUzep9+EZyPi/62xtxSq7R0k+Zio1u
qvwnXTv3SWHUV+ONakMO0jR/MD5HjRxXwVF40J4pSroGEyS9C7yQczmOSL2bpftK
py9aHh68TcZyaodIG2i4a39JvmsGhdspIeADp8ZCY6fAJt7UocbpxcpmOdlTKEU7
04L6rI5Yx3SUxbrsw2IMagFUF03/hUVYoQW24MmJZ2PPjPx8rlposeIyyDZ3pDWm
7oofDnh+wH3Hl00tboJB
=tOyW
-----END PGP SIGNATURE-----

--AqCDj3hiknadvR6t--
