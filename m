From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Date: Wed, 4 Jan 2017 10:13:38 +0100
Message-ID: <20170104091338.GO5767@mail.corp.redhat.com>
References: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com>
 <20170103090641.GH5767@mail.corp.redhat.com>
 <20170103183843.GA16032@dtor-ws>
 <201701031950.17389@pali>
 <20170103194812.GD16032@dtor-ws>
 <20170103212934.GK5767@mail.corp.redhat.com>
 <20170104063642.GA20545@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170104063642.GA20545@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario_Limonciello@dell.com, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Jan 03 2017 or thereabouts, Dmitry Torokhov wrote:
> On Tue, Jan 03, 2017 at 10:29:34PM +0100, Benjamin Tissoires wrote:
> > On Jan 03 2017 or thereabouts, Dmitry Torokhov wrote:
> >
> > > Yet another option: can we add a new flag to i2c_board_info controlling
> > > whether we want to enable/disable wiring up host notify interrupt?
> > 
> > That should be fairly easy to implement. For now, given that only Elan
> > and Synaptics are the one in need for Host Notify, it could be better to
> > request the Host Notify IRQ instead of disabling it unconditionally
> > (which would make the current yet 8 years old lis3lv02d driver happy
> > again).
> 
> I like that we have it done in i2c core instead of having drivers
> implementing it individually. Since you are saying that handling host
> notify is property of the slave/driver maybe we should be adding a flag
> to the *i2c_driver* structure to let i2c core that we want to have host
> notify mapped as interrupt if "native" interrupt is not supplied by the
> platform code?

I don't think this is a good idea. It's still a property of the I2C
device, not the driver. It's crappy under Windows, but that doesn't
prevent us to do the right thing.

I think the idea of having it at the i2c_board_info level is the good
one. It's a property of the device node and it wouldn't hurt me to have
a device tree property for that too (not entering the DT field now).
There is no ACPI prop for it too, but I wouldn't be surprised if it
comes in a later revision. The advantage of having it turned on
unconditionally is that we can instantiate it from userspace without
breaking the sysfs ABI.

Note that in the 2 uses I have seen so far of Host Notify, in both cases
I need to instantiate the I2C device from an other driver (psmouse) so I
can control the content of i2c_board_info.

Cheers,
Benjamin
