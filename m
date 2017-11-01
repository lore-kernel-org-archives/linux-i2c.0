From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: Looking for AT24 maintainer
Date: Thu, 2 Nov 2017 00:15:18 +0100
Message-ID: <20171101231518.ac5cuddqgzpixgfc@ninjato>
References: <20171030183926.flybg3oestd43c7h@ninjato>
 <CAMRc=Mdirm=3iS4bU4Mg=psjmZo9FNnAuZ0_1srrkCvVgnTCfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yqtkcgxtzjmiekpm"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:59389 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752001AbdKAXPU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 1 Nov 2017 19:15:20 -0400
Content-Disposition: inline
In-Reply-To: <CAMRc=Mdirm=3iS4bU4Mg=psjmZo9FNnAuZ0_1srrkCvVgnTCfQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>, Javier Martinez Canillas <javierm@redhat.com>


--yqtkcgxtzjmiekpm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Bartosz,

> I have access to a couple compatible chips including some exotic ones
> and I'm interested in this driver being actively maintained, so I can
> give it a try.

Awesome! Thank you. I'll prepare a patch for MAINTAINERS in a minute.

As a last thing, I'll take care of this patch for 4.15:

" [v6] eeprom: at24: Add OF device ID table "

But after that, I'd hand things over to you. You can check i2c patchwork
for a list of pending patches:

http://patchwork.ozlabs.org/project/linux-i2c/list/?series=&submitter=&state=&q=at24&archive=&delegate=

Thanks again and let me know if you have questions,

   Wolfram


--yqtkcgxtzjmiekpm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAln6VYYACgkQFA3kzBSg
KbYG/g/8C2mp4JLEQLs/F5JrUxeropKNQ+CEKlSPBesigsO5QKh+eSsVZm3B+Tuu
3w3+MDMbRtnYy2VcSXiQFzyJwo1JMA69UP3YfoSVpCfBZBaLjQyNE95n2N12zLfc
MZIlZJlY/8nWoIiWMI3thq7eDtsVY0iE8ZPTDnkeyI/gbrplBB1UTGPNCk9YROiR
54VIj+qDWo4Bc4LZcKgsPYOqw/sWMA2sRdwiB6Km6Nz7krvh/p4vAA4YHIMx7ZOf
8i//6q7I2fC0wsVYf8NpW2mxI+kuyB7npdIsV8DLws390azeajlmnQH4zFZs2NJS
2GWVOK1JrZk2YatceisXltTn8yOqHjNQHvfBMp1wEswljlHVEI/cTDS7HnqCYcnu
DiQZokV7qbRpl4D/ExayXO0qj8exrAuZ2SK+xeTfnEkFWnVIClK5VsukVOJSx5uD
JyhHsf3WCK1taEszxzbSOwtdliszbQLLzptU/JYyg8XIvZewhupRfRja10PaAxcV
zU7Of0zqj7uXbhzWrzvIP4ylR+3odACWCE+8e9vEPhD0CI1SMSojq4LouJUmTMf0
kSciBwhqFibga8Ti8mx54QY2mb4kpzzqfvzo8FXnj0RjSyQtbQTbr/6/Rq5n8JSC
f2pxOkWBJKa2+gYYOLRXv28BBNwQk+O25fEHurBokHPrDNoXlXo=
=z/I9
-----END PGP SIGNATURE-----

--yqtkcgxtzjmiekpm--
