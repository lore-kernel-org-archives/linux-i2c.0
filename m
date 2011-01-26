From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Identifying i2c devices on Asus P8P67 sandybridge motherboard
Date: Wed, 26 Jan 2011 22:34:30 +0100
Message-ID: <20110126223430.5d68a74d@endymion.delvare>
References: <4D3EF4C0.1090008@cfl.rr.com>
	<20110125174246.5061f881@endymion.delvare>
	<4D3F622B.9060003@cfl.rr.com>
	<20110126092257.7b1243dd@endymion.delvare>
	<4D4032CC.5010008@cfl.rr.com>
	<4D40866F.4080102@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D40866F.4080102-3tLf1voIkJTQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phillip Susi <psusi-3tLf1voIkJTQT0dZR+AlfA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Phillip,

On Wed, 26 Jan 2011 15:39:11 -0500, Phillip Susi wrote:
> I have gotten ahold of the data sheet for the chip so hopefully will be
> able to write a driver for it, but maybe we should move this
> conversation to the lm-sensors mailing list?

Yes, definitely.

> Before we do though, I sill have one more question about the i2c bus.
> My understanding is that simple i2c devices use fixed addresses, like
> the SPD EEPROMs, but SMBus devices initially respond to a broadcast
> address where they can be detected and dynamically assigned an address.

Things aren't that simple. SMBus devices _can_, optionally, reply to
the SMBus ARP address (0x61) for identification and/or dynamic address
allocation. They don't have to, and I've never seen any hardware
monitoring ASIC requiring this (all I've seen start with a suitable
static address.)

>  Is there a tool that can perform such a reset and enumeration that
> could give better identification of those two unknown devices, should

No, there is no such tool. Proper SMBus ARP support would be done by
the kernel, but it is not yet implemented on Linux.

> they be smbus compatible and not just i2c?  When I tried reading them
> with i2c-dump I just got a bunch of XXs.

Even for the EEPROMs? This would be strange. OTOH this would explain
why decode-dimms did not work. But OTOH it would be strange that
i2cdetect would have worked if the SMBus isn't properly supported...

Could you please try i2cdetect again? It is possible that the detection
somehow confused your SMBus (at an address >= 0x6e), in which case
i2cdetect will no longer work. This is usually fixed by a cold boot of
the system. You can also look for i2c-i801 related error messages in
your kernel logs.

-- 
Jean Delvare
