From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [i2c] [PATCH 0/5] Version 17, series to add device tree naming
 to i2c
Date: Sun, 13 Jan 2008 16:09:46 +0100
Message-ID: <20080113160946.5cddc813@hyperion.delvare>
References: <20071220044136.20091.70984.stgit@terra.home>
	<20080111095638.775670ed@hyperion.delvare>
	<9e4733910801110752k57f1fd7crd5f143900fc64f0b@mail.gmail.com>
	<20080111201550.12abb02c@hyperion.delvare>
	<9e4733910801111216g7dfee16ev72ec3c58e5d6c746@mail.gmail.com>
	<20080112100835.616d6bd9@hyperion.delvare>
	<9e4733910801120800g5b13c84u8720442fc8551339@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752970AbYAMPJ5@vger.kernel.org>
In-Reply-To: <9e4733910801120800g5b13c84u8720442fc8551339@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: i2c@lm-sensors.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Jon,

On Sat, 12 Jan 2008 11:00:31 -0500, Jon Smirl wrote:
> On 1/12/08, Jean Delvare wrote:
> > What I meant is that the translation from Open Firmware device name to
> > Linux device name could happen in different ways. Making module aliases
> > out of the is one possibility but this is not the only one.
> >
> > I am curious why the translation could not happen "offline". As I
> > understand it, you're getting the device names from these .dts files.
> > However you're not parsing them in the kernel directly, are you? I
> > presume that you have some tool that converts these files into C code
> > that the kernel can use? This conversion tool could translate the names.
> 
> Those dts files are for embedded devices that were specifically
> developed for Linux. All of the PowerPC Macs in the world have a
> device tree in ROM that was developed by Apple following the Open
> Firmware standard. Same thing for Sun boxes, but I'm not working on
> those.

OK. So basically we have to handle two different cases here, trees that
come from the .dts files and trees that are read from ROMs, right?
Does this mean that .dts files are compiled to some binary format to
look like what is in the ROMs? Is there kernel code that parses this?
Please explain how both types are handled by the kernel. I need to
understand how this works before I can decide where the OF names ->
Linux names translation can happen.

> The kernel has an existing mechanism for handling translations like
> these, the alias scheme.

That we agree on. My concern here is that you want to replace the Linux
names of i2c devices by OF names, without realizing that the Linux
names have a use outside of the kernel. We can't just replace them like
that, it would break some user-space applications. That's the reason
why I believe that it would make more sense to translate from OF names
to Linux names early in the process, so that the kernel, and thus
user-space applications, always handle and see the Linux names,
independently of the platform. I'm asking questions in order to figure
out whether and how this could be achieved.

> Currently developers add entries to the table in their private builds
> for the i2c devices they are using. Another way to avoid adding a
> table entry is to create a platform device in the platform code. But
> this support is being extended to audio codecs too. There are hundreds
> of audio codecs.
> 
> The whole purpose of this code is to dynamically load the correct i2c
> and audio drivers by reading the device tree instead of having static
> i2s/codec devices for every possible platform combination.

I2C driver autoloading is already implemented, and works. Just not the
way you expected, but it works.

Replacing this mechanism with standard aliases is IMHO a good idea, it
makes the code cleaner and also more similar to what the rest of the
kernel does, which is always nice.

However, having a module aliasing mechanism for i2c drivers does NOT
require that OF names are used. We could implement aliasing using Linux
device names. Note that I have no problem with using OF names for
aliasing, however it should not break applications that currently know
the I2C devices by their Linux name.

-- 
Jean Delvare
