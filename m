From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH resend v2] i2c-cht-wc: Add Intel Cherry Trail Whiskey
 Cove SMBUS controller driver
Date: Sun, 13 Aug 2017 21:34:59 +0200
Message-ID: <20170813193459.h7i2lto7wylqvkma@ninjato>
References: <20170806105943.31470-1-hdegoede@redhat.com>
 <20170806105943.31470-2-hdegoede@redhat.com>
 <20170812120410.he2jkil7clhlybd4@ninjato>
 <c0f592f8-77b9-7765-8530-ac01ffaffab6@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vkujmzqb4wpbzu52"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:47183 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750955AbdHMTfA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 13 Aug 2017 15:35:00 -0400
Content-Disposition: inline
In-Reply-To: <c0f592f8-77b9-7765-8530-ac01ffaffab6@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <j.w.r.degoede@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org


--vkujmzqb4wpbzu52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> using this PMIC combine it with a bq24192i charger and there is no
> other info on this in the ACPI tables.

I see :(

> From a practical/implementation pov however it is a lot easier to
> implement the i2c-client instantiation in the i2c-cht-wc adapter
> driver because that gives us easy access to the i2c_adapter struct
> and to the irq for charger-ic-irq-pin on the PMIC. Esp. getting access
> to the irq somewhere else is problematic.

Okay, I know that PMICs have sometimes recommended peripheral ICs. I'll
apply V3 and hope with you that no other combination of PMIC and charger
will show up.



--vkujmzqb4wpbzu52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmQqd8ACgkQFA3kzBSg
KbaeWg/9F4dztlo5PK0AvsrD1FYAD7Hv+fUccQ0OC1YHAwebzRGnRza5wnDuOGpp
oeE98TnB0v28Id32/VwMRwqitAqV8FMpzDWz3ivm0aQ9JEe4LME76xKu476nV59a
ymxOZ8pYoAgbVjS/qkchirTSSopPNwujURZGp/05+MZpWGcmRoU7hJnecf//HOrF
Uu3mMg6bfzmTXhliytKP8/VeO6L2zyyQWBHuu7gGF+FKEKjWaWziH+qxA65lBVSl
Z/W6riiW/+tW9EjDsgIdt/R5mg+F9y3zf0hml/3K5APSyx5rFitA9C9P3sQAL2LP
xVDE0E6/PjpT85QuGOJJb4aPz9CKIqN2J9VWnspsOMZ+6rqDsZL7SY7e4KlBHTWs
Wdtx/kpasezLtYAr/VX3gN5VKiN5gy0rQ7TZDFk/qW1GD5aGx0UsMXR+TE8MYEew
/zt7A6A/yZnn2bHej0r2thqHUGEBlF25VEiK/vJCRoywHNveUQbLyO1Z5CqNTgXm
quyWeaLBNVremv70o0lNYXXJUenD4GF4SvzwuPDJKVw672cDyppD2gFVrIHAAjWc
2AJ8elX5XP1pAZ4jNkUS82MVrbC/EJASbudzV+g4wepCy+ebxhv0eq6mylAfq/EP
9Qa2O8Uy/etnS/lq9A94iVxVvNmj9lCFlOV44ltRTP5A9B5Uu2k=
=gr4C
-----END PGP SIGNATURE-----

--vkujmzqb4wpbzu52--
