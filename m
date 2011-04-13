From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Decode dimms on dual socket machines
Date: Wed, 13 Apr 2011 13:45:14 +0200
Message-ID: <20110413134514.2a019889@endymion.delvare>
References: <4DA4250A.3060907@fuckner.net>
	<20110412132611.045ace21@endymion.delvare>
	<4DA44B05.906@fuckner.net>
	<20110412155345.4644e51c@endymion.delvare>
	<4DA53F22.5020105@gmx.de>
	<20110413103952.68bdb6fa@endymion.delvare>
	<4DA575C3.1050100@fuckner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4DA575C3.1050100-iWcS09LKDTLR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Fuckner <michael-iWcS09LKDTLR7s880joybQ@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hallo Michael,

On Wed, 13 Apr 2011 12:06:59 +0200, Michael Fuckner wrote:
> Supermicro just gave me the following information:
> 
> To access all SPDs, you have to pull low GPIO49 (IO_0x528 bit 17) first. 
> Then pull low GPIO52 (IO_0x528 bit 20) to access first CPU 
> memory(0x50~0x55); pull high GPIO52 to access 2nd CPU memory(0x50~0x55).

I am surprised because AllMEMDIMM.ini suggests that GPIO 53 and 52 are
used, not 47 and 52.

> I can't find anything about GPIO49/52,53 in Datasheet for 5500/5520 chipset
> http://www.intel.com/assets/pdf/datasheet/321328.pdf
> 
> So it is probably connected to ICH10
> http://www.intel.com/Assets/PDF/datasheet/319973.pdf
> 
> but I don't know how to use this information

My own workstation board happens to have a similar (but slightly
different) GPIO-based SMBus multiplexing scheme. I wanted to look into
it but could never find the time. Your request gave me an opportunity
to look into it again. As a first step, I've improved isadump and
isaset to support 32-bit I/O access:
http://marc.info/?l=lm-sensors&m=130264185604706&w=2
http://marc.info/?l=lm-sensors&m=130264189004750&w=2

With these two patches applied, you should be able to control the
multiplexer from user-space. First of all, check the base I/O address
of the GPIO registers, because the values provided by Supermicro are
off by 16 compared to what I have:

# setpci -s 00:1f.0 48.l

It returns 00000501 for me, for I/O base 0x500. If it is the same for
you, you can dump the GPIO registers with:

# isadump -f -L 0x500 64

Preliminary note: wrong setup of GPIO could have disastrous effects on
your hardware. If at any point you are unsure of what you're doing, you
better just stop and ask.

The operations described by Supermicro would then be achieved with the
following commands:

: Pull GPIO49 low
# isaset -f -L 0x538 0x00000000 0x00020000
: Pull GPIO52 low: 
# isaset -f -L 0x538 0x00000000 0x00100000
: Pull GPIO52 up: 
# isaset -f -L 0x538 0x00100000 0x00100000

Note the 0x538 when your Supermicro contact said 0x528. 0x528 would be
correct only if the I/O base is 0x4f0 instead of 0x500... but I'd be
surprised if it is the case.

Of course this is all a hack and the kernel drivers won't notice the
multiplexer change happening in their backs. So if you happen to have
the same number of memory modules for both CPUs, plugged in symmetrical
sockets, "sensors" (and "decode-dimms") will nicely report the values
from the currently selected bus segment, but you can't see all modules
at once. For this, proper multiplexing support in the kernel will be
needed, which is a lot more work. Patience...

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
