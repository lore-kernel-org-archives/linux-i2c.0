From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: mpc: remove useless variable initialization
Date: Wed, 1 Nov 2017 23:52:53 +0100
Message-ID: <20171101225253.hdr2ol6bysbv6dii@ninjato>
References: <20171027202444.20220-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="omr7nzpkfhxy5noz"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:59289 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933336AbdKAWwz (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 1 Nov 2017 18:52:55 -0400
Received: from localhost (p54B33BFD.dip0.t-ipconnect.de [84.179.59.253])
        by pokefinder.org (Postfix) with ESMTPSA id C632A2C348B
        for <linux-i2c@vger.kernel.org>; Wed,  1 Nov 2017 23:52:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171027202444.20220-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org


--omr7nzpkfhxy5noz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2017 at 10:24:44PM +0200, Wolfram Sang wrote:
> cppcheck rightfully says:
>=20
> drivers/i2c/busses/i2c-mpc.c:329: style: Variable 'node' is reassigned a =
value before the old one has been used.
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied to for-next, thanks!


--omr7nzpkfhxy5noz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAln6UEUACgkQFA3kzBSg
KbYWFhAApzitfJeIbfbfrrljBSyXlWuTEbhpH2bH/+SnjiqpfKenu7FLS1yUYGTX
qBanRD4BvGIzjvxsU+gFmbnGEhEOJ8MghTgUBxORjpweIB+/PMbWciW2XaK5iLNe
Mtoq1qxa0tfegHQObDzW7+18z8du2/jDjJbQFjs1uCtAAQQfOjXCFWfNAp65kcWK
K51Iq2uVLvhDYjHkxJx4SzRSGnrDTx8rYD6kiNCwcsyBbY4FbQneWdpjYbx/RWOx
OMMUFO4uf2674KUndmSeOJMBwMug/43s68ez2qCNtqYj6Evu82bN8FHFVSyMtu5e
BIut/hgr7C2d74pW62JFwTmyG7nqOkLsqqQ6h60WyoD5PDwOhkC5iu/mfI+S6bkH
7aLn+NwLJyoHtUPxpHOcqMK4R8U1ZH2DramLleDm8x27UaRhHCDI0/uLLSqvkjXI
4zoS7/z+1z47UxBf0hrPlp9DykxCQHCjnBbyknB22dCiyo39R1amQiQsAQzK/yzD
HRAUrDXKBW6TCCUN0OwQDNDbassfxAspUV0KnOVRHK6WLLfeRx3thVgMhgxpYShj
/9KgM/ABbMbz4PfJagYliGCScMXJRxrXeoaDq3+EmGcZFz2MNWQlGB4VOvnpH+uz
X6FfZukOBNBOKjVEcKWjUwiBS0KURfhmKhe5QqgwAp4zNJi/a48=
=hDll
-----END PGP SIGNATURE-----

--omr7nzpkfhxy5noz--
