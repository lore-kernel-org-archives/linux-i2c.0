From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: i2c-i801: Enable interrupts on ICH5/7/8/9/10
Date: Wed, 6 Aug 2014 19:05:25 +0200
Message-ID: <20140806190525.615d012b@endymion.delvare>
References: <20140804175632.GA5288@fifo99.com>
	<20140804203604.02c74b22@endymion.delvare>
	<20140805171433.GA9589@fifo99.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140805171433.GA9589-zu3NM2574RrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwalker-zu3NM2574RrQT0dZR+AlfA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Daniel,

On Tue, 5 Aug 2014 17:14:33 +0000, dwalker-zu3NM2574RrQT0dZR+AlfA@public.gmane.org wrote:
> On Mon, Aug 04, 2014 at 08:36:04PM +0200, Jean Delvare wrote:
> > On Mon, 4 Aug 2014 17:56:32 +0000, dwalker-zu3NM2574RrQT0dZR+AlfA@public.gmane.org wrote:
> > > I had an issue with the i2c dev-interface. The executable runs i2c_smbus_write_word_data() and it hangs at
> > > that point. The issues wasn't present in earlier kernels , so I was able to bisect this to ,
> > > 
> > > commit 29b608540b030d38a978c972cbe99d40efdb7267
> > > Author: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > > Date:   Tue Jul 24 14:13:59 2012 +0200
> > >  
> > >     i2c-i801: Enable interrupts on ICH5/7/8/9/10
> > > 
> > > 
> > > The system I'm testing on is an ICH9 from and Intel BearLake.
> > 
> > Please provide the output of:
> > # lspci -s 00:1f.3 -vvv
> > # grep i801_smbus /proc/interrupts
> 
> 00:1f.3 SMBus: Intel Corporation 82801I (ICH9 Family) SMBus Controller (rev 02)
>         Subsystem: Intel Corporation Device 7270
>         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin C routed to IRQ 18
>         Region 0: Memory at cc227400 (64-bit, non-prefetchable) [size=256]
>         Region 4: I/O ports at 8000 [size=32]
>         Kernel driver in use: i801_smbus

Looks about right, I have some differing PCI control flags but I have
no idea if that's relevant.

> "grep i801_smbus /proc/interrupts" had no output, might explain something.

I didn't expect that. Does IRQ 18 show up at all in /proc/interrupts,
or is it missing too?

Also, the output of the two commands above was on the non-working v3.10
kernel, where the i2c_smbus_write_word_data() hung, right? Was it
before the hang, or after the hang?

> So because of lack of an interrupt I test on the latest kernel. I was using v3.10 , but there wasn't a large 
> difference in the i801 driver from v3.10 to v3.16. In the latest kernel the interrupt gets allocated, and the
> test application I was using doesn't hang. So the problem is resolved ..

This is interesting, you can call it resolved but I wouldn't call it
explained, which is what I would prefer, honestly.

> However, the ideas you had are valid, like adding the timeout .. Also there was no indication of a failed
> interrupt allocation that I could see. I can see the code is suppose to catch if there's an error
> requesting the interrupt, but I didn't get any of those messages, must have been another issues.

I've never received any report of failed interrupt request. If this
ever happened, it should be handled properly by the driver anyway, that
is, no hang nor crash. The driver would refuse to bind to the device -
which I would admit is a bit harsh. Reverting to polling would make
more sense, I'll prepare a patch doing that.

Now I would like to summarize my understanding of your test results:

* You were using kernel v3.10 and i2c_smbus_write_word_data() hung.
* You bisected it to the faulty commit which was merged in kernel v3.6
  (29b60854), which means that all kernels from v3.6 to v3.10
  inclusive, hung.
* You tried v3.16 and it worked just fine.

Did I understand all that correctly?

If so I would have one more question, and a request:

* Were the hang in v3.10, and the absence of hang in v3.16, 100%
  reproducible?

* If the answer is yes for both, would you be kind enough to bisect
  from v3.10 to v3.16 to find out which commit fixed it? Knowing this
  would make me feel better, and this would also give us an opportunity
  to backport the commit in question to the stable kernel branches which
  still need it.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
