From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: ismt: 16-byte align the DMA buffer address
Date: Mon, 15 Jan 2018 21:03:59 +0100
Message-ID: <20180115200358.zmenw7bvit3v5se5@ninjato>
References: <20180104181813.25474-1-radu.rendec@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mcjdgmpvguphiauf"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:41408 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750714AbeAOUEA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 15 Jan 2018 15:04:00 -0500
Content-Disposition: inline
In-Reply-To: <20180104181813.25474-1-radu.rendec@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Radu Rendec <radu.rendec@gmail.com>
Cc: Neil Horman <nhorman@tuxdriver.com>, linux-i2c@vger.kernel.org


--mcjdgmpvguphiauf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 04, 2018 at 06:18:13PM +0000, Radu Rendec wrote:
> Use only a portion of the data buffer for DMA transfers, which is always
> 16-byte aligned. This makes the DMA buffer address 16-byte aligned and
> compensates for spurious hardware parity errors that may appear when the
> DMA buffer address is not 16-byte aligned.
>=20
> The data buffer is enlarged in order to accommodate any possible 16-byte
> alignment offset and changes the DMA code to only use a portion of the
> data buffer, which is 16-byte aligned.
>=20
> The symptom of the hardware issue is the same as the one addressed in
> v3.12-rc2-5-gbf41691 and manifests by transfers failing with EIO, with
> bit 9 being set in the ERRSTS register.
>=20
> Signed-off-by: Radu Rendec <radu.rendec@gmail.com>

Applied to for-next with Neil's ack, thanks!


--mcjdgmpvguphiauf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpdCSoACgkQFA3kzBSg
Kbbr2A//Z5Q/tX6rVORKp+SZTYzIeoZwAB24W3ewfTI0b033kCmvnaN1uSiR7hiL
6H/deg2g1PBYOQP9Kbxe1dOsw48JR7zUNwKHZkjpM4LMk5yRC00NRzweGRK0gPvR
NiOgfLpz3JLnuAEaZJagnI4oDWxBHSl24VoVkSuK6YGz6xsQP9iBRTRkybKwbSOC
LpjRYf7g0pT1rXbN1w50Bh+vUw4b7eIdl+wmrJWMbOLsI/opZMWSHNwXpweA5MQ2
azPAq8Eo5O45pj5wsRM0Pn2vHfGBqiUs2VKyBvEIV/hrVfVHcUtwR5g31mlfgi/l
iXdVRkTBfDrH6pRehuyFhUxzfck3NTcNadbANd/Ns9KuFY+9fsp4L5otzGrG+gzk
DOYfEfxBOB3LWoIXTPCiQmBVLmyB/05TpQn0ISY0Wzn1ASwsEri6kS7VMKNi7NI2
4PF8nGH+fx5CzgvueP4UfjrudBh7wz8a1p6x8XW49PDHV9reH52RhKCouNeQfKxN
9BuGGXnkqv8xBcOlt4IJ5VIyIKFWKB1DVllyRxPCaGOp2DL2TikNI/L2+JNWxOux
wNYQhdKo8teJ0wrHzWFt0cqDiA+DDxjYcmAf34sWMmia2QBt0QMuOCRmL9Rsh20m
24yl84DDEYf5q8dCp0bv6fwtg63lMdERhHhqymwWEM6t20JG2HY=
=KZsP
-----END PGP SIGNATURE-----

--mcjdgmpvguphiauf--
