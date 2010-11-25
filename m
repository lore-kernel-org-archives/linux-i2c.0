From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH] i2c/i2c-dev: use dynamic minor allocation
Date: Thu, 25 Nov 2010 11:43:54 +0100
Message-ID: <4CEE3DEA.7040107@linutronix.de>
References: <1290633788-25767-1-git-send-email-bigeasy@linutronix.de> <20101124225745.403d8f5f@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101124225745.403d8f5f-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote:
> Hi Sebastian,
Hi Jean,

> On Wed, 24 Nov 2010 22:23:08 +0100, Sebastian Andrzej Siewior wrote:
>> Right now i2c adapter 5 becomes minor 5 allocated. This is fine as long
>> as no adapter becomes a number > 256 allocated.
> 
> Why would it be a problem to have a minor number > 256 (or more likely
> you meant > 255)? Minors beyond 8 bit are supported since quite some
> time, aren't they?

Argh. Now that you mention it. I knew it was 8bit and after looking it up
MINOR() was still 8bit. This was the userland export I was loking at. So
in-kernel MINOR() has 20bits. Replacing I2C_MINORS with MINORMASK should
do the job.

>> The Sodavile PCI driver uses (devfn << 3 | pci_bar) to come up with an
>> unique adapter number. So the first i2c adapter has the number 720.
> 
> If you know that the first adapter has the number 720, then you could
> simply use (devfn << 3 | pci_bar) - 720 as the adapter number. I don't
> know how many such PCI devices a system can have, but presumably the
> 256 minor limit would be sufficient.
Yup. But this device could be included on a different SoC with a different
PCI bus number and this hack could end up with a value <0.

> But my main question is: why do you want a unique (or you probably
> meant predictable - adapter numbers are already unique by design)
> adapter number in the first place? Other systems apparently are doing
> just fine without this.
Both. I use this number for the device id. This one has to remain unique
or sysfs goes crazy. So using the PCI number looked like a good idea.
The PXA I2C driver uses this number for the adapt number.
I needed this to be predictable in order to match match my board
description with the correct i2c controller. This is however no longer the
case because I use the device tree for this kind of information.
So other issue would be i2c-dev where userland wants always the same
device.

> Also, what if another i2c adapter driver comes up with its own idea of how
> adapters should be numbered, and its numbering scheme collides with
> your driver?
Too bad. I though that I will be on the safe side using using the PCI
slot+device number. This is not a problem for the device id just the
adapter number. For that I could add a flag to platform data to use
i2c_add_adapter instead of i2c_add_numbered_adapter. Not sure what I could
break if I change it unconditionally. Userland could still look up
sys/class/i2c-dev/i2c-X to find out which device it is talking to.
Any comments?

> Fixed i2c adapter numbers are already supported, but it's up to the
> platform initialization code to define them, not the i2c adapter driver.
I don't want platform init code.

>> This patch introduces dynamic minor allocation so the minor first
>> registered i2c adapter will be zero, next one one and so on. The name
>> which is exported to userland remains the same i.e. /dev/i2c-10 for
>> adapter number 10 (but its minor number may be zero and not 10).
> 
> Are there other subsystems doing this already?
Well, spi does it for instance. The userland interface gets spidevX.Y
where X is the SPI bus number and Y is the chip select number. The minor
for those is dynamically allocated.

> Systems with more than 32 I2C adapters already exist, so lowering to 32
> is not acceptable.

Ah, I haven't seen that comming.

Sebastian
