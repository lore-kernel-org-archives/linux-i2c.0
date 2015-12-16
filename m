From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 2/2] i2c: xlr: add interrupt support for Sigma Designs
 chips
Date: Wed, 16 Dec 2015 11:43:34 +0100
Message-ID: <20151216104334.GD1523@katana>
References: <1450221306-5289-1-git-send-email-mans@mansr.com>
 <1450221306-5289-2-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46218 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965528AbbLPKnh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 16 Dec 2015 05:43:37 -0500
Content-Disposition: inline
In-Reply-To: <1450221306-5289-2-git-send-email-mans@mansr.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 15, 2015 at 11:15:06PM +0000, Mans Rullgard wrote:
> The Sigma Designs variant of this controller has the ability to generate
> interrupts.  This is controlled using two additional registers, oddly
> enough overlapping with the defined but unused HDSTATIM.
>=20
> This patch adds support for using this feature instead of busy-looping
> if an IRQ is specified.
>=20
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Applied to for-next, thanks!


--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWcUBWAAoJEBQN5MwUoCm23coQAJuqsd+QVXC4fapuyDqJD2qa
z5jNIoiiK/ni4oiw6O2y1vC1wcrvzi+l3q+2+6fRDl3n/eOlUEyY7UojEXFOHGoG
SNUsEem8Z52635J16KFlL/1mRT3GGlECbRzCt+oyigQPUBHLKzkN4y/PHfLjVLnl
Qosi19A3E0Llx1clCmhReE+vJQHh2nNsFYgM2H133knxDTTMb/vjqds3s8vwnwek
bJko0a3ihv/iR0h030pyAaOU9yxd6eN+lbEYr2XSLifYi9RaHBOw5qInc7nGSO0E
RHa8n1XRipkIvXoaCB61fD3wTiqPnHUxc17aVjE8EfA8rEL8u6kG1aIdFX8Kow1M
icsQlw3ROIUZ831Uox8CNjZuYGc51+vKGEtpCS5PS2o23Lrrq3hqnssdcY7IQ8+v
G0y1YapIWGyud20wIXJuz6Q4IxFo+NdmumLIZR20GIU4ZSEiplHFUQBt9oil6dXy
PRk4MJeztzfHCDTlppywwDu5TNLH71wx6uwrygKoeScBDTg5aPj9CL/8Ny5gFCWC
Tnz1+t1tyCSE+db2CFVTZjHQM0UmZ4bUPugWfBwP/jIfhfCHg0SBhsMdSUsp3epK
vR6wsp4relzfz3AnnTMuiWTdhoCOZS5iXf8QCYQ/K9q0L0klaKE0ArDoSwe4mWzP
TtMkdiuN/Q8wtFIQTYUj
=4mlQ
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--
