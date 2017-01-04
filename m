From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on Dell machines
Date: Wed, 4 Jan 2017 11:53:54 +0200
Message-ID: <CAHp75Vd2WQRHiVpqCeeNEdcup4peD_28SF1--cRr+uqAk-yY0g@mail.gmail.com>
References: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com>
 <201701032105.51144@pali> <20170103202418.GE16032@dtor-ws> <201701032139.13061@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35983 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751675AbdADJx4 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 4 Jan 2017 04:53:56 -0500
In-Reply-To: <201701032139.13061@pali>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <Mario_Limonciello@dell.com>, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>

On Tue, Jan 3, 2017 at 10:39 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
>
> With Micha=C5=82 we already discussed about it, see emails. Basically you=
 can
> enable/disable kernel modules at compile time or blacklist at runtime
> (or even chose what will be compiled into vmlinux and what as external
> .ko module). Some distributions blacklist i2c-i801.ko module...

But you understand that any of compile/not compile is not an option, right?
The case which we face will be both of them, if possible, will be
compiled as modules.

Blacklisting means making your problem the actual user's one. Not good.

> And
> there can be also problem with initialization of i2c-i801 driver (fix is
> in commit a7ae81952cda, but does not have to work at every time!). So
> that move on whitelisted machines can potentially cause disappearance of
> /dev/freefall and users will not have hdd protection which is currently
> working.


--=20
With Best Regards,
Andy Shevchenko
