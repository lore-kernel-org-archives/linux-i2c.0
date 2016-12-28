From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on Dell machines
Date: Wed, 28 Dec 2016 10:05:21 +0100
Message-ID: <201612281005.22088@pali>
References: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com> <52345.1482878491@turing-police.cc.vt.edu> <CAHp75Vc4WaGu1mkMvXY3B=YSdd-Pv9YD7gJFxubDWu0Vow8=BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2079886.hlRV53szME";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:33091 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbcL1JF0 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 28 Dec 2016 04:05:26 -0500
In-Reply-To: <CAHp75Vc4WaGu1mkMvXY3B=YSdd-Pv9YD7gJFxubDWu0Vow8=BQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Valdis.Kletnieks@vt.edu, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>, Steven Honeyman <stevenhoneyman@gmail.com>, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Alex Hung <alex.hung@canonical.com>, =?utf-8?q?Micha=C3=85=E2=80=9A_K=C3=84=E2=84=A2pie=C3=85=E2=80=9E?= <kernel@kempniu.pl>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org

--nextPart2079886.hlRV53szME
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 28 December 2016 08:55:18 Andy Shevchenko wrote:
> On Wed, Dec 28, 2016 at 12:41 AM,  <Valdis.Kletnieks@vt.edu> wrote:
> > On Wed, 28 Dec 2016 00:15:30 +0200, Andy Shevchenko said:
> >> On Tue, Dec 27, 2016 at 3:51 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com=
> wrote:
> >
> >> > I have no idea how to do it (properly) outside of i2c-i801.c file.
> >>
> >> I doubt we need a single line of code for this. See [1] and perhaps
> >> create an EFI variable with necessary upgrade device node.
> >>
> >> > Same thing is done for Fujitsu machines, see function
> >> > i801_probe_optional_slaves() in i2c-i801.c file. So I did similar
> >> > approach for Dell machines.
> >>
> >> Perhaps, this also needs to be converted to use EFI variable.
> >>
> >> [1] https://lwn.net/Articles/693212/
> >
> > There's no guarantee that the laptops in question are booted with UEFI,
> > as Dell still supports legacy boot. So assuming the presence of EFI var=
iables
> > is somewhat problematic.
>=20
>=20
> > In addition, it requires the user (or something in userspace) to set th=
e UEFI
> > variable or configfs tweak, rather than Just Working Out Of The Box.
>=20
> I have no strong opinion, though I don't support the idea to put all
> hacks in the world to the kernel. For example, we have user space tool
> to switch USB modem from storage to actual communication device and
> that is just working out of the box.
>=20
> Mika, Darren, what are your opinions?

I have absolutely no idea how to you want to achieve calling that i2c_new_d=
evice() registration=20
without kernel patches.

So before starting discussion which option to use (EFI, kernel patch, users=
pace script, etc...)=20
please describe how would you implement such logic with different options.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2079886.hlRV53szME
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlhjgFIACgkQi/DJPQPkQ1Kd9ACghSWBo49vTGMB736MQ2xPj4LT
Xi8AoKlNe2rHB0RCChWnwpO0IIsLNSWx
=WB1r
-----END PGP SIGNATURE-----

--nextPart2079886.hlRV53szME--
