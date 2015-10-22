From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: Disable runtime PM in case
 i2c_dw_probe() fails
Date: Thu, 22 Oct 2015 14:36:57 +0200
Message-ID: <20151022123657.GA1517@katana>
References: <1445437306-9268-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58378 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756864AbbJVMiL (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 22 Oct 2015 08:38:11 -0400
Content-Disposition: inline
In-Reply-To: <1445437306-9268-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2015 at 05:21:46PM +0300, Jarkko Nikula wrote:
> Call to pm_runtime_disable() got dropped while handling the merge conflict
> between commit 36d48fb5766a ("i2c: designware-platdrv: enable RuntimePM
> before registering to the core") and commit d80d134182ba ("i2c: designwar=
e:
> Move common probe code into i2c_dw_probe()").
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Applied to for-next, thanks!


--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKNhpAAoJEBQN5MwUoCm23ksP/1pImwdw1kj1Nau7iX7TzWef
JhJKih/GlYYvkmX0WntAuShNAAqMdTK2q0gL8vVHMPSzoxgodVLeJOMuP/f5vt7E
IExuliWqo2Do6bL7JndrqeQEZ/iRUyBjhEjnjKp6SfXSOp4jJO1Ny28shbwajiWK
eAhzCsrcB5q0aalCFfeagcFuSk58reXiiRVL4mkHOQdkbB0zaeEzATZ5/0D5gt1x
IGbDkVeCcFIdgbrmRVySXUE0huQskPbGrq/V0Nyuh3c4b/cdmWW5mutDCcD+OylJ
6tID24qdFWnoAngDcazAVfro7rk7jpbp4fAvXDR/vxt6lNlxI9ICUaApvc+P+d8o
zu7QnkSVIqxLjaxxb/f8hnEtudyFjAhq+WQAHfJic0+53sa1MvsS3G7Wi/AOehCG
PfpTCuWRi7O9BFV4RWePiCNESKNq/rtjrYCTjcQ7zQGipqljCGiL1Etltzz5/V12
fpAbZxqCL6tmmcx9NLFeJlcDh816zrqxb3ziOC6FLuOemanii9bkNfRurHi1ELdz
qUKutIRbe5AcSsxGVhcfm1KgSmRay2Up404KlONbMFYhJF2HgFbt4ddaBdATCZyQ
uC2DbdRQIN/fBxNPOpZk8ANt/RqnQptOXbyv/gdR2zp8Y+ZPNl4TOP9HnrAep/WW
GnRmuEwA/hVyAUAESG2E
=sOSt
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
