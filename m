From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i2c-stm32f7: Fix SDADEL minimum formula
Date: Sat, 9 Mar 2019 11:13:40 +0100
Message-ID: <20190309101340.GH1340@kunai>
References: <1551885125-22295-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dDnEQgWzhgf+8aPe"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1551885125-22295-1-git-send-email-bich.hemon@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bich HEMON <bich.hemon@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Pierre Yves MORDRET <pierre-yves.mordret@st.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--dDnEQgWzhgf+8aPe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 03:12:16PM +0000, Bich HEMON wrote:
> From: Nicolas Le Bayon <nicolas.le.bayon@st.com>
>=20
> It conforms with Reference Manual I2C timing section.
>=20
> Signed-off-by: Nicolas Le Bayon <nicolas.le.bayon@st.com>
> Signed-off-by: Bich Hemon <bich.hemon@st.com>

Applied to for-current, thanks!


--dDnEQgWzhgf+8aPe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyDkdEACgkQFA3kzBSg
KbbSphAAskJuy5T8s8xTMRUdsSM01BnbclYC/krVWBZ6DI/8iTD43g3iycVYzrPZ
GsqMQ8p4u+Iaz2od7b3ktJimjjNYamVn0NZjEj4+12WXijm4hg+uG6b/Z/HQsWWX
gXnrBck0Z1CUMvHRbRXl1B58eDu3RY5tmLAUa+FpDtyKopc+yzK5lZuZaL93ZlgE
MR6NWVyBHzx7tShkgNja5riQKaBMX1hNtE3Av1pFSMtYtsIQT+AaQf+QMI5FTtSw
5HTOQw9zg7VGervtttN4N6FxQCLb9xeWVjxuO0oz7ue9nztUG5HqA1FLYTa5pYCJ
Web44xspncMJF+2tmVki57CnICinQqBdtbiH567wHClDuPeW/U7/r9l5q0v7DPEs
xZzneg4LPE9AoLxlkVNY4jYQZQwnJ1Vv5weiOlfEZpZLwDN6ESaNbH/l2QkeryRG
f2eahSSLJW4T6osEoTA0pA4B5ipcL//7MSnZftsNFSfC9bzLWXfUuY5na+/KW3V8
dk62VmP6LBUqysYxjKASvtu3aNV0ibCwKoI/j5iAVOvbXWAKsQ+EenZMmTWmSK68
/lfbLc7X2TZ3gHHVrzvkiYTWV19ZlN+24NgaIFOraAzf3U/aHJi2G4fppBGs3i0O
74gbgKqHMwwxgPfnfSJJcHs31ekm9aiwS/kVdWl8t8amQRD/vOI=
=ihtV
-----END PGP SIGNATURE-----

--dDnEQgWzhgf+8aPe--
