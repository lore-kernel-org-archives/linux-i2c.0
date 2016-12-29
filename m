From: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on Dell machines
Date: Wed, 28 Dec 2016 23:37:47 -0500
Message-ID: <134619.1482986267@turing-police.cc.vt.edu>
References: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com> <52345.1482878491@turing-police.cc.vt.edu> <CAHp75Vc4WaGu1mkMvXY3B=YSdd-Pv9YD7gJFxubDWu0Vow8=BQ@mail.gmail.com> <201612281005.22088@pali>
 <92e01f42db5129122dcf87f26f5e9917@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1482986267_31020P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <92e01f42db5129122dcf87f26f5e9917@the-dreams.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: =?UTF-8?Q?Pali_Roh=C3=83=C2=A1r?= <pali.rohar@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Steven Honeyman <stevenhoneyman@gmail.com>, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Alex Hung <alex.hung@canonical.com>, =?UTF-8?Q?Micha=C3=83=E2=80=A6=C3=A2?= =?UTF-8?Q?=E2=82=AC=C5=A1_K=C3=83=E2=80=9E=C3=A2=E2=80=9E=C2=A2pie=C3=83?= =?UTF-8?Q?=E2=80=A6=C3=A2=E2=82=AC=C5=BE?= <kernel@kempniu.pl>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

--==_Exmh_1482986267_31020P
Content-Type: text/plain; charset=us-ascii

On Wed, 28 Dec 2016 15:03:02 +0100, Wolfram Sang said:
> > I have absolutely no idea how to you want to achieve calling that
> > i2c_new_device() registration
> > without kernel patches.
>
> Documentation/i2c/instantiating-devices lists all supported methods.
> Method 4 is userspace instantiation.

I'd be totally OK with userspace doing it, except for the question "How good
will distros be about shipping it"?  I don't have any sense of how good Fedora
and Ubuntu and so on will be about making sure the userspace part is already
done for the user.

Anybody got evidence one way or another?


--==_Exmh_1482986267_31020P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.5 07/13/2001

iQEVAwUBWGSTG40DS38y7CIcAQKRLAgAqGJmxbLH6GkO1RL1peOwb+scTttH0uOG
gz/J/qvW7ik1tyjQptdmUcnv0FHGS3vN21hoZ7RCXu1TcZr9NXJF4OytXOxQlZ0a
gHknQSI/aSnxHqSxpYM2E1hIcsj/RLhEpEVYUz0IjrFlBUKRJ/qk9Z1Tkao2s1R7
dCsiePnTI7pO+qF/kENM+Oo7n1v6GztrncwIm4dFNiHk/5NjfmoOQCsiaL0iR4TF
CFpda4nw64IVMO+ISFfKFMXBozogYvp24Xk7Wzev0kKQRNfw2/8YTzfgWnZ8Pled
CwsdsthDaSsVycuOg5gulocWQGxpYztlW8ODz2wx6b3Q9YUVgAZCpA==
=J/Jn
-----END PGP SIGNATURE-----

--==_Exmh_1482986267_31020P--
