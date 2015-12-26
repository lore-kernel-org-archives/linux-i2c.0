From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: i2c-core: One function call less in acpi_i2c_space_handler()
 after error detection
Date: Sat, 26 Dec 2015 19:41:52 +0100
Message-ID: <20151226184152.GA882@tetsubishi>
References: <201512261449.pmBxYtq3%fengguang.wu@intel.com>
 <567E3CF3.10606@users.sourceforge.net>
 <20151226074859.GA905@tetsubishi>
 <567E553B.5080005@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:40587 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbbLZSl7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 26 Dec 2015 13:41:59 -0500
Content-Disposition: inline
In-Reply-To: <567E553B.5080005@users.sourceforge.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 26, 2015 at 09:52:11AM +0100, SF Markus Elfring wrote:
> >> The kfree() function was called in one case by the
> >> acpi_i2c_space_handler() function during error handling
> >> even if the passed variable "client" contained a null pointer.
> >=20
> > This is OK. kfree() is known to be NULL-tolerant and we rely on it in
> > various places to keep the code simpler.
>=20
> I would appreciate if an unnecessary function call can be avoided here
> so that the affected exception handling can become also a bit more effici=
ent.

Simpler code is easier to maintain. See your patch, you didn't get it
correctly at your first try. Also, this is not a hot path, so I see
it as a micro-optimization also adding complexity. I don't favor that.


--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWft9wAAoJEBQN5MwUoCm2530QAJBh7Kw5ZBOZQ2c8cfXpIF+k
RZAkjB0J9MBi+b0ehXGAXVBVpU6pZdY5LbPhfbHE2+UEy4C1wEz1W72T1i43rr4I
rkj3PxbjuvAOvYv5rrpo8csyrQaVWNRVnLR9NQqxGZvpfSInREqIqSO15qBzwhrg
cgPKX/h4eaKIKxC+VIufmP+aR1IMY9+tgHzNPP2j9kYoGI+BqMaVNESMyl5mb5ne
oYwLfg41TrXkP2swsWEaWbHslv9Y7316GXV0i3tSuxmC03Fl/4NxZj2tWdJuoCEI
kD0fgqCNL6fEmAOvt8vSJhEcZi9enTMa5NRAnv98bnqAGBGSM6fUhF3LAiv/wXMV
vlFdnekjt+sJ/74eRfQs27yD4XCij2ysqNb03+VMCAM1mNx9doOVLln6UM2TD/MV
vIqAuWFDRmC7XUT8lXlYrXpVDB+Q60h85oyvw4Bm+lhSc2mR9F9/sDct2c0nmweg
2l+QgU/Ce2oJjt0sJPQtAYmSXybvuGE/y4Iky34hMF2MFelIe8sgxzOOtu3CmrD0
HA5xhJNbv0iQ8DUAtjLtJuMfMJXp0m+dMabGcLHPsGyO9vliksATASDq9NoIT8U6
RR2H/CTk1OywhwQOtgZIGTmzsI313gZPuYWpJajCZwhY+Gz5TnMAkCOK9AwdicNZ
fcV5xs2BUHCcLlXaSb3z
=bWEF
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
