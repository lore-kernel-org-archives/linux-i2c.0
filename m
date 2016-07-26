From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] Documentation: i2c: slave: give proper example for
 pm usage
Date: Tue, 26 Jul 2016 08:44:20 +0200
Message-ID: <20160726064420.GB1772@katana>
References: <1469304412-2652-1-git-send-email-wsa@the-dreams.de>
 <1469304412-2652-2-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58506 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752923AbcGZGoY (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 26 Jul 2016 02:44:24 -0400
Received: from dslb-188-103-102-175.188.103.pools.vodafone-ip.de ([188.103.102.175]:53134 helo=katana)
	by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <wsa@the-dreams.de>)
	id 1bRw6I-0005R9-2L
	for linux-i2c@vger.kernel.org; Tue, 26 Jul 2016 08:44:22 +0200
Content-Disposition: inline
In-Reply-To: <1469304412-2652-2-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 23, 2016 at 10:06:52PM +0200, Wolfram Sang wrote:
> pm_runtime_forbid was the wrong knob, this is the better one.
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied to for-next, thanks!


--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXlwbEAAoJEBQN5MwUoCm2exUQAKNzbYAFaKwrCipnk3LeroWD
JB5QoK+BTAgHTMCsjffjF2KLU4a/9MC4HK1UP2oWz3lDxsnH/64OpxRSBrBKFv9g
8wr6LigPEdhccyl4RUqAb9Ij8TqC6x0tbGGJb74ID42xPw06UEq9Wm7vuLzTpSLj
A3HbBuNTNQfjYX8Hogy+MSgetrTPDTifMrYUaAGPjI4+gUBiPY3scLGM2K7S9W8C
UG7+c+x2FxKjY5LKqruee0adEgVUwSQGBH2JWXJ8eEzZe68AHJH1cCxHiZhlgffH
c2wC0mYdfaVOtW0+H+r6ii7Ij4eQfZtBqttEKakJH1vJSqOFPR6ziDf9Ogj0YgdE
LhF6wu/Tg+PBL6zq368ncKvM6mbPfcLloekIrRWrHjlVjYx9IKiFZ7WNuhjYdnvi
WVgT9P4xtHR3feOlbTtJxhOq5B4gDEscKHdYS8SnXS5cmGvZtq/9HTd0GIOM4FMM
VOKuZAWShotzFnrVdxo0bgz17MNOvfc580Nxhks5CeqYod2glgZEV99sqhYwRUTu
W58LvPQVXrrsU2YxW6zZJS1Gto6M7lKnrVv7/OrLSXFdzapEdsHuT47v99H7CuUO
4EPs7VJRTBbpbMWW6E4AyYJfmLhmX4PElDGxl0MHeBdpVwozRY6C2xdv7pIEVa0N
kgTo7oLk4VgD1F9dsYQV
=unF8
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
