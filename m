From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 1/1] i2c: core: replace boolean variable by integer
Date: Tue, 26 Jan 2016 07:04:01 +0100
Message-ID: <20160126060401.GF1533@katana>
References: <1447949516-107966-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1453712144.2521.213.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FeAIMMcddNRN4P4/"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51348 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752080AbcAZGEI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 26 Jan 2016 01:04:08 -0500
Content-Disposition: inline
In-Reply-To: <1453712144.2521.213.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Alexander Sverdlin <alexander.sverdlin@nokia.com>


--FeAIMMcddNRN4P4/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 25, 2016 at 10:55:44AM +0200, Andy Shevchenko wrote:
> On Thu, 2015-11-19 at 18:11 +0200, Andy Shevchenko wrote:
> > There is a warning when compiling i2c-core.c
> > drivers/i2c/i2c-core.c:2561:36: warning: dubious: x | !y
> >=20
> > Replace boolean exdpression by a plain bitwise AND since I2C_M_RD is
> > a bit 0
> > and thus we are on the safe side.
>=20
> Wolfram, any news about this change? Last time I remember you talked
> about your series which makes this change obsolete.

-EBUSY :/

I hope to tackle it on the train to FOSDEM later this week...


--FeAIMMcddNRN4P4/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWpwxRAAoJEBQN5MwUoCm2RpMP/iEN8e5HvdDe70MZ6vX9+k5g
bXBSJEOB54OYnKNOpE9+KgfImBA718Zld9NiTinlFEMHcT1fCn6+u2HfvnFBuDyR
p0KYp1io3hsfLtF6XH86liclZJaTqa8V5OsauuOnG+U0aiLaPI3ZwLWL3EeglhFj
oOvQ4yCzBWXJXJxvM3QYcMai/S4dl9DAgYG7dvs7sSYC48GiDHdI5tlaxdrQdt9f
zdIQDPrijK8EgH0mM01xCMD1jCF7LqLMM9+3gUvMnHsuz9oPru2PjifVw8pR9aIq
TvnSQmzr3yvWhX/76RAKL6R4mJjNL9uVZvkYZAvXO6zvS3VuzeuRmsTZp7NnQcDi
Jo+eDVvTuPcJvrW/7Gq8AIT17bJ6PbKMKr1Y5BBxJExcoBqmQXBhLmB7SXcLBjkX
XbUKRVLB0lu3GqMQhU6HpOeVv8ddNPCb8++Sk0XuNSbCJ3fEb9LrSTgZVQ5jRmke
uJP4ejoPriMaLlarGNEk1+yYm14Cqi0zdqDh6cFw4eTUF4dxbzDRQaLee+G6gWuU
/PcHk+Hp7Kfxc2N5FpmFDvc7w28bgY5rYcNQItco5ATVmemECSIhzZTQsqKoMhCD
1u9Ul4iQlr0+gO0ZGGrS6izX6hJOEhmu0ibKfAtH+2ZgmIvwCw2WbOCw+4gsnMtS
Sp/77nnDChMNdduwMgbg
=k21s
-----END PGP SIGNATURE-----

--FeAIMMcddNRN4P4/--
