From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [PATCH v2 1/1] i2c: designware-pcidrv: Add 10bit address feature
 to medfield/merrifield
Date: Thu, 1 Dec 2016 23:39:07 +0100
Message-ID: <20161201223907.GE19261@katana>
References: <1480523655-10461-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jKBxcB1XkHIR0Eqt"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:41752 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750898AbcLAWjJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 1 Dec 2016 17:39:09 -0500
Content-Disposition: inline
In-Reply-To: <1480523655-10461-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org


--jKBxcB1XkHIR0Eqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 30, 2016 at 05:34:15PM +0100, Alexander Stein wrote:
> Both Merrifield TRM and Medfield TRM state:
> "Both 7-bit and 10-bit addressing modes are supported."
>=20
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to for-next, thanks!


--jKBxcB1XkHIR0Eqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYQKaLAAoJEBQN5MwUoCm2Ue4P/iLRAQCQvDlpKxmruxTXFIxJ
z69yRlegYhveAsAde3PoRtAxKYLOJGvvWeAVDOtZDnuWw2XuYEtiXDkzTK2H2UOm
O+bsfyrlamyAVuU5uS2k8gEA+ojnbqsQeuDEj3cLngurC9YCmH0mBMFKLKsb9Fov
fPpEEzICY0n8uKGbqaoF4odt/RbTbO7j73iEh7FgUwDALsmq5XL2uqkgl7pBwkb1
5h74yO43v5koh0BBAFLWA0k9KJ+L/NsZAv2LdpU5yMDKEh3fDMbozaaHibxaUH88
+55ZRDnqZTprN3z/GkSszx0eYTwF0P+QJkl4U/iU/NClZZ5IGPGw/eYydgxyvEHR
1FcUJghm/5LHgmt1zTlat9XpwIyxaUb7wxDyAGaBn34mslRtnb+wAqueEyGi/+hT
bXCnRJ7aVuwPoOXPFtOT6Hm09Xk7ebNlLIN46UI7BcPPQR3WuTTKlnHPn3nATnaj
WJnde5n3mDrzVQWt0YDIO8pAMoELcj6M0azIUh4M4Nj9Oy3BC/PDUSd3rhMLauI5
4qNRNoH4ZkGZowBC+4mB4fmIYSASA6T6NIhUsbEAv9w8VCbBqOF5W8V7gNB1o9Il
Wxh7Mc9AZlkYYkpYXwSZsVmNLFUrN2OCxfq3zFINg0ATEEBHLm18dINWiVCDMDfc
7kClkFma6/araYDBsFJ4
=0qIz
-----END PGP SIGNATURE-----

--jKBxcB1XkHIR0Eqt--
