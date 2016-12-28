From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on Dell machines
Date: Wed, 28 Dec 2016 09:55:18 +0200
Message-ID: <CAHp75Vc4WaGu1mkMvXY3B=YSdd-Pv9YD7gJFxubDWu0Vow8=BQ@mail.gmail.com>
References: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com>
 <21e8453f9ebd2955b2c5e499dc51efb0@the-dreams.de> <201612271451.01505@pali>
 <CAHp75VeWBaPNmT0mb+Gs_ZhFEHFx_H-Ro0UQ9u1VvLhNVjCqYQ@mail.gmail.com> <52345.1482878491@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <52345.1482878491@turing-police.cc.vt.edu>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Valdis.Kletnieks@vt.edu, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>, Steven Honeyman <stevenhoneyman@gmail.com>, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Alex Hung <alex.hung@canonical.com>, =?UTF-8?B?TWljaGHDheKAmiBLw4TihKJwaWXDheKAng==?= <kernel@kempniu.pl>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Dec 28, 2016 at 12:41 AM,  <Valdis.Kletnieks@vt.edu> wrote:
> On Wed, 28 Dec 2016 00:15:30 +0200, Andy Shevchenko said:
>> On Tue, Dec 27, 2016 at 3:51 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com> =
wrote:
>
>> > I have no idea how to do it (properly) outside of i2c-i801.c file.
>>
>> I doubt we need a single line of code for this. See [1] and perhaps
>> create an EFI variable with necessary upgrade device node.
>>
>> > Same thing is done for Fujitsu machines, see function
>> > i801_probe_optional_slaves() in i2c-i801.c file. So I did similar
>> > approach for Dell machines.
>>
>> Perhaps, this also needs to be converted to use EFI variable.
>>
>> [1] https://lwn.net/Articles/693212/
>
> There's no guarantee that the laptops in question are booted with UEFI,
> as Dell still supports legacy boot. So assuming the presence of EFI varia=
bles
> is somewhat problematic.


> In addition, it requires the user (or something in userspace) to set the =
UEFI
> variable or configfs tweak, rather than Just Working Out Of The Box.

I have no strong opinion, though I don't support the idea to put all
hacks in the world to the kernel. For example, we have user space tool
to switch USB modem from storage to actual communication device and
that is just working out of the box.

Mika, Darren, what are your opinions?

--=20
With Best Regards,
Andy Shevchenko
