From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 resend] i2c: designware: add reset interface
Date: Thu, 9 Mar 2017 15:43:40 +0100
Message-ID: <20170309144340.pp4pu7a272kmsjdm@ninjato>
References: <y>
 <1482848560-3752-1-git-send-email-zhangfei.gao@linaro.org>
 <20170112185445.jtryoj65sdvey7bc@ninjato>
 <381cd2c0-499d-884a-3c4e-6fedc422f2e0@synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7cmdvfhjn7zgeegc"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46313 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754508AbdCIOoX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 9 Mar 2017 09:44:23 -0500
Content-Disposition: inline
In-Reply-To: <381cd2c0-499d-884a-3c4e-6fedc422f2e0@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ramiro Oliveira <Ramiro.Oliveira@synopsys.com>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Luis.Oliveira@synopsys.com


--7cmdvfhjn7zgeegc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2017 at 03:11:48PM +0000, Ramiro Oliveira wrote:
> Hi Wolfram
>=20
> On 1/12/2017 6:54 PM, Wolfram Sang wrote:
> > On Tue, Dec 27, 2016 at 10:22:40PM +0800, Zhangfei Gao wrote:
> >> Some platforms like hi3660 need do reset first to allow accessing regi=
sters
> >>
> >> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> Tested-by: Ramiro Oliveira <ramiro.oliveira@synopsys.com>
> >=20
> > Applied to for-next, thanks!
> >=20
>=20
> I haven't been able to find this patch anywhere. Do you still have plans =
to
> apply it to for-next?

Uh, thanks for the heads up. Can't really tell why it fell through the
cracks :( It probably got lost by an improper rebase by me? Sorry about
that.

Applied to for-current, thanks again!


--7cmdvfhjn7zgeegc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljBahwACgkQFA3kzBSg
KbYscg/9GdXvMJfknDIgyV6roF8eab1JVoBFSQCbBSU8RhfVCZ0ZtVZtVlfVm4y5
QGzERtPofpFWky0D4gbOvFakOhrTr3HUu8Y4DcFhp6NMwRn5zAvjLE7/MJg7/Srr
DL+o78T75ac8SVz7EmVOce2dDW63gnJyyH2Mocx43BNmfR9I7lLNBptiChXHfTFs
IYmOnhVfDZpqJM8/Ei+lJ4EzyJfmvU3FEQ7cWJJlQ6FT3skrmHF2B4dWVNpLHSmC
IcprGVWBvYxyXCWPDav8T6jyN0nMILVQoR36s0oeptR4Qw8HkFuLQl0ct41zHtwb
oljal2lqUAGyMyVX934y35YdYjGUPy2G8/LfXXdbCILmiQPKxZhxmF53Z286DDTB
bh+OKYDZCtlyofLssTWdjFtpnqLYlOsvWkrcZ6gs5nBvN8uDIB9DntbRRlZAUiCk
3HXNzAOQepbJfP1TmRPuLgEAULU6N3ltEJEyMkpsBv6R6wWZX/rSq5yt/DT/Os2M
lbCnNE1F2bzMYkVBedNkr/tBs0OOXciVO+Hi4EOsUB2etOeOMEGBAg/AtZZqOhs9
dw3hjwpYyrOpfXEZd2tZXMGhn2JTEcm3fccEiKoRI9MLN6cXYaOcw8IpIL+pifjS
XuuDzQ0xVoyB8dJK1ZUN06eVpmvRI4xCTVDFyc5wgNVz4f1ZGbk=
=bsvt
-----END PGP SIGNATURE-----

--7cmdvfhjn7zgeegc--
