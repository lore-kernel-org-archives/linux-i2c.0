From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on Dell machines
Date: Tue, 3 Jan 2017 22:20:12 +0200
Message-ID: <CAHp75VdkNGux_5qvCrW0+Wr=9gTAd60VE+3mWwaSAZrFoVHcqQ@mail.gmail.com>
References: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com>
 <20170103090641.GH5767@mail.corp.redhat.com> <20170103183843.GA16032@dtor-ws> <201701031950.17389@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33335 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbdACUVg (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 3 Jan 2017 15:21:36 -0500
In-Reply-To: <201701031950.17389@pali>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <Mario_Limonciello@dell.com>, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>

On Tue, Jan 3, 2017 at 8:50 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
> On Tuesday 03 January 2017 19:38:43 Dmitry Torokhov wrote:

>> "IIRC both dell-smo8800 and lis3lv02d represent one HW device (that
>> ST microelectronics accelerometer) but due to complicated HW
>> abstraction and layers on Dell laptops it is handled by two drivers,
>> one ACPI and one i2c."
>>
>> and that is the core of the issue. You have 2 drivers fighting over
>> the same device. Fix this and it will all work.
>
> With my current implementation (which I sent in this patch), they are
> not fighting.
>
> dell-smo8800 exports /dev/freefall (and nothing more) and lis3lv02d only
> accelerometer device as lis3lv02d driver does not get IRQ number in
> platform data.
>
>> As far as I can see hp_accel instantiates lis3lv02d and accesses it
>> via ACPI methods, can the same be done for Dell?
>
> No, Dell does not have any ACPI methods.

> And as I wrote in ACPI or DMI
> is even not i2c address of device, so it needs to be specified in code
> itself.

And as I wrote there is still a way to provide it without hardcoding
on model basis.

> Really there is no other way... :-(


--=20
With Best Regards,
Andy Shevchenko
