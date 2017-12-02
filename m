From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] eeprom: at24: check at24_read/write arguments
Date: Sat, 2 Dec 2017 23:36:04 +0100
Message-ID: <20171202223604.rd4i2e5rzkkzhsok@ninjato>
References: <a519bea7-9c68-caf1-7b1a-100c2562a2d7@gmail.com>
 <CAMRc=Me__y_vT0=-ZND=b4+H6gx+rX=h4eO9cb8Ugdx+dQEx_w@mail.gmail.com>
 <e2b228a3-0dc9-3c47-91e0-e28d12f3da2d@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3chydlpsad2shiz2"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:38642 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751996AbdLBWgG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 2 Dec 2017 17:36:06 -0500
Content-Disposition: inline
In-Reply-To: <e2b228a3-0dc9-3c47-91e0-e28d12f3da2d@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>


--3chydlpsad2shiz2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


For the record:

> Best solution would be if nvmem core guarantees that all calls to
> the nvmem provider read/write callbacks are done with valid
> parameters only.

+1


--3chydlpsad2shiz2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlojKtAACgkQFA3kzBSg
Kbb44RAAtWtuixzE4o95D/hQnfqYjbfC5tfEFSYnYQxYcVlxnffqLt0CJuFYVRd5
5maUjCzdiIyohPhUa2zj+KrGu1mjTTFIGPG1d6aoqwHzAaxjfqfLD2y5FWb1qu3y
OlSJN/0Twtsi7OurQG79UCLHy9qs0/kbQ1x4EtfVd/N1pROZ1CqMjJO/YpLAdD6C
RbYXvyHDewWLQt6xDlUma142D9K5cq87bWRfQOtXDtIZQkwqi8GAcsb4PdrsSakD
abCvlBOd51TWwWYn8SYbZXXKUZ0lQ5LsgLDrrKwDd869/0VoWV8FcTkaCB4zxqXl
fhBHa4H1FU4HG+oBzlLl1NJeAfU1FwpiLF3QoGdiWVN8d2g02WQHdW/iT8iFU80L
QGHw5YRSjVfwOk7FdZ37cARqhSRs58vloDu++SiL7/aLeTieSIPHEl2Ehm/YuMpz
bWYnhx6C5P9BZklAeYqNiauPehFqE24JiIqmE7KgHIY3nInzs5bFtDEY8C+do0ji
HECSY/4HtsRd9Rw3DSfyV5vRLRo55BcxdJo8mcWF/hkQQtZuNkas/NeGQMyAQ6HH
AjsllirzTZie7koM1RhaNqDCEcGORGQ2kp6ByiNExZlLvYgflrnXGIzb0ueukEzB
LG1+lTju06651EOIz0EquoPuuQGNMpujgPLeFuusJlXEBV5oXpg=
=+5p+
-----END PGP SIGNATURE-----

--3chydlpsad2shiz2--
