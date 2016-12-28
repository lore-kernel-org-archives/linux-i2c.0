From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on  Dell machines
Date: Wed, 28 Dec 2016 15:03:02 +0100
Message-ID: <92e01f42db5129122dcf87f26f5e9917@the-dreams.de>
References: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com>
 <52345.1482878491@turing-police.cc.vt.edu>
 <CAHp75Vc4WaGu1mkMvXY3B=YSdd-Pv9YD7gJFxubDWu0Vow8=BQ@mail.gmail.com>
 <201612281005.22088@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201612281005.22088@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=83=C2=A1r?= <pali.rohar@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, valdis.kletnieks@vt.edu, Mika Westerberg <mika.westerberg@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Steven Honeyman <stevenhoneyman@gmail.com>, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Alex Hung <alex.hung@canonical.com>, =?UTF-8?Q?Micha=C3=83=E2=80=A6=C3=A2?= =?UTF-8?Q?=E2=82=AC=C5=A1_K=C3=83=E2=80=9E=C3=A2=E2=80=9E=C2=A2pie=C3=83?= =?UTF-8?Q?=E2=80=A6=C3=A2=E2=82=AC=C5=BE?= <kernel@kempniu.pl>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

> I have absolutely no idea how to you want to achieve calling that 
> i2c_new_device() registration
> without kernel patches.

Documentation/i2c/instantiating-devices lists all supported methods.
Method 4 is userspace instantiation.
