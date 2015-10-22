From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: Fix build error when !CONFIG_PM_SLEEP
Date: Thu, 22 Oct 2015 14:38:17 +0200
Message-ID: <20151022123817.GB1517@katana>
References: <1445411357-934-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58381 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756864AbbJVMiV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 22 Oct 2015 08:38:21 -0400
Content-Disposition: inline
In-Reply-To: <1445411357-934-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2015 at 10:09:17AM +0300, Jarkko Nikula wrote:
> Commit 6ad6fde3970c ("i2c: designware: Rename platform driver probe and PM
> functions") introduced "'dw_i2c_plat_prepare' undeclared here" and
> "'dw_i2c_plat_complete' undeclared here" build errors when CONFIG_PM_SLEEP
> is not set.
>=20
> Fix this by renaming NULL defined dw_i2c_prepare and dw_i2c_complete PM
> hooks to dw_i2c_plat_prepare and dw_i2c_plat_complete since this was
> obviously missing from the commit.
>=20
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Applied to for-next, thanks!


--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKNi5AAoJEBQN5MwUoCm2c8AQAJTfZVfYTXMEZkvFyHwDVd/0
SFPi64+b0m2/rPAhtF9o1AtHPjMj2yzumGvZ+5ZszGtphKcmgpRF8UyfAiFizrqH
YRblk3JKyWlAYQys3cDCJsK26mcgn/7C+/j2p8dOTQS/9/8DTNx4yKpipOD11uMd
7nDTFuP+JNhmDyUoBlQXGWLLIVzEfMYidjD/rahoRDbamjlG7edjuz3RxpsgbsJS
NyrlZ4rNm9nD2m98eDgCYuiuOW3KOw/wwTiPeSXwR5o/6EtpFmNZRC08f4VIUVFJ
xPOlP2oE8DIuCQiwFy+Yhfy6cyBZ8kvb/fKSigbebFR8lWf30VAEFNehcFFB2AZF
GjT2yTkPGLJ2BBsKZ7dOvZ77HV/WumMXEHoJZ8uUKKTSqZlSj+cTrkjX2jCV08yz
cZaFEmz7isoHxJNsgS8ZD04WFE/qy37n7HYOb1QHTTfrzjhT3FwIy1Yd/0ByQid9
9iep68T7XTAWAuTz6lm4TQu4/AJ1LKE3HgXaFiF9ZK7pvkYw81VAWbdCznEJ0HPc
Wg2BWC3cRVCx3zFK4TXGt7Og9tRt+2j5/kPIVU1UvSyyVLMDroMpfdE061XHSVRz
zC6g8/Sqk0WJN++1FW5OO0201MP91+s/F0PT7aPC9S6sLdsoMsv12PagvN8V1xcv
7WnrTP2aNTVr3XkJ+WX3
=0af9
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
