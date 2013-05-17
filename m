From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: PROBLEM: modprobe hang at startup (3.8.x, 3.9.x, IBM x3550)
Date: Fri, 17 May 2013 12:56:35 +0200
Message-ID: <20130517125635.67c84437@endymion.delvare>
References: <1368408152.29197.140661229821177.2C1CC406@webmail.messagingengine.com>
	<20130514231626.GA12961@pyro.melbourne.osa>
	<20130515112044.753bb7bb@endymion.delvare>
	<20130515112741.GA23766@pyro.melbourne.osa>
	<20130515214923.036dabdb@endymion.delvare>
	<20130516034455.GA19452@pyro.melbourne.osa>
	<20130517104928.5b135a4f@endymion.delvare>
	<20130517102706.GC28229@pyro.melbourne.osa>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130517102706.GC28229-IBYGJlK4DBpn1Ubwjl4+/VPmBPO9Xwsk@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Norris <robn-4vTceeIZeJ0AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 17 May 2013 20:27:06 +1000, Robert Norris wrote:
> On Fri, May 17, 2013 at 10:49:28AM +0200, Jean Delvare wrote:
> > Hmm, can you please dump the PCI configuration space of the SMBus
> > controller?
> > 
> > # /sbin/lspci -s 00:1f.3 -xxx
> 
> 00:1f.3 SMBus: Intel Corporation 631xESB/632xESB/3100 Chipset SMBus Controller (rev 09)
> 00: 86 80 9b 26 41 05 80 02 09 00 05 0c 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 41 04 00 00 00 00 00 00 00 00 00 00 14 10 dd 02
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00 00
> 40: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
      ^^
Hmm, no, SMI# isn't enabled. Wrong theory.

-- 
Jean Delvare
