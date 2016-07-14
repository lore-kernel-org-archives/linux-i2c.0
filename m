From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND][PATCH 1/2] i2c: versatile: Allow compile test build
Date: Thu, 14 Jul 2016 21:23:34 +0900
Message-ID: <20160714122333.GB4149@tetsubishi>
References: <1468042283.21863.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:60892 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbcGNMXo (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 14 Jul 2016 08:23:44 -0400
Content-Disposition: inline
In-Reply-To: <1468042283.21863.2.camel@ingics.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Pawel Moll <pawel.moll@arm.com>, linux-i2c@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 09, 2016 at 01:31:23PM +0800, Axel Lin wrote:
> There is no build dependency for this driver, so enable COMPILE_TEST to g=
et
> better build coverage.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Applied to for-next, thanks!


--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXh4RFAAoJEBQN5MwUoCm294MQAJR7cAC81Y53LN/zNNC/9qCb
JfJgjx2D7JvRM9W4SZ1RiNgfF66UXdfVlIWhWMTWJN57cVRjAz9G+Nc6GURXQGoz
z0yNXH7rc1MKGce3jK4Odmj5EsWwlvv6/PO9DWiHr8gHNSYdHvp7UEk09zgRf4rl
aCvtJzljmblNqdPXdgNc8xgJ0qFJV/C88vYNRJeVcSr4mJIdLcgZQQkRmF6doavR
Ft+JUZ/YHmFVmRu+K3DsGlw0VXsJwtL9uIUdOZ2PNjX1K+PWZcNPao2hIlF7E7N+
Rt+IM1QQtpq2oeqKi9ZsIEmVODbMgYNM57TuIS1m8C0fvMZIoGv+0+wBuVNxfIvj
Ap22Ah/xm13Fa/bP6ffk1whuBlndHLv9eI9lhaz8IBZUpPpSwcm4x9PvE1y5HVce
ncm7FBi5ZkKmi5B0cCmhnsg6QTSCAJ0oiJ7dwkiXbnRrVyGLbLy9miHplGv3Qwiz
lkElYQZwECtgR/KvYDdT1d4nK1JU/Zj0TsBo3xIpSVm/2MTyn2l8XRmLasv5FsTb
RU7/ORWpo4TReIadRZLrzVUsWoVOuYc+iOXkHHgoCY01NLizcdDK5U60Gka5jP7f
apxCIffl7F99jeyBtyE0zYs6Yo2vS+aW6x8v0Z4z94s619r2+Ufv5yV8dSdEtGl0
JcZKMYXmh+VM0z9qWEwS
=t2Sh
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
