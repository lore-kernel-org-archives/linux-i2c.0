From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c/i2c-dev: use dynamic minor allocation
Date: Thu, 25 Nov 2010 22:52:46 +0100
Message-ID: <20101125225246.59931602@endymion.delvare>
References: <1290633788-25767-1-git-send-email-bigeasy@linutronix.de>
	<20101124225745.403d8f5f@endymion.delvare>
	<4CEE3DEA.7040107@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CEE3DEA.7040107-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Sebastian,

On Thu, 25 Nov 2010 11:43:54 +0100, Sebastian Andrzej Siewior wrote:
> Jean Delvare wrote:
> > On Wed, 24 Nov 2010 22:23:08 +0100, Sebastian Andrzej Siewior wrote:
> >> Right now i2c adapter 5 becomes minor 5 allocated. This is fine as long
> >> as no adapter becomes a number > 256 allocated.
> > 
> > Why would it be a problem to have a minor number > 256 (or more likely
> > you meant > 255)? Minors beyond 8 bit are supported since quite some
> > time, aren't they?
> 
> Argh. Now that you mention it. I knew it was 8bit and after looking it up
> MINOR() was still 8bit. This was the userland export I was loking at. So
> in-kernel MINOR() has 20bits. Replacing I2C_MINORS with MINORMASK should
> do the job.

... but would require updating i2c-tools. That being said, we probably
want to do that anyway, as this limit is pretty arbitrary and doesn't
add any value.

> >> The Sodavile PCI driver uses (devfn << 3 | pci_bar) to come up with an
> >> unique adapter number. So the first i2c adapter has the number 720.
> > 
> > If you know that the first adapter has the number 720, then you could
> > simply use (devfn << 3 | pci_bar) - 720 as the adapter number. I don't
> > know how many such PCI devices a system can have, but presumably the
> > 256 minor limit would be sufficient.
>
> Yup. But this device could be included on a different SoC with a different
> PCI bus number and this hack could end up with a value <0.

Good point.

> > But my main question is: why do you want a unique (or you probably
> > meant predictable - adapter numbers are already unique by design)
> > adapter number in the first place? Other systems apparently are doing
> > just fine without this.
>
> Both. I use this number for the device id. This one has to remain unique
> or sysfs goes crazy.

Which "device id" are you talking about, please? Of course sysfs
doesn't accept duplicate entries, but as I said already, uniqueness is
already guaranteed by i2c-dev. Your problem is predictability.

> So using the PCI number looked like a good idea.

It's one idea amongst others, and it doesn't strike me as particularly
good, because it works only by accident: you lost uniqueness while
adding predictability.

> The PXA I2C driver uses this number for the adapt number.

I got that, thanks. Otherwise you wouldn't be worried about i2c-dev.

> I needed this to be predictable in order to match match my board
> description with the correct i2c controller.

Precisions, please. "Match my board description" is awfully vague.
Don't hesitate to be technical, I'm sure I can understand you ;)

> This is however no longer the
> case because I use the device tree for this kind of information.

"This kind of information" is again too vague to be helpful.

> So other issue would be i2c-dev where userland wants always the same
> device.

This shouldn't be an issue. i2c tools support passing adapters by name,
so all your driver must do is make sure every i2c adapter will have its
own, specific name. The traditional method is to include the base
address, but PCI devfn and BAR would work too.

> > Also, what if another i2c adapter driver comes up with its own idea of how
> > adapters should be numbered, and its numbering scheme collides with
> > your driver?
>
> Too bad. I though that I will be on the safe side using using the PCI
> slot+device number.

This can't be safe until all devices in the world are PCI devices and
all i2c drivers agree to stick to this rule (i.e. it is enforced by
i2c-core.) This isn't going to happen anytime soon, I'm afraid.

> This is not a problem for the device id just the adapter number.

I have no idea what you mean. Please explain.

> For that I could add a flag to platform data to use
> i2c_add_adapter instead of i2c_add_numbered_adapter. Not sure what I could

So you have platform data? Where does it come from?

> break if I change it unconditionally. Userland could still look up
> sys/class/i2c-dev/i2c-X to find out which device it is talking to.
> Any comments?

I can't comment on something I don't understand, sorry. Please describe
actual use cases in detail, otherwise I can't help you.

> > Fixed i2c adapter numbers are already supported, but it's up to the
> > platform initialization code to define them, not the i2c adapter driver.
>
> I don't want platform init code.

Why? This is what (almost) everybody does when predictable i2c adapter
numbers are needed. And you said you have platform data, so presumably
you already have some form of platform init code (even if it's generic
code with a custom device tree.)

The alternative is to call i2c_new_device() in the i2c bus driver
directly, but this could become messy quickly if more people start
doing it.

> >> This patch introduces dynamic minor allocation so the minor first
> >> registered i2c adapter will be zero, next one one and so on. The name
> >> which is exported to userland remains the same i.e. /dev/i2c-10 for
> >> adapter number 10 (but its minor number may be zero and not 10).
> > 
> > Are there other subsystems doing this already?
>
> Well, spi does it for instance. The userland interface gets spidevX.Y
> where X is the SPI bus number and Y is the chip select number. The minor
> for those is dynamically allocated.

I didn't know SPI was using per-device dev nodes. Of course static
nodes don't work well in that case.

> > Systems with more than 32 I2C adapters already exist, so lowering to 32
> > is not acceptable.
> 
> Ah, I haven't seen that comming.

In all honesty, I'm not sure if I really saw such a system yet. I seem
to remember so but I can't find a trace again. But seeing this:

http://www.spinics.net/lists/lm-sensors/msg30206.html

it would only take 2 Intel graphics chips and a TV adapter to reach 34
i2c adapters. And with multiplexing support now available, consuming i2c
adapter numbers will be easier than ever. So setting 32 as a limit is
no way to go.

-- 
Jean Delvare
