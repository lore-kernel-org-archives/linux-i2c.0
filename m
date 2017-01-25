From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 4/4] i2c: octeon: thunderx: Add I2C_CLASS_HWMON
Date: Wed, 25 Jan 2017 21:49:23 +0100
Message-ID: <20170125204923.2mxtlszvco6wxjok@ninjato>
References: <20161209093158.3161-1-jglauber@cavium.com>
 <20161209093158.3161-5-jglauber@cavium.com>
 <20161211220434.GH2552@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kvefycufcam53cqp"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:38889 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1751104AbdAYUtZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 25 Jan 2017 15:49:25 -0500
Content-Disposition: inline
In-Reply-To: <20161211220434.GH2552@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>, Paul Burton <paul.burton@imgtec.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>


--kvefycufcam53cqp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 11, 2016 at 11:04:35PM +0100, Wolfram Sang wrote:
> On Fri, Dec 09, 2016 at 10:31:58AM +0100, Jan Glauber wrote:
> > It was reported that ipmi_ssif fails to create the
> > ipmi device on some systems if the adapter class is not containing
> > I2C_CLASS_HWMON. Fix it by setting the class.
> >=20
> > Reported-by: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
>=20
> The intention of adapter classes is to *limit* probing to a certain
> class of devices. If a class is needed to *enable* probing, then
> something there looks wrong. From the details given, this must be solved
> elsewhere I'd say.

Makes sense?


--kvefycufcam53cqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAliJD00ACgkQFA3kzBSg
Kba0WQ/+Joj3qXVtIK9YO20DPGo+xa3A7stPfyWcH1uHwJIWaDN2HaKh5itEtvq7
1rIB0NXijNm53SvTsrZVzoERZ5+2/LaI0Qg6u8EKZYDjbxt1P7uU0RYnmfyVwqfH
85jXNSUBpEvuMBS/jvCMGcisXnBmlEyO2gIegLY4XywKQ7hIwUIzoofBrQhbcrWI
KS+Nu3E1D4QIGotPm4M/BwwdXaNiPIFlr5yiMhn0wPSMCvkzYKlYJ3VW1JYsaT/B
syhgCzZefAgpBNKHDWiZCTs5JPbb3Uyqry5LeYYuiP2aeC0UA99gqsPZlGQUXFgF
cE+0vgk4UkEhTWbiXIwhqgsf+mf3QS1l0hiGKNUOZPzyP4puyYJdz/0ofJ+n1BCa
+ub/AkkG6ambhdIVlbsSQ06QXpZ1rzEHzPpsSmK+ci/A4vGrA1tOv7u9s7fIU4jI
Im+zm/mhudjBo9O9C5HW8FwzXS1ldrhveC8ljaWqo9ZOyZIdyBn2w7i/RhpMimfi
w8dvYk8kZQN0v77//+8vLvOPH0VMlzKMQziDClJyAn7irhZ+f38lqaSzpKe8/wxS
W6Mp2lyHIWa6Oo9X2D63NpOlKvf6ZQaEhdYxkEPfpkTdbNjANAeNHKP+Eaub18xE
FHPYy9Acod45sxL4PTF2lgnK1EYMusS9dY7dxotg3kefBLCLUDQ=
=Lkp4
-----END PGP SIGNATURE-----

--kvefycufcam53cqp--
