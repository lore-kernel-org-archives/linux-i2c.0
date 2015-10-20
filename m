From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/6] i2c: ismt: PCI core handles power state for us
Date: Tue, 20 Oct 2015 16:42:51 +0200
Message-ID: <20151020144251.GC5379@katana>
References: <1442413443-123579-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1442413443-123579-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZmUaFz6apKcXQszQ"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43173 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991AbbJTOmz (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 20 Oct 2015 10:42:55 -0400
Content-Disposition: inline
In-Reply-To: <1442413443-123579-2-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>, Mika Westerberg <mika.westerberg@linux.intel.com>


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2015 at 05:23:59PM +0300, Andy Shevchenko wrote:
> There is no need to repeat the work that is already done in the PCI driver
> core. Remove suspend and resume callbacks.
>=20
> Note that there is no more calls performed to enable or disable a PCI
> device during suspend-resume cycle. Nowadays they seems to be
> superflous. Someone can read more in [1].
>=20
> [1] https://www.kernel.org/doc/ols/2009/ols2009-pages-319-330.pdf
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Checkpatch said:

WARNING: 'superflous' may be misspelled - perhaps 'superfluous'?
#6:=20
superflous. Someone can read more in [1].

total: 0 errors, 1 warnings, 0 checks, 44 lines checked

Fixed it here.


--ZmUaFz6apKcXQszQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWJlLrAAoJEBQN5MwUoCm20vsQAI+l1u9QyX5Kame3vSrkQPiz
3UMIGPvqZ/2qt+MAtl8Lp+oryuZMxmDRSnTq7+jd/13MGq4Hm64UNl3uRttYxKod
NIgfDrIAT8RvhdxtBQHGrStGv6T1An6aLlqbWQtIR/bkR6cof0OqV8fCuNs6XNQv
0P6gDWWGcxWtHh4SCLtzbm60EsC9IhAday5LKAu0aJLkkgjy1exYDxN77Pcdlbk1
ntsc4ICNL8TCMnQE4WGaJyELqaM00lu4UD9zR2ZrVAYiS8gI7e7DDcEv8iN1DQDN
T4aEV0LpQGExOe/BsOnS6o8MgJLehXyqVJwPNUmeyf0Vd/edpi1iuNXD3SLEn6Om
O6h+1LKHEdERoBexIf0k5PdBalHUNu4VNTKW7fz63K6NTCKCazszo7cjB2Rpku4u
C/ZkoKYSBDoo+u1ne1iERZP3E363AsjebCAf73cXJVQk1KakSREiO//EgDKTim8U
7hUrkQsUZ5GGMsHMELH1W0Luf9kOjI1VdLaimW7V9GGSKL3b7u4otJ+daY2+kocT
yuyo9zuyGxP6AfrflyZWo2hmVCWhodhnPe4w009RKFcpwc0yzfHp8FLZvcbsV7oH
D5/Pd8JggtCuPls+tlsqcfzoAD2mQgR3lRiGzsDfLVvbogzhmHV7/tkQ/Xj1LwsP
hqJxzxt80vRpbI5ntt4g
=JdbL
-----END PGP SIGNATURE-----

--ZmUaFz6apKcXQszQ--
