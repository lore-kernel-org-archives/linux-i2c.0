From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: PROBLEM: modprobe hang at startup (3.8.x, 3.9.x, IBM x3550)
Date: Fri, 17 May 2013 10:49:28 +0200
Message-ID: <20130517104928.5b135a4f@endymion.delvare>
References: <1368408152.29197.140661229821177.2C1CC406@webmail.messagingengine.com>
	<20130514231626.GA12961@pyro.melbourne.osa>
	<20130515112044.753bb7bb@endymion.delvare>
	<20130515112741.GA23766@pyro.melbourne.osa>
	<20130515214923.036dabdb@endymion.delvare>
	<20130516034455.GA19452@pyro.melbourne.osa>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130516034455.GA19452-IBYGJlK4DBpn1Ubwjl4+/VPmBPO9Xwsk@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Norris <robn-4vTceeIZeJ0AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 16 May 2013 13:44:55 +1000, Robert Norris wrote:
> > Then do a simple read from a random address
> >   with:
> >   # i2cget 4 0x50 0x00
> >   (Adjust the bus number as needed.)
> >   I am curious if this will hang as well or only when accessing the
> >   clock chip at address 0x69.
> 
> Yep, that one hangs. The hung task handler picked it up after a few
> minutes.

Hmm, can you please dump the PCI configuration space of the SMBus
controller?

# /sbin/lspci -s 00:1f.3 -xxx

It might be that you have interrupts routed to SMI# instead of the
regular IRQ line. The driver is supposed to disable interrupt support
in that case, but I have never tested it.

Thanks,
-- 
Jean Delvare
