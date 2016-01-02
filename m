From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/3] i2c: rcar: adapt PM usage to multi master case
Date: Sat, 2 Jan 2016 22:15:19 +0100
Message-ID: <20160102211519.GE1589@katana>
References: <1450889794-9509-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TD8GDToEDw0WLGOL"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55452 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751824AbcABVPY (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 2 Jan 2016 16:15:24 -0500
Content-Disposition: inline
In-Reply-To: <1450889794-9509-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>


--TD8GDToEDw0WLGOL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 23, 2015 at 05:56:31PM +0100, Wolfram Sang wrote:
> If we are in a multi-master scenario, we need to block runtime PM so the
> arbitration circuit stays awake.
>=20
> So, we define a new binding and adapt the i2c-rcar driver to have an exam=
ple
> implementation.

Applied to for-next, thanks!


--TD8GDToEDw0WLGOL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWiD3mAAoJEBQN5MwUoCm2EukP/0HDtUfyfVCJa2M6e+42+jYD
6uP42zZwp99PKj6wxeQclxN+uHw7zzFNGzrqKg/ckG7QxQW3ZleRSxKeN34rgXwQ
9XhvuhbDJFp4GdUUHVOm2A+WYkem9TJflPF58zph2D/JIcYw1ASM5HtGFQyjXA+O
uPY6u0xbz9nyhtvQajDnzIZm3WQLMgUqxllo3l056qJN21BkOvRAkf66G0jbBny9
QnJMu/iERKlOmulNAck5eW16lYgtwijY5Rb4dFsB7Xz1CxL0np4mw6qRgGnmI22U
qSp4MIb1VkHJzseg2UjmJ+DvxswEo+sqnQu3V63I//XnV7kl2iBxMzMApMuovDZq
nwShaseJhvNRHCvfid2Ci/dPZGI2LHRjS+/hDMDET5Dkmm2t6CNlcj4u4L0A3R4/
8H9RKNqM/0Vqyk+flwy6Elx4MPp5p/tI/Ov0Lr4ZLA8+ex0lMvsL6CYwSZOS1rZR
8e3Kq3VCSpLBjzpWT8JPoT0dgdSyxWFJZAqfMM5TxM/6fJZR2dhIa2Q3OT/4OwMW
R22aPL+HlQ5B0X2SeqQgBROkS70hyYCzUFvTbTqwScOuuxG/b7LCraDZU66cnHJK
XXFEly5NkoEytBbwtZceLu7738Gna7VIom2rziBceAb+mR2QjV7QKGFEFP9OaLm1
qahnKg0o6J83vH7BBubk
=fRNR
-----END PGP SIGNATURE-----

--TD8GDToEDw0WLGOL--
