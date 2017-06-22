From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/1] i2c: cadance: (bugfix) ctrl/addr reg write order
Date: Thu, 22 Jun 2017 10:35:46 +0200
Message-ID: <20170622083546.33glkhns4hlodrbe@ninjato>
References: <1498095926-51264-1-git-send-email-matthew.weber@rockwellcollins.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sfb5jzrhw375wpge"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:36419 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751116AbdFVIfx (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 22 Jun 2017 04:35:53 -0400
Content-Disposition: inline
In-Reply-To: <1498095926-51264-1-git-send-email-matthew.weber@rockwellcollins.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Matt Weber <matthew.weber@rockwellcollins.com>
Cc: linux-i2c@vger.kernel.org, soren.brinkmann@xilinx.com, John Linn <john.linn@xilinx.com>, Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>


--sfb5jzrhw375wpge
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2017 at 08:45:26PM -0500, Matt Weber wrote:
> The driver was clearing the hold bit in the control register before
> writing to the address register which resulted in a stop condition
> being generated rather than a repeated start.
>=20
> This issue was only observed when a system was running much
> slower than a normal processor would execute.  The IP data sheet
> mentions a ordering of writing to the address register before
> clearing the hold.
>=20
> Signed-off-by: John Linn <john.linn@xilinx.com>
> Signed-off-by: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
> Signed-off-by: Matthew Weber <matthew.weber@rockwellcollins.com>

Looks good. It seems not urgent to me, though. Are you fine with me
scheduling it for 4.13 yet with a stable tag attached? Or do you
consider it 4.12 material? And if you could provide a Fixes: tag that
would be helpful.

Thanks for the patch!


--sfb5jzrhw375wpge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllLgWIACgkQFA3kzBSg
KbY6NA//R2WmgF4vIdapGW1rZLKJLPsy0SNmv0gLKEqVmJNVB729b6uLQMprQMrU
FlJquWYUVrh4Cw6Ojrd1IUXEzqzyAbQrFzKT1ORr4HNqDFqXyo+FztF8pw7f1nv1
JUdHsojTp8Dkocfz8gZaRW0PgYZ7zrtbegNxDeTygSYI/3PlAdtPVZldNzZ8SIoE
kKiUejOuiiop2oYqJe5IYRveFFbaOeysDGcC/kJ/1ia3GaDgEW7eHxa+XjojZMBZ
b/l1IAC9gE0t0pIvaeP2R7g/GoMSadvYae3IGj7T2V3nuGwBDbGjmXCUHmTsR3gH
j1TbNJKwll51J8JVrJdeCVofvIZcjkbPUaQme8J1wZ98J411qL8g26Milw3+i2HS
r32z+/PyD4Y6KiAezqZ7EapGqITUcYSdUHvaVRnNLLvZudhNZjtmNEi69a98rZxZ
DY1/E/lKcb6tRHSXZcGMoJYNs7PsHzh5d5G/QGEyhh53Jqi674RdntXVyFNCZE7U
DZKn4+eRzO9TqgFYjW8WIMg1SqPpPm8yUOIkbtEsqlnyCo2WUwUt3lCtMAYNOoBf
gAisOIDbJBdZYrJb2K2iofq6tNsApWOsvVE62g6/I1mtzWX4x90QyYqz+Mlatn8p
N93nQdk+nesSay/m2w81HWjbdtJF9g3HIxBug9xe1VfAxhJo2ck=
=r33P
-----END PGP SIGNATURE-----

--sfb5jzrhw375wpge--
