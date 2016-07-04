From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH] i2c: bcm2835: Set up the clock stretching timeout at boot.
Date: Sun, 03 Jul 2016 18:02:32 -0700
Message-ID: <87lh1ip653.fsf@eliezer.anholt.net>
References: <1464818845-5348-1-git-send-email-eric@anholt.net> <20160704003118.GA1381@tetsubishi>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anholt.net ([50.246.234.109]:41610 "EHLO anholt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932182AbcGDBCl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 3 Jul 2016 21:02:41 -0400
In-Reply-To: <20160704003118.GA1381@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, linux-i2c@vger.kernel.org

--=-=-=
Content-Type: text/plain

Wolfram Sang <wsa@the-dreams.de> writes:

>> +	/*
>> +	 * SMBUS says "Devices participating in a transfer will
>> +	 * timeout when any clock low exceeds the value of
>> +	 * T_TIMEOUT,MIN of 25 ms."
>> +	 */
>
> SMBus has that timeout, but I2C doesn't. How about disabling the timeout
> simply? Or using the max value if you want to keep the timeout
> detection?

Disabling the timeout seems fine to me.  We still have a 1-second
timeout around the entire transfer.  I'll be back on my DSI branch this
week and test it out then.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXebWoAAoJELXWKTbR/J7o0lAQALCgOZnj2QvweW21cuIzEkIO
9HwdrNoUMDE3DkC4zP111mKH3oa45wnf7fZh8EF2dIBJqQh6xZmkVIneJ4x0crNb
pbPX3fMV6eb6tFZB5Fr2lg6eeP9pLvcaZKNNI1R6L8UTHeycSIP04SnflqF8zoZm
z1s91Edp3PEICRKpCfn5D8qQM/93Odu51t/Y4+PpNHfCTbZA6/9AImGv+xsJ8ZWU
JV4dMf65C+HyTrl9nx41W3LHX79LIYrSeCfPNhTfxplwLeo8LdU58+KPk0xT0lvr
4ZqeZ48zcmTZ9wxm0QHMrGgbraze/g/ykIMufz/I9PA+qgFxp0dJNRjXM2HMD5/M
iRkERJ1U2fyWiBmEVekT3f1bdlN1+kPqix4ZQJ9Fbd7dDgeml43LwPhBvoIzw00H
snN1m8MTTJOLsyOD+J8jB8lLDhZLN4GyBeEVw9D4m5pWqrWf0JpSwRx1yNUIFrEp
EVh4nrwpmJsIk0TZitIkW/4LOlHZdnG54ifXwodHG6Nmxz3VYqwcZ+aUxLEwzrZp
IsNztLLRndw0+WqcuWiN67VxCcxxYYHm6c8iZM1n8yreo9/1DDqZkM5MBDKzZdw/
BzDxb97JLuz+SKWClhCkewiF9RDhM+2efYW/Q1Li8Y8teWtxT0EENI0JRtsfSyex
PItN14bWXFMIwwnenirR
=HNBt
-----END PGP SIGNATURE-----
--=-=-=--
