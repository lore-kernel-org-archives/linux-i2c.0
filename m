From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v11 1/6] i2c: designware: Cleaning and comment style
 fixes.
Date: Mon, 19 Jun 2017 18:26:50 +0200
Message-ID: <20170619162650.nxshcsevyu5pk5vj@ninjato>
References: <cover.1497025304.git.lolivei@synopsys.com>
 <ad57f66b8deef7065d53bed02e3e992748ff315d.1497025304.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="35ee3x3nyxsvapgs"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:53941 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751023AbdFSQ0w (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 19 Jun 2017 12:26:52 -0400
Content-Disposition: inline
In-Reply-To: <ad57f66b8deef7065d53bed02e3e992748ff315d.1497025304.git.lolivei@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com


--35ee3x3nyxsvapgs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2017 at 11:43:21AM +0100, Luis Oliveira wrote:
> The purpose of this commit is to fix some comments and styling in the
> existing code due to the need of reuse this code. What is being made
> here is:
>=20
> - Sorted the headers files
> - Corrected some comments style (capital letters, lowcase i2c)
> - Reverse tree in the variables declaration
> - Add/remove empty lines and tabs where needed
> - Fix of misspelled word "endianness" and "transferred"
> - Replaced the return variable "r" with the more standard "ret"
>=20
> The value of this, besides the rules of coding style, is because I
> will use this code after and it will make my future patch a lot bigger and
> complicated to review. The work here won't bring any additional work to
> backported fixes because is just style and reordering.
>=20
> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to for-next, thanks!


--35ee3x3nyxsvapgs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllH+0oACgkQFA3kzBSg
Kbb2ehAApcWD8oGFXQVMdrNJycFg5Qodjp4arWnIr29lKixAuVMWjJw72kJOKGT5
cli3qe7kKc4P33CkoC86WoF5jEHHXhILU5GOSFyxzFYhjHlx4OoA7y53i7V0NgbC
dTTxhEm4sReI0QxrUZBoHtT2hw7ARUyLWo26BgsEtM7awzQIKr6KQEBIKuFLAhB0
vdK8x5o1ZZvjp8t6XCbya9jPCAkKEHHxGoiqs6DslF69W4IEwfRsp25uX6tpfjqb
6iC5S+K0CMvbJiYJ7YKOsh1ppA/EkDyqssRVrWeB24KYBHydjGAVdj8CcofpGNCr
AVPCg1mHj2J38sd8z7jUk4SJ0YRhYrb6Wq2TEAS4VYIdhBVUXiMDTr8kXpVHvvAq
fGxuKuM2fAZ3sCvguHPjB+1QKT+t25SLBaLkgKM8D/vVyRt0DO4a63l6oLkPyYZI
TPkfKRLsLV6WXOXmV70UfIc3dCd9TkaiYbH7t0F7pmwFhIoh0vTuCrGZZI/NTTnN
6FlW6dMlbYcCiKS9DT1bVO+9IKfEus1G5L5C1nnPSwdTqjOfTbnBXIa4f1paUbaS
SEZV0bYgEsTwF5VlYeN/IVyhi79t3bcy1grr+nx2dZK4D68QUGzOx4gsrYiA/BCM
YgYaJbXz40Fr2Cd4HK34tUxAYyGikBE4yJ3aFE39O63hHM5ARmE=
=yyYj
-----END PGP SIGNATURE-----

--35ee3x3nyxsvapgs--
