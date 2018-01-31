From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Date: Wed, 31 Jan 2018 14:27:51 +0200
Message-ID: <CAHp75Vf=-RQvCtS684Q5+X=YKmZXgP_1kr0to8BGZX0jQAsuZw@mail.gmail.com>
References: <20180127133209.28995-1-pali.rohar@gmail.com> <CAHp75VdWA-0a_FeicHSi_FfWurQ9EvkdW0raqgoRVySTyxDJ0Q@mail.gmail.com>
 <20180128144509.pobnj7cayc4psgrj@pali> <CAHp75VdU1OMTqLcDuzhQMHuX9rMhjw6p3CkSWaW5Y4kOy8ggqg@mail.gmail.com>
 <20180131120348.azy25aqvn5wrdkeh@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20180131120348.azy25aqvn5wrdkeh@pali>
Sender: platform-driver-x86-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <Mario_Limonciello@dell.com>, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jan 31, 2018 at 2:03 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
> On Sunday 28 January 2018 17:00:35 Andy Shevchenko wrote:
>> On Sun, Jan 28, 2018 at 4:45 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com> =
wrote:

>> > ACPI device name is SMO8800, SMO8810, ... Will that acpi_dev_present
>> > function match only prefix and not exact string?
>>
>> OK, fair enough.
>>
>> Do we have more users of such pattern?
>
> I have not seen this ACPI pattern yet, so probably not.

I see. So, my  one concern is the implicit names of the devices. I
would like rather to see

... acpi_device_id ... []=3D {
 {"SMO8800"},
 {"SMO8810"},
...
{}
};

--=20
With Best Regards,
Andy Shevchenko
