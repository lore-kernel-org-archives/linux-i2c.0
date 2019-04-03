From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: isch: Remove unnecessary acpi.h include
Date: Wed, 3 Apr 2019 22:57:24 +0200
Message-ID: <20190403205724.ozrdjdujvnzzbrpe@ninjato>
References: <20190325183652.252175-1-helgaas@kernel.org>
 <CAErSpo6_VMJ8nP9sA2xZffsMXdG3bKKv8WL0skyTTbuLe4WtJQ@mail.gmail.com>
 <20190401140806.GB4570@kunai>
 <CAErSpo6MJFJO3s4NZ61CPZngbSaOhG-s5wLJyCQbwvdcnuBP1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fungn2ldvaz5tbuj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAErSpo6MJFJO3s4NZ61CPZngbSaOhG-s5wLJyCQbwvdcnuBP1Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jean Delvare <jdelvare@suse.com>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mukesh Ojha <mojha@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org


--fungn2ldvaz5tbuj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 02:37:19PM -0500, Bjorn Helgaas wrote:
> On Mon, Apr 1, 2019 at 9:08 AM Wolfram Sang <wsa@the-dreams.de> wrote:
> >
> >
> > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > >
> > > > 54fb4a05af0a ("i2c: Check for ACPI resource conflicts") included
> > > > <linux/acpi.h> so we could use acpi_check_region().  fd46a0064af1 (=
"i2c:
> > > > convert i2c-isch to platform_device") removed the use of
> > > > acpi_check_region() but not the include.
> > > >
> > > > Remove the now-unnecessary include of <linux/acpi.h>.  No functiona=
l change
> > > > intended.
> > > >
> > > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > >
> > > Added
> > >
> > >     Fixes: fd46a0064af1 ("i2c: convert i2c-isch to platform_device")
> > >     Reviewed-by: Jean Delvare <jdelvare@suse.de>
> > >     Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> > >
> > > on my local branch.
> > >
> > > Jean, would you like me to repost this with the updates?  I assume you
> > > will merge this (just based on get_maintainer.pl)?
> >
> > I will apply it, now that it has Jean's Rev-by. I assume this is
> > for-next material despite the Fixes tag?
>=20
> Definitely for-next material, not for the current release.  Jean
> suggested the Fixes tag, I think since it's related to a specific
> commit and could be backported together with that commit.
>=20
> Should there be a MAINTAINERS update to clarify who applies patches to
> drivers/i2c/busses/i2c-isch.c?  Right now, get_maintainers.pl doesn't
> mention you (Wolfram).
>=20
> Patch with tags attached in case it's useful to you (sorry, I'm
> saddled with gmail right now and can't include it inline).

> From 36fbdab89f5b8aa2d3616bd289e2c695fd3c0f9b Mon Sep 17 00:00:00 2001
> From: Bjorn Helgaas <bhelgaas@google.com>
> Date: Tue, 30 Oct 2018 14:12:36 -0500
> Subject: [PATCH] i2c: isch: Remove unnecessary acpi.h include
>=20
> 54fb4a05af0a ("i2c: Check for ACPI resource conflicts") included
> <linux/acpi.h> so we could use acpi_check_region().  fd46a0064af1 ("i2c:
> convert i2c-isch to platform_device") removed the use of
> acpi_check_region() but not the include.
>=20
> Remove the now-unnecessary include of <linux/acpi.h>.  No functional chan=
ge
> intended.
>=20
> Fixes: fd46a0064af1 ("i2c: convert i2c-isch to platform_device")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Fixed this checkpatch error:

ERROR: Please use git commit description style 'commit <12+ chars of sha1> =
("<title line>")' - ie: 'commit fd46a0064af1 ("i2c: convert i2c-isch to pla=
tform_device")'

and applied to for-next, thanks!


--fungn2ldvaz5tbuj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlylHjQACgkQFA3kzBSg
KbYelA//eh2Dzlbky6UDkwljgLsO12I6JWf8SvJF6Dia4XQ+ry1KkBX1xNS92drr
NwQudRB/FHJwX/uQpVzwECTIQRKN3EtXgp3DBruvxCFXyCk2HNNlCOUEpuOGOrwe
GUkQNZz0E1am+K7Jwon0pj3V2aLIo6smugRI+ecDKNme5fMPD951pO3x9lY8NUaY
8Xgy6uYh3eFfBbLlmF2DdRz74Y63DGVFQ60YTWa29R3gDkDtjHpl5xvTU1jER+zC
QZdjfeY0n+sIeewzqi+ZowkdMDJAZF4cHVhc1WdFqRR3BTatht6gdo3gL3D0K6AW
UdAuULvAYh/0pNmJ1qAN52s3mlhsbR4Bqn0XjaeWMLcWFm+/HN8wu50VnU6Y+vcV
Tbdhd0BL8KJ/CsICa4VpEgesK14q+3aVWeCvKk9g2gx0RFazja56oIr9P20eL1cW
teDRoWF2npWwJZk+ym14R9Qm2KWYK0n0Oe6yKPjH/UDlTb915XqfHMSe2R+Wviha
TED6hvQ/YrHo7z++L2KyCEEsh/IZ+rES6Es39vHW4W0xhumMEM//CSn7pwn67FOn
nF47PhwlGJKK9UgZgeB29M/gIpEiiD3hwIh4WZPAreiUaY/zCoBBTtqPh+w1xJaJ
cN8wdEQGHxB/iuSBDcY5LE7y02lqmf58CRV70o+fobokPK4JfnE=
=+4RK
-----END PGP SIGNATURE-----

--fungn2ldvaz5tbuj--
