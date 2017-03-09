From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: do not leave semaphore armed when copying
 properties fails
Date: Thu, 9 Mar 2017 15:48:33 +0100
Message-ID: <20170309144833.3mehuovi3wwqma2m@ninjato>
References: <20170308184102.29334-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="upgkq2vyraudbnrk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170308184102.29334-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--upgkq2vyraudbnrk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 08, 2017 at 10:41:01AM -0800, Dmitry Torokhov wrote:
> We should not leave i2c_register_board_info() early, without unlocking the
> __i2c_board_lock.
>=20
> Fixes: b0c1e95ab44f ("i2c: copy device properties when using ...")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

So, it seems that patches 1+2 are related. Because I'd like to have
patch 2 sitting in for-next for a whole cycle for sure, my plan is to
revert the faulty b0c1e95ab44f from for-current and apply the fixed
version (b0c1e95ab44f + this patch squashed) to for-next as well.

Is that okay with you?


--upgkq2vyraudbnrk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljBa0EACgkQFA3kzBSg
KbZxMA/+OVVYsJiqmzOZHSMoOBoMQ9IZms3QTQaTMvKQWJ5WyjYOjn1o/74uU5qb
aytlbxD/FI8nIqkfBrOaEPygnPvZYm8PvRys9uZx6S8zndr/MCLDNTokeAt+O27+
JZVUVYq/+D4WBcBCW9r2sjQ6drk/NWYSwEgzUzuP9/4+BDyugVehvA6ogAdhLUPM
UpqYpR4dPCzoXwebEvs9XHQPBG672jrLFBr/eFaHsp9BZmjqEqPOT0pCWclR/GAF
iot9/Ga43q0MsUxP5ykFoAs0cC1tYs9/qBFieqEDJH5Vo/IKiBjsQwiAPbr1jMQE
VtzwjQg3R6Q22J9cORtekRfi2/tYF6yRG6brMfgBNbpGp4nSJ/oRpZYLCG1mg8bw
1PxLLr5IXW5GBbBNYQK+ATZUs7qUSoCxWXJGBSRs/IFhfjbbzwryYUvISvp/07/D
IPEcKR6Rj1dZ1mx3t9Lh89N+rBvx/mtjppcFiw6+z6N0BMu29Q7iBUDAIf6HaFW8
8i3NY/KdnXbnurXRtQ7bhgdnaz25mtn3O3QIapWjtployx06wsIZvgT8f2SbLUMd
P7wSqKmQr5TquvEY/jc7ysY02yESptSwxJtngVrTlcVoPVarfx1mWwQ2Pha8yaPW
6zfiWN15M6mWQvGaf8pdcSRpbxM03Kb6pLVhNyeidw5/TxWlXfM=
=vRyB
-----END PGP SIGNATURE-----

--upgkq2vyraudbnrk--
