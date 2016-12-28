From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on Dell machines
Date: Wed, 28 Dec 2016 09:38:40 +0100
Message-ID: <201612280938.41260@pali>
References: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com> <201612271451.01505@pali> <CAHp75VeWBaPNmT0mb+Gs_ZhFEHFx_H-Ro0UQ9u1VvLhNVjCqYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9332383.4mGRSbbS2o";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VeWBaPNmT0mb+Gs_ZhFEHFx_H-Ro0UQ9u1VvLhNVjCqYQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>, Steven Honeyman <stevenhoneyman@gmail.com>, valdis.kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Alex Hung <alex.hung@canonical.com>, =?utf-8?q?Micha=C3=85=E2=80=9A_K=C3=84=E2=84=A2pie=C3=85=E2=80=9E?= <kernel@kempniu.pl>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

--nextPart9332383.4mGRSbbS2o
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 27 December 2016 23:15:30 Andy Shevchenko wrote:
> On Tue, Dec 27, 2016 at 3:51 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com>
> wrote:
> > On Tuesday 27 December 2016 14:43:49 Wolfram Sang wrote:
> >> > Dell platform team told us that some (DMI whitelisted) Dell
> >> > Latitude machines have ST microelectronics accelerometer at i2c
> >> > address 0x29. That
> >> > i2c address is not specified in DMI or ACPI, so runtime
> >> > detection without
> >> > whitelist which is below is not possible.
> >>=20
> >> I'd think this should rather live somewhere in
> >> drivers/platform/x86/dell*.c?
> >=20
> > i2c_new_device() with lis3lv02d for i801 i2c bus needs to be called
> > after initializing i2c-i801 bus driver.
> >=20
> > I have no idea how to do it (properly) outside of i2c-i801.c file.
>=20
> I doubt we need a single line of code for this. See [1] and perhaps
> create an EFI variable with necessary upgrade device node.

Sorry, but EFI variable is not accessible from BIOS booted kernel. So=20
such thing will not work.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart9332383.4mGRSbbS2o
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlhjehEACgkQi/DJPQPkQ1IaIQCeLsYvyTdShwyMf5MIbt0KSkkS
HYMAoLE4yFPXJ78FL6FYZ7PI3+QlaP7D
=+Mh1
-----END PGP SIGNATURE-----

--nextPart9332383.4mGRSbbS2o--
