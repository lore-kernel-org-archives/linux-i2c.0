From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/1] i2c: dln2: Pass forward ACPI companion
Date: Sun, 24 Apr 2016 22:30:54 +0200
Message-ID: <20160424203054.GA4317@katana>
References: <1458845956-30991-1-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:40825 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170AbcDXUbB (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 24 Apr 2016 16:31:01 -0400
Content-Disposition: inline
In-Reply-To: <1458845956-30991-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Octavian Purdila <octavian.purdila@intel.com>, Laurentiu Palcu <laurentiu.palcu@intel.com>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 24, 2016 at 08:59:16PM +0200, Irina Tirdea wrote:
> Share the ACPI companion for the platform device with the
> i2c adapter, so that the adapter has access to the properties
> defined in ACPI tables.
>=20
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>

Applied to for-next, thanks!


--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXHSz+AAoJEBQN5MwUoCm27agP/0OVVV66cZkoWXO8d8uhi6IT
W7oa4tttkpk0dE7Y0PkVuLV1zwt+GCpQ1eePPzm0vfY+GfD0hqd8QCvD4Su4smBr
KRsy+NX/0aZnntyZcAESt580z/+cudgxXU64HzBExMNHXc19kiSTOo2N1bWPqoia
k9XQ+/MN8JEDJkyjUH8fsGCwi6R62l+7dR/nN74BJmpydq5MAFxrmrrWsa63NKdS
71iXzY8fKGLETccquRyTDjRoyWM+KTI7w+ojo9e5uBWyxfxbhBmMdRfFDjfsQI3l
XaDjJKCV/z0iP9nkIG+QmSEupQ0+TaHLecBXyKZghrJ/B2O0k+ayYGST+/bsfOwc
CAbePYu8R9WoWnMD2nYiOYQOqhHyZMQj3Udu5F79Bi7njSKe8RUpf1Yl03IAWRMp
3CXPOWoM3qK7HmhEk02lWjR7mMbY3cSYR7Qq4iU23nukdGyKMICe7y/3IfxbM1d7
B79IzI0G3EDmoFwFVnhS8vXzxXoZ9ofNg2njBtb2fu9WZ80T4/LTR9lEIGlHp73D
kf8mKuj05aOb92wnXtkOVeyQO5tvJZr0mCu47467jQebD7CThWOtAxsQ7nzEL3jI
DrlSy9krcNOZWAR9SPFs5dLConbMFKlGfj9o4ojBo3kbFbVBbk08zs34z3B0EJz7
hJogoJr83YA6TgpJSQVe
=j5IL
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
