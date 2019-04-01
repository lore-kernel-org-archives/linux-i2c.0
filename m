From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: isch: Remove unnecessary acpi.h include
Date: Mon, 1 Apr 2019 16:08:06 +0200
Message-ID: <20190401140806.GB4570@kunai>
References: <20190325183652.252175-1-helgaas@kernel.org>
 <CAErSpo6_VMJ8nP9sA2xZffsMXdG3bKKv8WL0skyTTbuLe4WtJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAErSpo6_VMJ8nP9sA2xZffsMXdG3bKKv8WL0skyTTbuLe4WtJQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jean Delvare <jdelvare@suse.com>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mukesh Ojha <mojha@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > 54fb4a05af0a ("i2c: Check for ACPI resource conflicts") included
> > <linux/acpi.h> so we could use acpi_check_region().  fd46a0064af1 ("i2c:
> > convert i2c-isch to platform_device") removed the use of
> > acpi_check_region() but not the include.
> >
> > Remove the now-unnecessary include of <linux/acpi.h>.  No functional ch=
ange
> > intended.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>=20
> Added
>=20
>     Fixes: fd46a0064af1 ("i2c: convert i2c-isch to platform_device")
>     Reviewed-by: Jean Delvare <jdelvare@suse.de>
>     Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
>=20
> on my local branch.
>=20
> Jean, would you like me to repost this with the updates?  I assume you
> will merge this (just based on get_maintainer.pl)?

I will apply it, now that it has Jean's Rev-by. I assume this is
for-next material despite the Fixes tag?


--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyiG0IACgkQFA3kzBSg
KbaPKxAAqbx5BvQYP7FI8HkB7Gm/xqLjHUtlpHkwHmdnTxebTimRvacAVmmREgMM
GLLRJ9GbD9jRj2AT4TsuSNCyeVktzFFqnNK109l+wowGFJyOs8qDGLGIJOFAkHjh
YZQQdPOMbZxwsOcrA3TGjNfp+RJol/spJO36THbve2klB3G8GW1t3e42n3TTuXsV
RJWZ/Y7yZJ6++QepoK6yQ123y9mWLuaoujeSZaTB8UjEyWvb9JBT7NzsJY9jQLiH
hdhZycWpxX6G26A8TqwymauZ3dRMDPabk6opVZeUbMYovixY6JpdqjMabpcnk+Gl
rSOIWXLcLC9Xvuy7xewKofzeEe0SuxaOJ0Jc2wjHxhurP7qTgZFdFP2NiVM96Ydv
+N7KKvw0HMwNDp6zZq1RRC/mZPjMoqgwuYBkdykpi1fOOsp0jz0RpD4l8RScrLm8
QTcekdwaKpeuylFbzlRzyqX6pkUM3963D+fFq4ktSjWMuDL5klGOe10sDvddlgQS
+F7XHhl9GG4CUOkkPuKU3lpi3hU+Hni9SbquSwggu1kF4XmH6QHtHstPHc/5W734
C8SQoEKfl6ESHJMELBn1OfC/KpdhwG2oqUwTJoXy4YlEypTPNnLKBdYa5OyQGowh
datrpiKqhaB9gB+XKLxF5uJBUU1OEJtxKna7sfi4hr6esLmEzXs=
=ZFie
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
