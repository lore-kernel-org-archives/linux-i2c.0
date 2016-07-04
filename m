From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: New location for i2c-tools.git
Date: Mon, 4 Jul 2016 23:38:27 +0900
Message-ID: <20160704143826.GB1410@tetsubishi>
References: <20160619195641.GD26875@pengutronix.de>
 <20160621111255.1a27363e@endymion>
 <20160622185252.5ecfdf1d@endymion>
 <20160623073249.GM26875@pengutronix.de>
 <CA+TH9VkztGak0FugD0zLgOigBope5pT4FheQJkqhvg3xrnUxcw@mail.gmail.com>
 <20160623115314.1e20f84f@endymion>
 <CA+TH9VkXPFBgAiLHwx+_B96RRYMmtG-Kc_5qN-0Ps6FceBrVhg@mail.gmail.com>
 <20160623194016.6d89dc01@endymion>
 <20160623185000.GA1611@katana>
 <20160704103147.51185bdf@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:44755 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739AbcGDOih (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 4 Jul 2016 10:38:37 -0400
Content-Disposition: inline
In-Reply-To: <20160704103147.51185bdf@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-i2c@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> The problem is for scripts, like decode-dimms (and sensors-detect, for
> the lm-sensors part.) We can't "#include <version.h>" from these, and

Well, version.h only changes per release, or? So, when preparing a
release, the release script could parse version.h and modify the
scripts.

> Also including the date turned out to be very convenient to figure out
> quickly if a user report was from a recent enough version of the script
> (particularly useful for sensors-detect, of which the latest snapshot
> was available for direct download and in-place execution.)

This one is more tricky, agreed.


--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXenTiAAoJEBQN5MwUoCm2IHgP/21I72ZX3jvJSNC0TY+EbFkJ
6fUls6lrvCLtvwGlx20Yh+mqBNGfhOVFXMqnV8Ssux7qmpvssauOSQcI1OjNC1DM
AGqmrOUd++LpNW6eZnefeAFRopZnepA0nqgbiumiaJU01c1T2YX0Tnk9HJWbWFw6
NHVLO+ZvF46tCTXXZaAcf6Jg9NiqfOT33qEW8uaT1KqLzfLXN566PbmYVvUvWccp
ZXGkRAoFiTtzNxS+GONXNVin0skEpHvtCREx/IQNVRoNd5IYkfHgfQ96TehEehrU
Xh0CAU1n6Lc7pAlMfzsysrmHoxKeehOpbHEx2D+MG+/sThiSpefSNV88QhJAyy6T
0PyNSs63z+DxehODtxcI60al+3BSgj3qj7MIfp4/C8TalamtlcBi3jsHbHVsrQia
HRzvOctDwdlJRZkQiONsSc/i5cvIAhTf+RDQEdcbK+xWannb7rDraDSOwgEHSX44
yP7wnFoj9vzzoS4154FLk2IuObmoQb/nEH/HOxvLw0l8dS1MXBZdBsBl2szmjoc2
6uzQQGeO24aQlcAblxtUjAsRAa8ib3SAIr5sTGrT3IrXSoXbAgwTw4+336SmFw5T
PrqTPpnQSVUMN6qxfgW/8ER4fqQuwGHeKCzq2nDo17SbTrnI3lgSeeVwAR0Hf0P6
8eEyrSpo4H/Lw8pn0nyT
=H9cS
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
