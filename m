From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on  Dell machines
Date: Tue, 27 Dec 2016 14:43:49 +0100
Message-ID: <21e8453f9ebd2955b2c5e499dc51efb0@the-dreams.de>
References: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=83=C2=A1r?= <pali.rohar@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Steven Honeyman <stevenhoneyman@gmail.com>, valdis.kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, mario_limonciello@dell.com, Alex Hung <alex.hung@canonical.com>, =?UTF-8?Q?Micha=C3=85=E2=80=9A_K=C3=84?= =?UTF-8?Q?=E2=84=A2pie=C3=85=E2=80=9E?= <kernel@kempniu.pl>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

> Dell platform team told us that some (DMI whitelisted) Dell Latitude
> machines have ST microelectronics accelerometer at i2c address 0x29. 
> That
> i2c address is not specified in DMI or ACPI, so runtime detection 
> without
> whitelist which is below is not possible.

I'd think this should rather live somewhere in
drivers/platform/x86/dell*.c?
