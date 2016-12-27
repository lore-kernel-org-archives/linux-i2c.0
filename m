From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on Dell machines
Date: Wed, 28 Dec 2016 00:15:30 +0200
Message-ID: <CAHp75VeWBaPNmT0mb+Gs_ZhFEHFx_H-Ro0UQ9u1VvLhNVjCqYQ@mail.gmail.com>
References: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com>
 <21e8453f9ebd2955b2c5e499dc51efb0@the-dreams.de> <201612271451.01505@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <201612271451.01505@pali>
Sender: platform-driver-x86-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>, Steven Honeyman <stevenhoneyman@gmail.com>, valdis.kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Alex Hung <alex.hung@canonical.com>, =?UTF-8?B?TWljaGHDheKAmiBLw4TihKJwaWXDheKAng==?= <kernel@kempniu.pl>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Dec 27, 2016 at 3:51 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
> On Tuesday 27 December 2016 14:43:49 Wolfram Sang wrote:
>> > Dell platform team told us that some (DMI whitelisted) Dell
>> > Latitude machines have ST microelectronics accelerometer at i2c
>> > address 0x29. That
>> > i2c address is not specified in DMI or ACPI, so runtime detection
>> > without
>> > whitelist which is below is not possible.
>>
>> I'd think this should rather live somewhere in
>> drivers/platform/x86/dell*.c?
>
> i2c_new_device() with lis3lv02d for i801 i2c bus needs to be called
> after initializing i2c-i801 bus driver.
>
> I have no idea how to do it (properly) outside of i2c-i801.c file.

I doubt we need a single line of code for this. See [1] and perhaps
create an EFI variable with necessary upgrade device node.

> Same thing is done for Fujitsu machines, see function
> i801_probe_optional_slaves() in i2c-i801.c file. So I did similar
> approach for Dell machines.

Perhaps, this also needs to be converted to use EFI variable.

[1] https://lwn.net/Articles/693212/

--=20
With Best Regards,
Andy Shevchenko
