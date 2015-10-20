From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [REPOST PATCH v2] i2c-ocores: support big-endian register layout
Date: Tue, 20 Oct 2015 17:48:09 +0200
Message-ID: <20151020154809.GL5379@katana>
References: <1444175111-9529-1-git-send-email-jcmvbkbc@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ucfHZChuBC0NsER/"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43569 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751701AbbJTPsM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 20 Oct 2015 11:48:12 -0400
Content-Disposition: inline
In-Reply-To: <1444175111-9529-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Korsgaard <peter@korsgaard.com>


--ucfHZChuBC0NsER/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 07, 2015 at 02:45:11AM +0300, Max Filippov wrote:
> This allows using OpenCores I2C controller attached to its host in
> native-endian mode with bi-endian CPUs. Example of such system is Xtensa
> XTFPGA platform.
>=20
> Acked-by: Peter Korsgaard <peter@korsgaard.com>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

Applied to for-next, thanks!


--ucfHZChuBC0NsER/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWJmI5AAoJEBQN5MwUoCm2ksgP/3j6G9Zh22rzkJybUVnclwj7
rd4aMVxugGObG30/wnD/bDYPlSG1jP13UgsVkGJbOOcGJL/NGAketOxv7YCTFIu5
UoCOVCUnLDtrRSiYs3Nv88S0RvgPjTQ9DkjK5vmrbLTGdufrsoTny3aSfkJu+0H2
QhFyJ05Sa554ISjH0mUBouCEEb0tOPsmNnVz6P6K+eiBqOfnSGQsavYkE8GdKl3e
Zve3dlVaZJxZnzbgbb5aVaMuKEjLLKyHuYi1+LgTdOXEzRd+xpTVjUChTzfUne4v
6uUQFtywN/MEYfH6B1IvKIPEfMKs8/k0V74bMPUpNj/HPYn9BnQKKq8jMRLYu6Kf
YsGQ3bldRgTggyhoWBAGAjjHqHPsRLORoTTMu91Pwu1RTIpU0S+ACqfPTlMp7sAN
XS3k/pNYdpq+ak22hJeC3tboQfS3we2ANARil/33IArv7fUlh7q6SoR8NQuFCSuc
qNmhhtMditq2COv8DtdBWxMxxpk8BRoi2PeN8NCB5RUEIWIExYB6mjoJsVSW7Zsl
kJJoqHmXt1rXw04PXtY3dMyDyeeKwXGq+YoAnVIiLnX2ETrtLrVUC5crmPYfNAqv
GUdukSUEPdNorg3+mGsmeN++OjvJLE1F64RX00njxho+hTIm4xcCyADnqqvBP9cu
RW3w92MfM6L1fqrUfw3p
=3ipU
-----END PGP SIGNATURE-----

--ucfHZChuBC0NsER/--
