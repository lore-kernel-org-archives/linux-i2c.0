From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i801: use IS_ENABLED() instead of checking for
 built-in or module
Date: Tue, 26 Jul 2016 08:49:41 +0200
Message-ID: <20160726064941.GC1772@katana>
References: <1469117461-14764-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58525 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753572AbcGZGtq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 26 Jul 2016 02:49:46 -0400
Content-Disposition: inline
In-Reply-To: <1469117461-14764-1-git-send-email-javier@osg.samsung.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2016 at 12:11:01PM -0400, Javier Martinez Canillas wrote:
> The IS_ENABLED() macro checks if a Kconfig symbol has been enabled either
> built-in or as a module, use that macro instead of open coding the same.
>=20
> Using the macro makes the code more readable by helping abstract away some
> of the Kconfig built-in and module enable details.
>=20
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Applied to for-next, thanks!


--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXlwgFAAoJEBQN5MwUoCm2Ic8P/2NLHHAIaGINV/Mit8gPkU00
0ERLf/uNlDn1FrVcGHR9eQ8gHfYa5FOCc2TEFQFvoozDuznFGdMcZ2J/L5Of+SEg
uK+cZQUoXQYMYXcCKqOmIrtt15KaMU+HeKGc7azdDEAYJ0K4PqVmBSOjrekS6pJh
JVP8WtiOOqLArTxI2D4Icdm1eXmrc/XQAwamt64BaKdW23IfOZg+GC0/cbfxNDqA
TTTT47gdTkJx6fdDuNB3GBRL6baKC56dxLnJiesIZ5R0h7/99t90rgLmPFBQQ0L+
P6pTrfFqiCMLHDjktVU9VBePn68cgWRt1kvokAQWQg6ogzUqNz1VgbRqHl/JorU7
gZOPbMEwJxw9so/I4ZjDP/SEeIM6HVzjLMnDNxM1FImnfJ2JEw3nFw7Z5GOHsc0M
OZX0TsnQ+YNKbMriDtebbHv2ZyJmKUJIismrGa6Sl+GZdrG9MubzTL5+kIGIXswM
0QG89DC+o9yNM2hH6WV33ZecrK7/kwoYZAEcpiW0uw7llIVFE4TmhPuaKG8limZX
Tw01mmkh/F4o/S8akLlDsXOmv+Y7mmB8LBgHN4opDSJ+KXfLLB/0gpxUrDfGBUBg
MAL3OC15mmZsWRJCE/5Tv4YeCTMRow+W6fbwLEG/mkJyoM0wiWXyk03KmBYA6Wkn
mEulqVOHZ3uhivVJcnmt
=glpI
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--
