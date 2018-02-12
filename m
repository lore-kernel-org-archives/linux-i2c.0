From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Date: Mon, 12 Feb 2018 17:25:23 +0200
Message-ID: <CAHp75Ve6dCgX+ophyh8M2SzVvpMoDSpwYyiNo=QStht=1G8n+Q@mail.gmail.com>
References: <20180127133209.28995-1-pali.rohar@gmail.com> <20180211220317.GA833@kmp-mobile.hq.kempniu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180211220317.GA833@kmp-mobile.hq.kempniu.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <Mario_Limonciello@dell.com>, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Feb 12, 2018 at 12:03 AM, Micha=C5=82 K=C4=99pie=C5=84 <kernel@kemp=
niu.pl> wrote:

>> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
>> ---
>> Changes since v1:
>>  * Added Dell Vostro V131 based on Micha=C5=82 K=C4=99pie=C5=84 testing
>
> I tested this patch on a Vostro V131 and it seems to work as expected:
> "lis3lv02d: 8 bits sensor found" is logged during boot, an input device
> gets registered and its axis values seem to be consistent with laptop's
> movements.
>
> Tested-by: Micha=C5=82 K=C4=99pie=C5=84 <kernel@kempniu.pl>

Thanks! I'm waiting for Pali to address my concern.

> I did not review the contents of the patch this time, sorry.

--=20
With Best Regards,
Andy Shevchenko
