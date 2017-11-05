From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: nuc900: remove platform_data, too
Date: Sun, 5 Nov 2017 13:01:13 +0100
Message-ID: <20171105120113.2rzugwks5tmikp4u@ninjato>
References: <20171104204926.4711-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mkxxvwsfsggytwni"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:47003 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750751AbdKEMBP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 5 Nov 2017 07:01:15 -0500
Received: from localhost (p54B333B7.dip0.t-ipconnect.de [84.179.51.183])
        by pokefinder.org (Postfix) with ESMTPSA id 3C5BA2C327F
        for <linux-i2c@vger.kernel.org>; Sun,  5 Nov 2017 13:01:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171104204926.4711-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org


--mkxxvwsfsggytwni
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 04, 2017 at 09:49:26PM +0100, Wolfram Sang wrote:
> Commit 7da62cb1853025 ("i2c: nuc900: remove driver") removed the driver,
> we should remove the platform_data as well.
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied to for-next, thanks!


--mkxxvwsfsggytwni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAln+/YUACgkQFA3kzBSg
KbYIPxAAlLHajmgYr0yO2J70RfZWXmGXG+8rnsWeKh8IfLzQlu7+5Yr+oAHnw1A7
CQOn3/Gk9MwdtdlEIsCd+vwksn2T4v8hKDaAWa3/XGQWjMFPzVdf76Tzrs9e1m3y
bhFUSUNO9LF5SxH8VRkdcmiqZzhEAZMT2pdDlJyLV0udXiFHme+fuYazOuCILBX+
3+FZ6HdlaJuKZu43KDBWzj9/Qszp1k92uCFACZDS2cQ5qp3ty0LU7xGZfp2qIgU3
kvRg93wjGRwWwWbh2H23mcPSamTczDykwLSBVq/byw51fH7xuR1BlN4gXtluqRYF
zZky6u/JUeFf/bMl9ltqGFBupU4SLrpdVmWvJGiv/I5BS/dEPDTh7aoFMvS5bLj+
EHjK6X40wu5lfM2pEYRVBMyCNX56aVrKlP3ucN2IathTPfsL5XwerC2TBOP/2G9S
qUyLUPrVceTWJKShPFjFNBJpC4Ah94RaEfPOvDMCqGG3Ek1Z+dinZh3Qq706LuAh
/zOENtvUWuvXKMOVN4v/PrUu87bSUyVYcWIM0YWg6Xavrr/tXEiuaCCe+0/qmsKg
0sg89H05gIaCVAsDqBUuu+++zeMuhKWD/8DPIMfcl0TlcK6yBT20bdex+bdPozx2
DTkbgxDB+L4hrsUCAHNDOWi2Gme/ivB3DIT9016UlfTyJur6LpM=
=ArsA
-----END PGP SIGNATURE-----

--mkxxvwsfsggytwni--
