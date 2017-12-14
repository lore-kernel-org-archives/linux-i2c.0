From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c: Add support for NXP PCA984x family.
Date: Thu, 14 Dec 2017 01:30:16 +0100
Message-ID: <20171214003016.rghfmyeowzjqssum@katana>
References: <8a2f6d04-f156-a877-9e82-3f760488c932@enneenne.com>
 <20171211165811.5806-1-adrian.fiergolski@cern.ch>
 <f3883936-d621-cc48-444b-db08470d256f@axentia.se>
 <2acdb52a-c669-631d-2ef2-ab0da2899e00@cern.ch>
 <cb42475b-eacb-d059-2ee5-f2a57cf29159@axentia.se>
 <c7842a62-980d-b220-aa42-51cbb5398c5b@cern.ch>
 <5cbfd97a-146b-8851-c63a-f2f60da33f5b@axentia.se>
 <20171212220537.o4njv4lqp2ppmu7x@ninjato>
 <854cba57-5640-5be1-dec2-fc7b8b7ea281@cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f6jlqjvnv3lvpsxv"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:51828 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751600AbdLNAg7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 13 Dec 2017 19:36:59 -0500
Content-Disposition: inline
In-Reply-To: <854cba57-5640-5be1-dec2-fc7b8b7ea281@cern.ch>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Adrian Fiergolski <Adrian.Fiergolski@cern.ch>
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org


--f6jlqjvnv3lvpsxv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Do you have in mind sth like i2c_smbus_write_i2c_device_device_id function ?

SMBus? It's I2C. And write? I'd call it:

u32 i2c_get_device_id(struct client* client)

Instead of returning an u32, we could return a struct where the bits are
already decoded, too.


--f6jlqjvnv3lvpsxv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloxxhMACgkQFA3kzBSg
KbZa2A/8CLxhr9lNHM93bFm1IQT0m1C1X571uXlDt/XzmDwXp5ERXPr/83ePo7bC
J1LU4qusnYOPbyjGml+LcGJc3BGvm2XcAWRQg2p2x63IXAyYLZXP05mzdo9/ZbgW
PDLabgpHFDPEeK21HbPM+EdlrflBPe55XvKHYKY243/3pOX8awfS0Ohrvfx0/e+4
21wqq2Xw0Mdncd78LZW+OUqy/bLWGzVFh0CDpXPJw0bvTndCUB0+AyBeWVCIqw13
JqYnLnswmyAaFeVPGdO8gteScxyDT3jQxy8YshiM/BQU8I6LCQln3bryOZvECgl2
pPD+6j7K6D4AsWxS/ytLKtzN+n0GaWteKqMc2djUK/OP5FZ6NjXbK9vSeUbnhBCK
7EPgYX57SVSnTRGkYssx3HN+o4dvJnyBwx2m6OjfYjkWjg3GG/LCVi8ySCdKhsqH
7sK7r5kngOrZuw1e/utVbyEmFsdqV1/O9Tr1S0ZK4Yv3V4jQzFGj/ZEbSFaiYuAZ
+MvICT5e6V6CTvBW56Sl2neW/OPjPl2/8RR0ARbcu5nQi6PJpBjkdEd8JczHiqF6
bvNhhgqTsSo3aA+47RujP2Ye3UL/2YSMUewQ8uW9VONNzVAlE5HgLa//ySDEUiUR
TBXh3EphtsqMexTHGQKquvVhb20TPhEEjY14+J3+EKci2YxdcAU=
=I7sV
-----END PGP SIGNATURE-----

--f6jlqjvnv3lvpsxv--
