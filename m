From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [REF] Query regarding process call/repeated start in i2c driver
Date: Tue, 5 Sep 2017 19:52:12 +0200
Message-ID: <20170905175212.7lw5zaqq2lf5r2fg@ninjato>
References: <CANXXpoBfWccpXNza3xyVXDd7biAdrq+8DyzeRsGidVRE55iNyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x6j2zplqo5kveqbq"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:42659 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752059AbdIERwP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 5 Sep 2017 13:52:15 -0400
Content-Disposition: inline
In-Reply-To: <CANXXpoBfWccpXNza3xyVXDd7biAdrq+8DyzeRsGidVRE55iNyA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Shivaraj Shetty <shettyshivaraj@gmail.com>
Cc: linux-i2c@vger.kernel.org


--x6j2zplqo5kveqbq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> 1. From I2C_AQ_COMB quirk it looks like if there are two messages in
> single i2c_transfer api to i2c-core, it has to be repeated-start.
> Is my understanding correct?

Yes.

> 2. On calling smbus api for word read (non process call), it calls i2c
> transfer api with two messages (emulation on i2c case). Now if 1 is
> true we end up in repeated start case.

Yes, this is exactly how it is described in the SMBus Specification.

> But this may not be expected by the i2c client.

Quite the contrary, you usually run into more problems if you replace
repeated start with STOP/START. For example, you could get interrupted
by another master on the bus. But some clients also reset their state
machine after STOP. What device are you talking about? Which device
cannot handle repeated start? That would be interesting to know.

> Basically how to know from the i2c host/core driver, if the client
> wants to use Repeated start or not?

The client driver knows what the client wants.

> Why don't we have a way where i2c client driver can call the i2c core
> api with flag to indicate whether to use repeated-start or not?
> (similar to protocolparameter in smbus api - can be set as
> I2C_SMBUS_PROC_CALL for process call)

Because your client is not SMBus compatible, and you need work on I2C
level then where you can describe your own transfers the way you want.


--x6j2zplqo5kveqbq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmu5EgACgkQFA3kzBSg
KbZ9ow//Ria4ZLAPV4U7y3wKSzqRZByKP9JB0h8Y88AJRRfiBeZgbUgvnWxcxqk9
85SVLDtjcLdp5G5VQ6M1A4d2FDUvIzN3SvjtB/973WVNG4DnOGmnEe6/QMfI3mCI
xKV4vKAHY9Gfsw0P+hTXEMHh44OmWtL84/RhEACJYyLGvMkF5TX2i4DTvb8TXLxP
Te3VLWwL8JNokzH43ciyMYUqE686SnUZz0t2kYK0n73NsdOrBKHl3IM9QgUHbHUT
+H/onhFlyU5DgkBnuNg/fIykmTzNGf0PSDwO/sGprr4g7dYcJAdrDfb5mAtahF+r
OrZNrlnmEEtfEu3/t/CAMQyEkAg2o4woOK0ffq/rz3mYd4Viaf7m2JIP8P90Zdcb
c7XzyyVWZ1eskNisvxmYk7Qa3eyHInU9Pj9OEksPnsz+TkLT7dFfH5rivBu0N7Xl
YulWmcy/6w4rem6rNxHGV/YPL0uQz0zdUEhL7KQhfhXG77CaH0/a4UG3QK2puMXU
ayrv0Yn237ZeKyUVs/sAgv0JpjyuqBv/1pvLsVTWCe912rRrGoaQFmL8sAMwDZtf
GOrYQk4btZXUhbWs4Wnr8ysmNXuFRqHQ76bORK8+av9dfprZUOJreGKJ6GOVJcAv
pFJx4DCFMnkeziSObkAkjJBdpCXg6QbzfoyG7/HXNhaUqsO74D8=
=C0ca
-----END PGP SIGNATURE-----

--x6j2zplqo5kveqbq--
