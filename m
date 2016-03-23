From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 05/14] i2c-octeon: Enable high-level controller and
 improve on bus contention
Date: Wed, 23 Mar 2016 21:32:15 +0100
Message-ID: <20160323203215.GF19849@katana>
References: <cover.1458289385.git.jglauber@cavium.com>
 <27b7d9015f8165da0371e4d26c9acc72772ae3a0.1458289385.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B0nZA57HJSoPbsHY"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:48281 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756125AbcCWUcU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 23 Mar 2016 16:32:20 -0400
Content-Disposition: inline
In-Reply-To: <27b7d9015f8165da0371e4d26c9acc72772ae3a0.1458289385.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, David Daney <david.daney@cavium.com>


--B0nZA57HJSoPbsHY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 18, 2016 at 09:46:30AM +0100, Jan Glauber wrote:
> From: David Daney <david.daney@cavium.com>
>=20
> Use High Level Controller when possible.

Can you give me a one line description what this Controller is? I'd
assume it can do simple write-then-read messages with less setup?

> i2c-octeon was reacting badly to bus contention: when in
> direct-access mode (for transfers > 8 bytes, which cannot use the
> high-level controller) some !ACK or arbitration-loss states were
> not causing the current transfer to be aborted, and the bus released.

So, what does this patch do? Enable HLC for transfers < 8 byte? And for
all other transfers we still suffer from the same problem?

Such information should be here, too. It helps reviewing when I already
have the big picture.

> There's one place in i2c protocol that !ACK is an acceptable
> response: in the final byte of a read cycle.  In this case the
> destination is not saying that the transfer failed, just that it
> doesn't want more data.

Ehrm, no? For reads, the MASTER is saying it doesn't need any more data.
And an I2C eeprom can legally NACK a write, e.g. when it is still
processing the previous write. Also, NACK is a valid response after the
address phase, meaning there is no device listening.

Does the implementation cover the above cases?

> This enables correct behavior of ACK on final byte of non-final read
> msgs too.

The patch is huge and very hard to review. Maybe it needs to be split
up. Brainstorming example: a) move functions like octeon_i2c_set_clock()
upwards, b) change them if needed, c) implement HLC functions, d) add
switching logic to use HLC or non-HLC functions...

But first we need to be clear on the big picture view.

Thanks,

   Wolfram


--B0nZA57HJSoPbsHY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW8v1PAAoJEBQN5MwUoCm2CAMP+wdjunskJEmEbPqaeVMWakWs
++8s/3Cv1oAVVF/CTHdlqjmt+m3UvlmmTmF0+8UxorKbQQ4lDef9UUFujEWruzh4
HTfnmed7RkeHMFhFQZCgGiHqmQ0DPmlBjPQX45HSIOYg1F56jCOgwpFU1p+XW/OL
B9SQMZJmofLOjHDNEkKVlvff+lzuOQ7XVzxb1SsoLcZFF5/6ag6ZlMmAtOvU7lMx
88mDPtoLQPbsfsvxsSK7Nl1ZHsaH5SsCTkwvlZuQ2pvQH9QGUOEuFtkMjRj91xmT
wkakRj6CJVrlPNSCRWt1701e2/xAu/KnK3BmE1M/WqZypE5uL0dlabXdqqD/4/BY
r5vxccYN8k+PfWyjGJHt73Mfm4MR/uFU2rG6LZHPVyesGEw1Sk3C9jhFiBvG7D7Q
Hm4pEJpPwl64qf+Kt3rAKojLSAOqul4KIHH0SwI9JmUhNAhD17NMAEJxkhC+RJSA
wgeQ15buWOImt2S1iKPHgEj8VyxhAdIrRpyUB0yYmo/q0GaFJkFeD6Oj0BwhzyWG
zbjm1OG+aUkWCpDIlYktcAct8iZfcqnDx7OyJxeD9PFWdKxmgzgykLfMSl4CEl5e
Y1XqYhp+tke9F5cvBqojnxO2AaRut44pxEGc7zRVbM/Wgz3Ptou5+oupcXwSaZbf
rWECz6IcutMZxC4/RL8s
=LDpr
-----END PGP SIGNATURE-----

--B0nZA57HJSoPbsHY--
