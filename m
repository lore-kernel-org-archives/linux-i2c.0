From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: piix4: Fix SMBus port selection for AMD Family 17h
 chips
Date: Thu, 5 Oct 2017 17:11:15 +0200
Message-ID: <20171005151115.GA6129@tetsubishi>
References: <1500162686-21682-1-git-send-email-linux@roeck-us.net>
 <20170812113357.ijna5riha7uechja@ninjato>
 <20171005163350.54ac3b96@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:39666 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750965AbdJEPLR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 5 Oct 2017 11:11:17 -0400
Content-Disposition: inline
In-Reply-To: <20171005163350.54ac3b96@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Sorry for the delay. Looks all good to me (as I'd expect from Gunter...)
>=20
> Reviewed-by: Jean Delvare <jdelvare@suse.de>

Thanks, Jean!

Guenter: I will queue it to for-current, when I am back home. Does it
need a stable tag?

Regards,

   Wolfram


--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZ1kuTAAoJEBQN5MwUoCm272AP/jZB1Vh/+gZEbphKudKQMN5j
ci5hgbNn/RgKvxTDekWxTEKu0ZdknCucMWbaLNIyAkD4PRBM0DQ8d0dvX1pF/mVh
EkSK8xrvzEQ9oEcEWszFlq4A4sO4Vdr5QL2SNoVyhBI21pPvNcSh9lZViDP5lvAP
X6e4HNz6mBTV/41N4Og9gQcxUej6dlB7WBSHt3e5973B9KYH0nBzNj4FuNwDJg6c
fkoG1UTfUg/tH4b5vonrqUHGM3NwRF8Mzrr4xBJqX62tl4f4kssvGhfWYVZ+f1PT
oBiMU0TfVOyigo7zgXK9Oh+6V01PSbg5cOA6E5GntXptq/nLtoeZDktf25oyBFhg
D4UOvNLJj+EpPOxWUm4ISEMao4W3spxdEsGa/WDvFXqWXDHZdh7low1tFPwdZkBF
DsE5vSf5WN9tx+rmnshKTOO2pZR82p3WijBQUxhisbnV96ku5Qx3UyIvzy8LVP48
leGasj4X8UGO3PQdLyiqwiZ43IKnqtk/97X3BVEsv4BIuOf7wGtQ372A3/O2Hria
bUEfaIeUEGY6rHkOGjKgnh5Ab9GH/9442Q8id346XMADly0wxF5R5PWXfEQBODHs
I/pP+LFEOl7aJdWV+rK2opFzMN3JJHejyxTkoGuAFfhEQUlN2ULDhB+4TEvEesqN
mc/KdrD6s76/kbqyOz5s
=EVGx
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
