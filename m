From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] macintosh: therm_windtunnel: fix regression when
 instantiating devices
Date: Fri, 28 Feb 2020 18:00:26 +0100
Message-ID: <20200228170025.GA1130@ninjato>
References: <20200225141229.5424-1-wsa@the-dreams.de>
 <87imjsu8k2.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:59804 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgB1RAb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 28 Feb 2020 12:00:31 -0500
Content-Disposition: inline
In-Reply-To: <87imjsu8k2.fsf@mpe.ellerman.id.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org, debian-powerpc@lists.debian.org, Mathieu Malaterre <malat@debian.org>, Erhard Furtner <erhard_f@mailbox.org>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> I think that would be best, it's more I2C related than powerpc arch
> stuff that I could review.

It is more DT handling than I2C, but I am happy to take this patch.


--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl5ZRyUACgkQFA3kzBSg
KbYafQ//Qh7A67ZsF/34YMOZJS3QdwmEabrYpv7+XymxJ1wCVD+1TB83CCV0jegS
b5Ok+mGt7aFkJTOCoOVr7iuwYljd5pBb0/pngrMnyXtQn7ByUGBKRC3Hi2b3pnws
iAceQXgWuo/fM3z+DCxrs290KYny9TJOHniLiw39YGExA17PZvE5E0Iyr9Cn+BX1
UJ9TPU+T8Rt2Q/b8O9GUIxLBnx5xJyuGye9r2l8m59PzkWYLxFQReKX0TvFQGFDL
QRPmcck6gJrQE8itXEvLnbmMHVQvB6d8YIfNwwWeM1sFQC4yq35qkeBFKMF0NeQb
m84limbwFDokSiHlT3doxyYJ8RosdbmP9xKWsh2dpeDRpKweWqIDI6WlCRWBuaFM
GxYeTsnbIOsTfWOOT5HaXaAY2TREDS24+OzW+vlV+hYfcTnqSHFLxLMWA7rnnc9l
wKjYxCWoZLBA8OStqmLRkTAjUDskiVcWDmnrgYg+oCCI7StpXD0r0uxiyzbbz9Ol
MjJy1SWJWrt8sK4VkzHttrSO83q3T2sktAHvKgecapAK4rupMKJjaF4T4vqJulmP
t2dDeyjrljrQSNBwxi7nLihUnwD2riTEBHULJdjJlurUJqfDZ0Omucw7d3BpTiMP
2UKPN9iHyB2EKMTgdO+cwpUTFhcIyQ8uRFTUGov5EJSzzWcs2j8=
=4G6n
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
