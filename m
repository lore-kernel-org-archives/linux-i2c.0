From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on  Dell machines
Date: Wed, 28 Dec 2016 15:02:52 +0100
Message-ID: <6acf42bfb16eaa0e69ca322eb0c0853d@the-dreams.de>
References: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com>
 <21e8453f9ebd2955b2c5e499dc51efb0@the-dreams.de> <201612271451.01505@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <201612271451.01505@pali>
Sender: platform-driver-x86-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Steven Honeyman <stevenhoneyman@gmail.com>, valdis.kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, mario_limonciello@dell.com, Alex Hung <alex.hung@canonical.com>, =?UTF-8?Q?Micha=C3=85=E2=80=9A_K=C3=84?= =?UTF-8?Q?=E2=84=A2pie=C3=85=E2=80=9E?= <kernel@kempniu.pl>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Dec 27, 2016 at 02:51:01PM +0100, Pali Rohár wrote:
> On Tuesday 27 December 2016 14:43:49 Wolfram Sang wrote:
> > > Dell platform team told us that some (DMI whitelisted) Dell
> > > Latitude machines have ST microelectronics accelerometer at i2c
> > > address 0x29. That
> > > i2c address is not specified in DMI or ACPI, so runtime detection
> > > without
> > > whitelist which is below is not possible.
> >
> > I'd think this should rather live somewhere in
> > drivers/platform/x86/dell*.c?
>
> i2c_new_device() with lis3lv02d for i801 i2c bus needs to be called
> after initializing i2c-i801 bus driver.
>
> I have no idea how to do it (properly) outside of i2c-i801.c file.

I once used bus_notifiers to achieve something similar. You could check
arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c to see an action
triggered once a client device got added, but you could act on another
action like BUS_NOTIFY_BOUND_DRIVER. I used exactly that, too, somewhen
somewhere.  Haven't checked if that helps here, too. And since we have 
a
precedence (Fujitsu case), I'll leave it to Jean who is the maintainer
of this driver.

Thanks,

    Wolfram
