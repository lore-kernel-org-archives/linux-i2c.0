From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: move locking operations to their own struct
Date: Tue, 23 Aug 2016 23:16:00 +0200
Message-ID: <20160823211600.GF20872@katana>
References: <1469780277-31085-1-git-send-email-peda@axentia.se>
 <1469780277-31085-3-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="z0eOaCaDLjvTGF2l"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1469780277-31085-3-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--z0eOaCaDLjvTGF2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 29, 2016 at 10:17:57AM +0200, Peter Rosin wrote:
> This makes it trivial to constify them, so do that.
>=20
> Signed-off-by: Peter Rosin <peda@axentia.se>

Looks good. Could you rebase to i2c/for-next?


--z0eOaCaDLjvTGF2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXvL0QAAoJEBQN5MwUoCm2HI4P/RyTA48CcAz1m28T1hy0XJzU
dft3Owl8CF6NFGD9VGjk0/mIzyu2BF01+43FfAgNXkSUo4TfDps1V/NXqS31+E50
qyJpPIUn3fP8aQce0FNX7DNpTKeHugAXNfvRK5KTIaNvj1Iu/tIt5COq2MC4SCUk
kiWWScEpg4I8m68o2ArjFJWWllogu1iOJuMmmm7+KRiRTgV8rpfiOkaEETO6f8Sd
9IAO3lX4MNUFVEo00kV7m/VfLEiSJH8/3wA1+CItcQSLNkf6v+dCbXzA3XregsJW
V/af60P6CfzoZ1Tmp6gVLZf1nwtB/4iNbY+inrul6zP4zebbI6wn/7eOM2uchSOR
VQYH/A/uxaHaxAB6kOCuzX5YU9yKWlPpM4u3n1v5piUJgk6BQ6qKRLK4Mj4A6bix
hA2DNyFMGI7Kfo4ESwQJBsIhyfnAYoS8dxHKfmKllX+Kf5lCmVB2mxbGjsS/HCsu
I3Kf35uysFvWKcEr4zk20afufUFrRqi7QCem/95FDuIhT59F2PcmKfornYBW+2ZK
LsIWHuhcnKlImPIlk/9bMpgkcmbMBzWCQ/lgnt/ze9jGW5YFJO4ZfjgbCVpw+Hmh
oG4vRcMFvnfqdpGOfuCjB/aiZ9OgceAlP9LE+vzFRsxpYyVSssNF77cogU2YZAXB
MLCpS7qciDLjkOw/AenF
=nUqA
-----END PGP SIGNATURE-----

--z0eOaCaDLjvTGF2l--
