From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH-v5 RESEND 2/5] i2c: pxa: enable/disable i2c module across
 msg xfer
Date: Sun, 25 Oct 2015 09:21:53 +0100
Message-ID: <20151025082152.GA2159@katana>
References: <1440395978-9065-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1440395978-9065-3-git-send-email-vaibhav.hiremath@linaro.org>
 <20150911185312.GA1516@katana>
 <55F655FC.8070308@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:44678 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbbJYIWH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 25 Oct 2015 04:22:07 -0400
Content-Disposition: inline
In-Reply-To: <55F655FC.8070308@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, robert.jarzmik@free.fr, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Yi Zhang <yizhang@marvell.com>


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >>Enable i2c module/unit before transmission and disable when it
> >>finishes.
>=20
> >Can't you use Runtime PM for that?
> >
>=20
> I haven't tried it though, I can give a try and check.

It should work. Other I2C drivers are doing exactly that.


--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWLJEgAAoJEBQN5MwUoCm2xzQP/3kuJFMjCz2ZDBCWmyLMNEca
5nSgm+4n1DDpxTul9evge93aBkFo//mzMXJNjAj9bdFMsPc91wXxMsvktqEMPX0Y
uPw+Y4njbxEvOg8QN+jINGrlbZUulRblxQ/ttdv5OI2mK4oN1KuVZzcB/nk9Illc
02bg3e7KSYUXv/LMgmKzdORPR5NsgQaOKlssIc5iRxNDlaHTru0EoTY08i/kAmzT
AZ7HlwJDGwWmoL1ifLuRYzvhRFXfBl7QQSVdPdMoL0If+6ungBlX7lNrpxXstEJh
8aALsHJjTDxEiVkANTrSw28CGRRD6fkbgH3UILiqU6unoOA5A33YbBQzwJdNg6h6
f4mxu4VIvZw/r37Mwppo7FQawEXTCCymUKt7ekNre2MV1bjYW0umdL64G96Tzsej
ZLwSIRcf6IJQmz96Uz+fA/exiyUh8HSr+0i/V9dPsYb4hAVrNKO9J4/LdUS7D1GU
d9gAE3T4Azk4PS0LTH4IARkpfX9Tet39m86fJoycnCI0ghpB4S/dYo3ked5Xu/79
S4IyaEsXyRPEAaOlGDcGyhSKEwAEEEeeH9qlELJZCz+yRM7kGBNtxaOaDNFPVxKJ
sdzZlVFXR+ZL53/ieMm7xs7+wETRxzNT8YCtn0utBTA0jfXKPCrydP7esLQNj4h1
RrB6banOtcDQzO4DqXpJ
=sKAD
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
