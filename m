From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: xgene-slimpro: include linux/io.h for memremap
Date: Sun, 18 Jun 2017 15:02:23 +0200
Message-ID: <20170618130223.p2nysktwi3fqlvj2@ninjato>
References: <20170609102937.3054567-1-arnd@arndb.de>
 <20170615135740.fa2g5wbdwx7psn2w@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ipm45dis365u752j"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:48981 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752364AbdFRNCZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 18 Jun 2017 09:02:25 -0400
Content-Disposition: inline
In-Reply-To: <20170615135740.fa2g5wbdwx7psn2w@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Hoan Tran <hotran@apm.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Tin Huynh <tnhuynh@apm.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--ipm45dis365u752j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2017 at 03:57:40PM +0200, Wolfram Sang wrote:
> On Fri, Jun 09, 2017 at 12:29:12PM +0200, Arnd Bergmann wrote:
> > The newly added support for the pcc mailbox fails to build
> > in some configurations:
> >=20
> > drivers/i2c/busses/i2c-xgene-slimpro.c: In function 'xgene_slimpro_i2c_=
probe':
> > drivers/i2c/busses/i2c-xgene-slimpro.c:516:25: error: implicit declarat=
ion of function 'memremap'; did you mean 'memcmp'? [-Werror=3Dimplicit-func=
tion-declaration]
> > drivers/i2c/busses/i2c-xgene-slimpro.c:518:13: error: 'MEMREMAP_WB' und=
eclared (first use in this function)
> > drivers/i2c/busses/i2c-xgene-slimpro.c:518:13: note: each undeclared id=
entifier is reported only once for each function it appears in
> >=20
> > This includes the missing header file.
> >=20
> > Fixes: df5da47fe722 ("i2c: xgene-slimpro: Add ACPI support by using PCC=
 mailbox")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>=20
> Applied to for-current, thanks!

Oops, the offending commit is only in for-next. So, reconsidered and
moved this patch to for-next as well.

Regards,

   Wolfram


--ipm45dis365u752j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllGed8ACgkQFA3kzBSg
KbZMkg/+N02fw3h1PkJK+VPRi1DhJ+Z28i3FibbyNq2NLNrQ0piZpn/Lpb7wB6ON
D0zcI9soNaAp8yTvTIj4FSkGpHepYliz0j5R+J8+ghPk4WhZFTQ/Uqq0hLt3grWM
8k7NiknCt8m5dlEgHVM2/YTLSZkraNXs+6NaJagzkTjg5bFGaB29R07IdpvRtl+a
nHUynwhMKuw/KKQctgVssUs2L3Yf08opn61fgfioOdM0D1FvzmMUyt5CLqJDtDcR
Fq3dlFaKMOtRNpygNJhhlMHRwkL74MdF6QtOxLiJjPAsi3G6gV/xIbQOuTL2OMaC
59YLK7zC4ZBi78q4EjnLIoVpT/8j4pw3g3dwLI2otdCBZWg1MRKA8SNjMdJH+Vf4
D9ZD+vrKb4PtbAjqTpxE4SUp8IVmmLn80BCfeFMrDGMg3csXut43CvbjBWkedBbp
eRVD3h4oLg03yg3og/x5NjBwypW0QfuUSBkxjRn0moo0jtBJeBAxb1q4ZDroQMAI
oDdcV8cU0Wk0VHLCuNRPmT8SUR9nlfrWRBWP403Oj49k5TwCJCWY+85DNEIzL13D
pnbEMIXuXDs8EvGo9+caBB4YKbFvyUWuGY83J7HlWY7g7o2y9qurk4dB+Ktuec7+
9j3wnI8JPVqFCKUh0AqACpiVoEKPXj/4xfr1K0TpkJO+dgdngSU=
=NPcR
-----END PGP SIGNATURE-----

--ipm45dis365u752j--
