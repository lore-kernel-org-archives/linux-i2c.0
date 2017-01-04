From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Date: Wed, 4 Jan 2017 11:25:44 +0100
Message-ID: <20170104102544.GS5767@mail.corp.redhat.com>
References: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com>
 <201701032105.51144@pali>
 <20170103202418.GE16032@dtor-ws>
 <201701032139.13061@pali>
 <CAHp75Vd2WQRHiVpqCeeNEdcup4peD_28SF1--cRr+uqAk-yY0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933661AbdADKZw (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 4 Jan 2017 05:25:52 -0500
Content-Disposition: inline
In-Reply-To: <CAHp75Vd2WQRHiVpqCeeNEdcup4peD_28SF1--cRr+uqAk-yY0g@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <Mario_Limonciello@dell.com>, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>

On Jan 04 2017 or thereabouts, Andy Shevchenko wrote:
> On Tue, Jan 3, 2017 at 10:39 PM, Pali Rohár <pali.rohar@gmail.com> wrote:
> >
> > With Michał we already discussed about it, see emails. Basically you can
> > enable/disable kernel modules at compile time or blacklist at runtime
> > (or even chose what will be compiled into vmlinux and what as external
> > .ko module). Some distributions blacklist i2c-i801.ko module...
> 
> But you understand that any of compile/not compile is not an option, right?
> The case which we face will be both of them, if possible, will be
> compiled as modules.
> 
> Blacklisting means making your problem the actual user's one. Not good.
> 
> > And
> > there can be also problem with initialization of i2c-i801 driver (fix is
> > in commit a7ae81952cda, but does not have to work at every time!). So
> > that move on whitelisted machines can potentially cause disappearance of
> > /dev/freefall and users will not have hdd protection which is currently
> > working.
> 

I am seeing the same issues with psmouse and SMBus touchpads. The PS/2
device knows about the availability of a better but unlisted device at
the ACPI level.

The way I solved this to not have to deal with compile/not compile and
runtime errors is the same way Wolfram told you about: bus notifiers.
I also use an intermediate platform driver to not add i2c dependency on
psmouse.

For you the solution would be:
- In dell-smo8800, after checking the whitelist, add a platform driver
  "dell-lis3lv02d-platform", and add in the platform_data the I2C address
  of the chip.
- create a new driver dell-lis3lv02d-platform.ko which listens for the
  i2c bus creation and registers the lis3lv02d I2C node when it sees a
  matching adapter. (see [1] for my solution)
- in dell-lis3lv02d-platform.ko make sure to set the irq to -ENOENT so
  that lis3lv02d.ko doesn't create /dev/freefall which will still be
  handled by ACPI.

How does that sound?

Cheers,
Benjamin

[1] https://github.com/bentiss/linux/blob/synaptics-rmi4-v4.9-rc7+/drivers/input/rmi4/rmi_platform.c 
