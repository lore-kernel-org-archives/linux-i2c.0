From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: can't write more than one byte to AT24C64 EEPROM using "eeprog"
Date: Wed, 26 Jul 2017 23:57:34 +0200
Message-ID: <20170726215734.m55ab5tndx3k53es@ninjato>
References: <20170725085131.Horde.ogXTYHLwBV6pmCIUgV7abh7@crashcourse.ca>
 <alpine.LFD.2.20.1707251344110.20856@localhost.localdomain>
 <alpine.LFD.2.20.1707261427010.32595@localhost.localdomain>
 <20170726205740.GB1510@katana>
 <alpine.LFD.2.20.1707261729480.3404@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kflpaovpou7qlayn"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:34882 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751040AbdGZV5g (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 26 Jul 2017 17:57:36 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1707261729480.3404@localhost.localdomain>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: linux-i2c@vger.kernel.org


--kflpaovpou7qlayn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


>   i'm not even sure what that means ... how do you distinguish between
> the kernel drivers and the user space utilities?

The kernel drivers provide you an 'eeprom' file in sysfs.


--kflpaovpou7qlayn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAll5EE4ACgkQFA3kzBSg
KbbXnw/8C4BiLiANDeKWd9SP75U90+c7bieOF7z3M45zuXPlEC1JjtvWchOegiw6
9g8nFh1xQVvwvxGaorvmbId+aInfN9icXWEASq1OuN2HwA0BWyQEl04MPZOPvJWg
wpHcdRaGu8mzqBsr89dqIV4WAkPOpYU4kYzjTyHtMmMyTOs444922L4lUNMG25xD
NIjEPCX4aqW5LMfBAAa3UDX+MIbg4ZArOCFSoyhTCT8Asl20IhsmPWsSTu5T/CHl
Gg2hWXP/Vkv9CF0AHa7w+NbmYEa2+2vMFDSs+toKnTRcxiUGqLQwOFJxEdp//WTz
pU0N59bMSMGdDivBoyO1NM5BOdunaGX5UshGAno4PQgmjNEd4hUX68zvKDu+siQz
hi229yjkL4PEgAse7wHWYMSFSBSqo1GXnw4nZi0dc7Q6RN1o/flpsOBLqBNYEsOx
QAsW5evG8V4Axeu8Yk5HPxSEE4kH14c9TwD2mTNozUJx91IKx52I72Ge0xnjRDhg
ujhjm0SPH6TyKsD5qWFMHIXO2XltrogEoQlJulFbVkJCclmy0MYBoM/gyXW4p2lI
LeabZTNsuGQLKaY/AyvQTizwcRXoXGH1eD1g3wWuKFg7ziO0M8xgCTTz/EA7V14O
zULNWiWEhBUVa1VqYho0tJ493fhkVZg9yeWuwuVC+i2GCmn9UYI=
=1uyl
-----END PGP SIGNATURE-----

--kflpaovpou7qlayn--
