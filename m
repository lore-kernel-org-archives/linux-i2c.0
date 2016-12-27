From: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on Dell machines
Date: Tue, 27 Dec 2016 17:41:31 -0500
Message-ID: <52345.1482878491@turing-police.cc.vt.edu>
References: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com> <21e8453f9ebd2955b2c5e499dc51efb0@the-dreams.de> <201612271451.01505@pali>
 <CAHp75VeWBaPNmT0mb+Gs_ZhFEHFx_H-Ro0UQ9u1VvLhNVjCqYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1482878490_31020P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VeWBaPNmT0mb+Gs_ZhFEHFx_H-Ro0UQ9u1VvLhNVjCqYQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>, Steven Honeyman <stevenhoneyman@gmail.com>, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Alex Hung <alex.hung@canonical.com>, =?UTF-8?B?TWljaGHDheKAmiBLw4TihKJwaWXDheKAng==?= <kernel@kempniu.pl>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

--==_Exmh_1482878490_31020P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Dec 2016 00:15:30 +0200, Andy Shevchenko said:
> On Tue, Dec 27, 2016 at 3:51 PM, Pali Roh=E1r <pali.rohar=40gmail.com> =
wrote:

> > I have no idea how to do it (properly) outside of i2c-i801.c file.
>
> I doubt we need a single line of code for this. See =5B1=5D and perhaps=

> create an EFI variable with necessary upgrade device node.
>
> > Same thing is done for Fujitsu machines, see function
> > i801_probe_optional_slaves() in i2c-i801.c file. So I did similar
> > approach for Dell machines.
>
> Perhaps, this also needs to be converted to use EFI variable.
>
> =5B1=5D https://lwn.net/Articles/693212/

There's no guarantee that the laptops in question are booted with UEFI,
as Dell still supports legacy boot. So assuming the presence of EFI varia=
bles
is somewhat problematic.

In addition, it requires the user (or something in userspace) to set the =
UEFI
variable or configfs tweak, rather than Just Working Out Of The Box.


--==_Exmh_1482878490_31020P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.5 07/13/2001

iQEVAwUBWGLuGo0DS38y7CIcAQKdhAf9H3ndhl2HlfkwOhyFotOR+CSJMETZn2VO
Hc7knRxtQsR1MbV0+U/RfaDLXjzqCx/21qNkhHGPZ7skIA/6AXYzHD1j8hNKXteY
3WiquGgfT6LPBLOt1wLcbONZsVCZbHiqwZJUDSD+000DP1q4eH/rDC2N0XmRLcWz
mG0oNnNjDO5PwvrQGb1dVxni6MQe4J47y6k08R3VeD6sBL+FVEZeKSvszLg8uFVx
WFkHzetneTkNjCnQGppV/TPE8zQc+v8ncfzOyI/5iuER+TkBrcXD2uwWGgabPDla
y3vu95Y+PZPC4N70gfDABiUERTYJiztblnPufZkFg9+KWPw3Uzinow==
=ycnY
-----END PGP SIGNATURE-----

--==_Exmh_1482878490_31020P--
