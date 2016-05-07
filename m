From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with PCI BAR
Date: Sat, 7 May 2016 16:11:45 +0200
Message-ID: <201605071611.45664@pali>
References: <1461839010-110231-1-git-send-email-mika.westerberg@linux.intel.com> <20160505082725.GQ12528@pali> <CALCETrW3i7QkVNRo4RQkRViPBo8dSn=4mKDZiA=Ar3v7=dgz1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4346586.rXkMv1I1ja";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36187 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282AbcEGOLt (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sat, 7 May 2016 10:11:49 -0400
In-Reply-To: <CALCETrW3i7QkVNRo4RQkRViPBo8dSn=4mKDZiA=Ar3v7=dgz1A@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jean Delvare <jdelvare@suse.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

--nextPart4346586.rXkMv1I1ja
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 06 May 2016 21:00:25 Andy Lutomirski wrote:
> On May 5, 2016 1:27 AM, "Pali Roh=C3=A1r" <pali.rohar@gmail.com> wrote:
> > On Friday 29 April 2016 17:56:14 Andy Lutomirski wrote:
> > > On Fri, Apr 29, 2016 at 2:42 PM, Andy Lutomirski
> > > <luto@amacapital.net>
>=20
> wrote:
> > > > On Fri, Apr 29, 2016 at 2:00 PM, Pali Roh=C3=A1r
> > > > <pali.rohar@gmail.com>
>=20
> wrote:
> > > >> On Friday 29 April 2016 20:10:23 Andy Lutomirski wrote:
> > > >>> Jean and Wolfram: is there a quirk mechanism to add i2c
> > > >>> devices that aren't directly enumerable but are known to
> > > >>> exist due to DMI?
> > > >>=20
> > > >> Maybe something like i2c_register_board_info()?
> > > >=20
> > > > Maybe.  i think that wants to be called before the adapter
> > > > shows up,
>=20
> though.
>=20
> > > i2c_probe_optional_slaves may be a more appropriate place to put
> > > this.
> >=20
> > I cannot find function i2c_probe_optional_slaves. Where is it?
>=20
> Sorry, I meant i801_probe_optional_slaves.

Hm... that could probably work. I will look at dell-smo8800.c and=20
lis3lv02d_i2c.c and i2c-i801.c how to interconnect all those devices...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart4346586.rXkMv1I1ja
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlct96EACgkQi/DJPQPkQ1JWaACcCaaQDWL681sihcKqru6g/eC2
2bcAn0j9zq+kQ1zly92UJyoPiz2rJGP8
=1N1q
-----END PGP SIGNATURE-----

--nextPart4346586.rXkMv1I1ja--
