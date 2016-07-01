From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 i2c/for-next] i2c: i801: recover from hardware PEC
 errors
Date: Fri, 1 Jul 2016 17:49:19 +0200
Message-ID: <20160701154918.GB1372@tetsubishi>
References: <1432332868-12705-1-git-send-email-ellen@cumulusnetworks.com>
 <20150709165939.GB4744@katana>
 <20160701113028.7a47c236@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:33979 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018AbcGAPti (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 1 Jul 2016 11:49:38 -0400
Content-Disposition: inline
In-Reply-To: <20160701113028.7a47c236@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Ellen Wang <ellen@cumulusnetworks.com>, linux-i2c@vger.kernel.org


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Sorry, this one fell trough the cracks. The patch is good and still
> needed. I have tested it successfully on several systems. Wolfram,
> please apply it.
>=20
> Tested-by: Jean Delvare <jdelvare@suse.de>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>

Thanks, will do. Do you happen to have rebased it to latest
i2c/for-next?


--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXdpD+AAoJEBQN5MwUoCm2T7kP/iPKfZpeDOYvU6QuW+Z2sysv
zNxyQ0gRPzRNBhPgeDwt8XnEkBq3UD2Xib7as0JUlp8CgyI8dWsAMgA/8oovKQ2N
2TwZrgQvlkTmWVGf+gYO9kOaTDItQyVIDYHq8K+Bxma6uGsN7csBgVdCvoUhPdQQ
+brtLiOxNiqIRFdQRcj4CcyQE6UWRx/VNc7JRcghgvxvFsaQahTrOa8O2kseZdox
yydcs4G2iHF9uS8RKCSumhAyIq0q2kzzPVOWbBxUVFj7EXHt758gET5b4UZWMCSO
qoZo4Io/at892jteRnle7hqBDVZ2SAL/k7JQ2COL876PPr9as8TyUd+BA5SVpPsr
wM+bQbVfQaEkXgogjEOKeTAS8eJYZlDGo6v9EEvqBR4eRS3ScKcQTG4jyb/5AwnF
uT2/IHK/1b9uAt40d7Gj2oX3EEgKTwReqv7WMLcwr+73/DLyOBIZV4UERhf9mGLO
YQ5XWjrg/U0GJCj5TNNnOZGmjOioRH9+hPcxj59MDV2zjnAJlkjNyVCd3XQ83obI
jeQdABPnO+8ViiZldurmZtPCle8S1sRAtF1rJgMkLcuLygfdyP7/DQUv6uZ3UE2D
u6n2wbqKa/AEGMw2SRwYMzREzLN1YUZ/2bmp9OdSdVXVw9zWIWrI4bhnlzIaJteo
A53vT8DA6IxLxWnUAjJj
=Bn1n
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
