From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC PATCH] i2c: i801: Fix I2C Block Read on 8-Series/C220 and
 later
Date: Sun, 19 Jun 2016 19:09:51 +0200
Message-ID: <20160619170950.GC2933@tetsubishi>
References: <20160523114740.1f8cf29e@endymion>
 <5743FC27.2000307@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:59093 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234AbcFSRJ5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 19 Jun 2016 13:09:57 -0400
Content-Disposition: inline
In-Reply-To: <5743FC27.2000307@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Jean Delvare <jdelvare@suse.de>, Linux I2C <linux-i2c@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> >Jarkko, Mika, that's what I'm using on my machine now. It works, but
> >obviously I'd prefer to have confirmation from Intel hardware people
> >that this is the right thing to do before it goes upstream.
> >
> I haven't yet found the contact but search is on going.

Is there a plan B if no further information shows up?


--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXZtHeAAoJEBQN5MwUoCm254EP/R66Be5ksWSHpOUC0p3rsSjX
F1nMY1D6ksJOYsxxws97ym/8H2rOc3eKocvRNOAErQ/Kf7xeHGGGZKTe6TbggNnG
Q9Mx+5/va9SJSwKIQunCxIdF69viYLtRQWkK7Luo/LCIlJWlZECFAKD4TWLrHYid
vkAt3kUWTUJ5tNNxXOHFGAEoKdLhYzjA50QYgMa5XDzy4H+0XTB/3lrAz/MtwR3J
axXWwEFZrPvUuHztb2ttQ8cpJ5Cc2IWirlFg0PoHVic3I5WR+Tv+4PVWVIWb69YP
LauOOJWPBOQxojmXODblTYagCGSzKVKqwLFSJ1aF2TV+I8W6GP50+9N4KqCNLH7l
D0NVO74dfMpvJYNMEardba1VkqVWSTR4tZRhy4I9Z/0DpNtZ9uj+CHkgLdietdJP
ALb/RCocdFXoafJNdH3QTvJpDmPrUfoMoCtyZlm0gcLpbbVkzzoyHdvVL5QjW4aJ
wdTDU7tUbMTBQU5UtAfo46tSRf4V4kpzdj0weuft6CXef6ISVOvh37n66ANizotd
Dvx9Y7hdiDbpEKHp5MNs7IxxU275uFUW7GkVInYuMC8uZpIMK0WchHotJDV8GKca
DFT1u0vlhkCbo+OpW4eGwsnmP4aJZTX/sUAwlntTzPoSrIHa281IlN2YMJgpe3uO
CPQVqXOzm+JGsYW13AkJ
=k3TP
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
