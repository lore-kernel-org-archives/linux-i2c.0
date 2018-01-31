From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Date: Wed, 31 Jan 2018 13:03:48 +0100
Message-ID: <20180131120348.azy25aqvn5wrdkeh@pali>
References: <20180127133209.28995-1-pali.rohar@gmail.com>
 <CAHp75VdWA-0a_FeicHSi_FfWurQ9EvkdW0raqgoRVySTyxDJ0Q@mail.gmail.com>
 <20180128144509.pobnj7cayc4psgrj@pali>
 <CAHp75VdU1OMTqLcDuzhQMHuX9rMhjw6p3CkSWaW5Y4kOy8ggqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VdU1OMTqLcDuzhQMHuX9rMhjw6p3CkSWaW5Y4kOy8ggqg@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <Mario_Limonciello@dell.com>, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Sunday 28 January 2018 17:00:35 Andy Shevchenko wrote:
> On Sun, Jan 28, 2018 at 4:45 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com> w=
rote:
> > On Sunday 28 January 2018 16:39:25 Andy Shevchenko wrote:
> >> On Sat, Jan 27, 2018 at 3:32 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com=
> wrote:
> >> > +static bool is_dell_system_with_lis3lv02d(void)
> >> > +{
> >>
> >> > +       /*
> >> > +        * Check that ACPI device SMO88xx exists and is enabled. Tha=
t ACPI
> >> > +        * device represent our ST microelectronics lis3lv02d accele=
rometer but
> >> > +        * unfortunately without any other information (like i2c add=
ress).
> >> > +        */
> >>
> >> Isn't it simple
> >>
> >> return acpi_dev_present("SMO88", NULL, -1);
> >>
> >> call?
> >
> > ACPI device name is SMO8800, SMO8810, ... Will that acpi_dev_present
> > function match only prefix and not exact string?
>=20
> OK, fair enough.
>=20
> Do we have more users of such pattern?

I have not seen this ACPI pattern yet, so probably not.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
