From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: Add possibility for user-defined (i2c-)devices
  for bus-drivers.
Date: Tue, 13 Nov 2012 22:08:35 +0100
Message-ID: <20121113220835.111a178a@endymion.delvare>
References: <1352829968-4908-1-git-send-email-holler@ahsoftware.de>
	<20121113195533.6db71716@endymion.delvare>
	<50A2AC28.7050304@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50A2AC28.7050304-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Till Harbaum <till-RcHadlBFbzVAfugRpC6u6w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Alexander,

On Tue, 13 Nov 2012 21:23:04 +0100, Alexander Holler wrote:
> Am 13.11.2012 19:55, schrieb Jean Delvare:
> > On Tue, 13 Nov 2012 19:06:07 +0100, Alexander Holler wrote:
> >> This makes it possible to define i2c-devices at the kernel command line
> >> or as a module parameter for bus-drivers which want to offer such
> >> an functionality.
> >>
> >> Drivers which are using it will have the a parameter named
> >> devices with format devname1@addr1,devname2@addr2,...
> >> e.g. devices=ds1307@0x68,pcf8563@0x51
> >
> > No, no, no. We did that 10 years ago, killed all the code 3 years ago
> > [1], let's not do the same mistake again, please. We have a sysfs
> > interface for instantiating clients dynamically from user-space, it's
> > way more powerful and flexible than your proposal. Just try plugging two
> 
> So how do I define a device, e.g. an RTC which I want to have alive 
> before userland starts? Currently imho not possible.

If your system relies on a an RTC clock chip hanging off an USB-to-I2C
adapter, I'd say your design is very wrong to start with. I can only
suppose (hope!) you are doing that during some development phase and
the final hardware design is totally different.

If you need I2C devices to be instantiated early in the boot process,
this would typically be done by platform code. This is going to be a
little difficult with i2c-tiny-usb as it was definitely not meant to
host system-critical chips. But you can probably get it to work if you
try hard enough (in particular by allowing i2c-tiny-usb to claim
specific i2c bus number(s).) If you want your development system to
mimic the final hardware as closely as possible, this is the best
approach anyway.

> > different i2c-tiny-usb adapters on the same system and see the new code
> > instantiate the wrong devices...
> 
> I know about that, but it probes

It probes in the sense "check if a device is present", not in the sense
"check if the device there is really what the user told me." So very
easy to get wrong. Plus there is no universal probe method on I2C,
i2c_new_probed_device() uses a default heuristic which may not only
fail to detect a device's presence, but may even heavily confuse the
device in question. Usage of i2c_new_probed_device() should be limited
to very specific cases.

> and you don't have to use that parameter at all.

This has never been a good reason to accept every piece of code into
the kernel.

> I think some people can think for their self, 
> especially those how would use such a parameter.

This isn't the point. At least this is not my point. My point is, if we
let every developer add its own custom way of instantiating I2C devices
to fit their specific need of the day (and this is just one example
amongst others), we will end up with too many ways to achieve roughly
the same, and in the long run the duplicate code will diverge, bugs
will crop in, and we'll end up with an unmaintainable mess.

> > [1] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=7f508118b1c1f9856a1c899a2bd4867a962b0225
> 
> I think my patch looks nicier.

Certainly, that's not terribly difficult. The code we got rid of at
that time was horrid :( And the commit above was only the tip of the
Halloween iceberg.

I am not questioning the quality of your code, I did not even look at
it. I'm questioning the pertinence of adding yet another way to
instantiate i2c devices when we already have 4 which made everybody
else happy for the past 3 years AFAIK.

-- 
Jean Delvare
