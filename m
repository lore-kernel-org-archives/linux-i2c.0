From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c: Add support for NXP PCA984x family.
Date: Tue, 12 Dec 2017 23:05:38 +0100
Message-ID: <20171212220537.o4njv4lqp2ppmu7x@ninjato>
References: <8a2f6d04-f156-a877-9e82-3f760488c932@enneenne.com>
 <20171211165811.5806-1-adrian.fiergolski@cern.ch>
 <f3883936-d621-cc48-444b-db08470d256f@axentia.se>
 <2acdb52a-c669-631d-2ef2-ab0da2899e00@cern.ch>
 <cb42475b-eacb-d059-2ee5-f2a57cf29159@axentia.se>
 <c7842a62-980d-b220-aa42-51cbb5398c5b@cern.ch>
 <5cbfd97a-146b-8851-c63a-f2f60da33f5b@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c7oraxwegfvpbzcf"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:45957 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752320AbdLLWFj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 12 Dec 2017 17:05:39 -0500
Content-Disposition: inline
In-Reply-To: <5cbfd97a-146b-8851-c63a-f2f60da33f5b@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Adrian Fiergolski <Adrian.Fiergolski@cern.ch>, linux-i2c@vger.kernel.org


--c7oraxwegfvpbzcf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Wolfram, do you have an opinion on the device id check using the
> 0x7c address?

I always thought there should be some core support for that feature, but
IIRC I never knew of any device which had this implemented. But since it
is described in the I2C Specification, it should be in core IMO.


--c7oraxwegfvpbzcf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlowUrEACgkQFA3kzBSg
KbZRHhAAgmVqqq4oJjEnKCXFLaSDYJjwsVgWmxl3rNiOcDmjESdyDQPpYG34lpJy
GFye/+DEFmLMm01riwbiKSrB/f7kFss1muxOLt/40IVDGd7O8k1G5EvE61waL13Y
aJFPVQ9f/rq185MOrdTpRdTH8W/sUhZqYyM/JlsasRfb0h2kz5Jfng3LhXVTPEzp
0t7r0rlxYTO63VBuaeVOJFOosXceYE2ODNg/REdodB6Geg8gD4tCvyZlcSHfTzfb
3Zk5Dk7GTZAH8CW7qc6j8wPVSCogRP4kaGA8O+/PMzYCSHPpsgKSxrVgs8Xkld0Y
IOW3B1lt3NZMNnfSJWFBb7qYGiQcBu5C/mdfLjrEXtKDpP9Zn1SCUOUxnkK0e+uC
rKMRfQdug3l1vqk9RuPnipoo1yAQqruqHF4jkxsRW03btHL9fZWUWj+y266Btt4U
rUWhskfXqh1F8j7axvMSmR5E9NutDgHvc1+NhQCi/casV8MpB3OMx89NeYPRU/fl
8c4KLh/yArLfeYo4IZMEwutDusgcjDh868FvrX4bda5kgeRUMMjdxPSBYmxnSa3F
qONQ+zc9yO0pv5HVjyWPFFjkRGDLDadrDMksFohWnhrHzbN8Aw0dxi7xYKuTbT0S
QheidREnH4YzewqsBbt9KI07WBkWk8KW3jNlAQVns0NxBMS+z/o=
=jvnS
-----END PGP SIGNATURE-----

--c7oraxwegfvpbzcf--
