From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 0/3] i2c-xlp9xx: update i2c driver to handle
 I2C_M_RECV_LEN flag
Date: Wed, 11 Oct 2017 09:06:58 +0200
Message-ID: <20171011070658.aixzgmgzacrwldnw@ninjato>
References: <1507616876-17189-1-git-send-email-kamlakant.patel@cavium.com>
 <CAJZ5v0gz9FQMXhiBokOKY5esrmv2JNoScsv5-LNR2ui_CZPdAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jub7xkmqrtxhmr77"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:33664 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751147AbdJKHHA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 11 Oct 2017 03:07:00 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gz9FQMXhiBokOKY5esrmv2JNoScsv5-LNR2ui_CZPdAQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kamlakant Patel <kamlakant.patel@cavium.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>


--jub7xkmqrtxhmr77
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2017 at 01:35:10AM +0200, Rafael J. Wysocki wrote:
> On Tue, Oct 10, 2017 at 8:27 AM, Kamlakant Patel
> <kamlakant.patel@cavium.com> wrote:
> > This patch set has following changes:
> >  * Use Linux clk APIs to get input clock frequency for the I2C controll=
er.
> >  * I2C driver update to handle I2C_M_RECV_LEN and I2C_CLIENT_PEC flags.
> >
> > Changes since v1:
> > * Rebased to mainline(4.14-rc4).
> > * Removed unnecessary parens in i2c-xlp9xx.c.
> >
> > Jayachandran C (2):
> >   ACPI / APD: Add clock frequency for ThunderX2 I2C controller
> >   i2c: xlp9xx: Get clock frequency with clk API
> >
> > Kamlakant Patel (1):
> >   i2c: xlp9xx: Handle I2C_M_RECV_LEN in msg->flags
> >
> >  drivers/acpi/acpi_apd.c         |  5 +++++
> >  drivers/i2c/busses/i2c-xlp9xx.c | 44 +++++++++++++++++++++++++++++++++=
++++----
> >  2 files changed, 45 insertions(+), 4 deletions(-)
>=20
> Hi Wolfram,
>=20
> I'm assuming that this will go in via the i2c tree, so please let me
> know if anything is needed from my side.

An ack for patch 1 would be nice.


--jub7xkmqrtxhmr77
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlndww4ACgkQFA3kzBSg
KbZ/ChAAhE674RuP9ROj6x3wpYYWPSH8pE6VOUv9MfyBG9w7OslCbMmTB4mTpupU
P71IADHf+BNueq76wFFPBPXhVex4ZxAjwNcDjDz6Ksfx3YJs2Bolfw7HmmdnpHSM
3NGPqPJTq1PmOcT7OiVY9JCrLB5Br5X6mU4nBnWg4MankH0oOIURRZ+q1Qi41KIh
QrfPMWKN4rtcb7i16lqQq5CTExZZqycDXdqhOPcOOE2/OIOwSFvGlgOpGOo1uQAf
x5m0xcj1XHZnmBhhbo/vE4q161162PFzkIpdJgH4N4i+AakBXJjBFCltoDPWTHFg
ZY7V2M1pDUjOh4RAetaR8+tMsuBCOpdvtaKASlFvbM7RVx/IJfeev7iF1cayR6r0
4ZSRZsTPmxe9HazKJ9WBtlW4WSzW5gYRO7HT3J1wlrbOfaGj6x5X4erTESblNLg3
oKXhx02Z19VcJaBMln64Z7ngPgr3AQs4yLHQwZ2UdIyKI+M7it9LI3h9VV8/UdAT
EuoNQKhhwTNduYsYOmN0TCWJplbC+waixgcR7QfVujm6vbXKke7RrWBKjpfbDPsS
HDvzL2Uhrx37mZDyDbTSNJLf6fES/X1KnpRY0vQPI1yE84tXU1CE0MsqBsnyfS+e
74YYss1b8nvRi85W+rL8t2i7xArmGiM6xZWwvVTt5yBHZiAukhs=
=OY1j
-----END PGP SIGNATURE-----

--jub7xkmqrtxhmr77--
