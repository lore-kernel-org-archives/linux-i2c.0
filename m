From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: do not leave semaphore armed when copying
 properties fails
Date: Fri, 10 Mar 2017 00:16:53 +0100
Message-ID: <20170309231653.GB4300@tetsubishi>
References: <20170308184102.29334-1-dmitry.torokhov@gmail.com>
 <20170309144833.3mehuovi3wwqma2m@ninjato>
 <20170309173828.GA20077@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46681 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750781AbdCIXQ5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 9 Mar 2017 18:16:57 -0500
Content-Disposition: inline
In-Reply-To: <20170309173828.GA20077@dtor-ws>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I am perfectly fine with reverting b0c1e95ab44f from for-current,
> however I wonder if we could have an immutable branch off 4.11-rc2 (or

Yes, sure. Please prepare a branch and once I reviewed all patches
touching i2c core, we can (from my side at least) declare it immutable
and I will pull it into i2c. I'll try to review the resources patch this
weekend.


--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYweJkAAoJEBQN5MwUoCm2DOUP/3liQgddwTg2jN/O9xILgXwc
G0pHPtrnJuku5udSK0XJLlZcEW2YSo0HG0MpRIMKR30qqFZ4oe2xeQ+X96oV1IC+
vEeb97ynKZ9opNPHgTx6S6S+PKKK0bkeq1zeIBKDiMpWN2hrg6PsnleCnogZOV+j
ELeYXh6g5XXaAl+Ayq3TdZd9K5vbmlXF4+mHaRhqeR1FKk/+vSlMSJ4PHMcbIKIO
K+RArs+ofEfxbE0B+b89ZPSHdtF2tBWeuIy9CjFoxQF6Wd+zRkrcmwhoBRCOVJvM
nJc/DRwM5NQjm+iBT5+s2gYe+E9fUzWpf2JbSQcuZYNy3pgynb6PUO14o3iBOQqI
eK+PkUDcXkEBRHIOnMFmp0lRp5GhRrji5gy9Xx2xvPfeAgAizssd0D+LCyI8s7B4
KJ9f9sDlXd9aay996LI8H/sdPvTegFV+m620O5ltp9+biZNh/CGYxqV24/J3PHIt
uu4yuiT9iifsdUmuzT06rDhj6A8k6Kr3lZmk6Jw38TPVL+/K+Oesn1c3zI9bbXHt
JsXSwZ/Ld5WCrcaBdj69ZggCb37zLDADlubZFlnVkaYTPHzUVgX40KKcpR9X196m
d6kJUctjdDbltl/IbA7a6Qm8cBEDt3ZL+whJt1KVNWI1CbN/KxPFySBD71kjQHsP
i4Q7zMG0ggm3rl1C2sn6
=TwDK
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
