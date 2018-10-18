From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/3] i2c: designware: Cleanup bus lock handling
Date: Thu, 18 Oct 2018 09:37:20 +0200
Message-ID: <20181018073720.GC882@kunai>
References: <20180923144510.4564-1-hdegoede@redhat.com>
 <20180923144510.4564-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180923144510.4564-4-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 23, 2018 at 04:45:10PM +0200, Hans de Goede wrote:
> Now that most of the special Bay- / Cherry-Trail bus lock handling has
> been moved to the iosf_mbi code we can simplify the remaining code a bit.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvIOCkACgkQFA3kzBSg
KbaetA/+LRrivW0GvsZp63yTkQVZPYV9czDnMWMbL18Xl26imiq/IbidehIBYZJp
iFI41dphMeijZYFqZhhnU1a0m3IVhYX/0IAafsGh/TuwC8Ytgsq3FyzK0pAqXs/Z
bekD1llGOAv6zVxojIVQgR0hjhdqJLPaM15ePT30nX+FPeFb/8GhbV/OeCWWXdpl
MZn4u2bISHTSIfZLQoIwUwJKVWFq0Uk7d+cKNRJzuGD8dhK+yVD5fxuu5kgVIHva
LWd4yvlO9Cy8YBXCgoK96qiwvYBZ5YzxkTlrJs55RhTRomj4AJdtvonMyX3WxElV
Kb2ydsEVGMdsk4gPA6+fGsCoZQoHISOhc+VQqhgzy17fQBJb6MxWy5I7lDjGe6Bb
ECiNg0+MRiX7Z1BKL6I9qXtFu/u1tSx21BcJql6VcM3JZpRAanx6MGqssEE6JKez
7wBAh1SmwuiHL+pY9rwfjtuC4wiPTCkRTvXMM9G2ot9nS1Bf9ODdmMQtuLzb0gjD
B7T9a2VANhhhwY7Jm00ts8imKQOVNoo2A5pXo5eMurpsBlzpwk2T7AoTu3zx7suF
u9f3u2RW781tm/dOxjCRk+zhKH/5T2KzB8uhEKC3GZq4WdABWhTBLafCkggAFzyq
c9UpuKhxDFlZ6IfbBE9Ohw8VAt4Km55ZX8fVs26rQJhEge9Sozo=
=jUUZ
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
