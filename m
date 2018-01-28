From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Date: Sun, 28 Jan 2018 17:00:35 +0200
Message-ID: <CAHp75VdU1OMTqLcDuzhQMHuX9rMhjw6p3CkSWaW5Y4kOy8ggqg@mail.gmail.com>
References: <20180127133209.28995-1-pali.rohar@gmail.com> <CAHp75VdWA-0a_FeicHSi_FfWurQ9EvkdW0raqgoRVySTyxDJ0Q@mail.gmail.com>
 <20180128144509.pobnj7cayc4psgrj@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20180128144509.pobnj7cayc4psgrj@pali>
Sender: platform-driver-x86-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <Mario_Limonciello@dell.com>, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Jan 28, 2018 at 4:45 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
> On Sunday 28 January 2018 16:39:25 Andy Shevchenko wrote:
>> On Sat, Jan 27, 2018 at 3:32 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com> =
wrote:
>> > +static bool is_dell_system_with_lis3lv02d(void)
>> > +{
>>
>> > +       /*
>> > +        * Check that ACPI device SMO88xx exists and is enabled. That =
ACPI
>> > +        * device represent our ST microelectronics lis3lv02d accelero=
meter but
>> > +        * unfortunately without any other information (like i2c addre=
ss).
>> > +        */
>>
>> Isn't it simple
>>
>> return acpi_dev_present("SMO88", NULL, -1);
>>
>> call?
>
> ACPI device name is SMO8800, SMO8810, ... Will that acpi_dev_present
> function match only prefix and not exact string?

OK, fair enough.

Do we have more users of such pattern? If so, it might make sense to
introduce a generic helper for that which takes a list of HIDs on
input.

(Yes, I do not like matching pattern like "XYZhh*", I prefer explicit
list of HIDs. Rationale to do so: a) any new potential collision is
excluded, b) we can easily grep kernel for a users per HID)

--=20
With Best Regards,
Andy Shevchenko
