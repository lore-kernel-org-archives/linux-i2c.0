From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Date: Tue, 3 Jan 2017 10:23:35 +0100
Message-ID: <20170103092335.GB20337@pali>
References: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com>
 <201612291517.37474@pali>
 <20161229210932.GA1254@kmp-mobile.hq.kempniu.pl>
 <201612292228.18706@pali>
 <20170103090641.GH5767@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170103090641.GH5767@mail.corp.redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario_Limonciello@dell.com, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-i2c@vger.kernel.org

On Tuesday 03 January 2017 10:06:41 Benjamin Tissoires wrote:
> On Dec 29 2016 or thereabouts, Pali Rohár wrote:
> > On Thursday 29 December 2016 22:09:32 Michał Kępień wrote:
> > > Also, just to make sure we do not overthink this, I understand that
> > > not every unit of the models from the whitelist has an
> > > accelerometer, correct?  In other words, could we perhaps skip the
> > > part where we are making sure the SMO88xx ACPI device is there?
> > 
> > Good question... At least for E6440 I'm did not thing it was possible to 
> > configure notebook without "3 axes free fall sensor".
> > 
> > But! In BIOS SETUP it is possible to disable free fall sensor. I will 
> > try to disable it there and will check what happen. My guess is that it 
> > will be disabled in ACPI.
> 
> Just adding my 2 cents regarding the whitelist and interaction between
> those 2 drivers. I find this very fragile to have only one available
> /dev/freefall node and to rely on the fairness of each driver to not bind
> one. It would have been much simpler to have /dev/freefallXX and a
> proper misc class device for it. This way, we don't even need to
> mutually exclude the drivers. But this is already 8 years old code, so I
> guess userspace expects this... (why isn't that using the input subsystem
> at all?).
> 
> Cheers,
> Benjamin.
> 

I think there is no problem with more /dev/freefall devices. With these
Dell drivers it should not happen as only one driver can request IRQ
which is associated with /dev/freefall. And /dev/freefal is registered
after acquiring IRQ.

But... there are other problems with it as wrote in previous emails.

-- 
Pali Rohár
pali.rohar@gmail.com
