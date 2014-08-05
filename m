From: dwalker-zu3NM2574RrQT0dZR+AlfA@public.gmane.org
Subject: Re: i2c-i801: Enable interrupts on ICH5/7/8/9/10
Date: Tue, 5 Aug 2014 17:14:33 +0000
Message-ID: <20140805171433.GA9589@fifo99.com>
References: <20140804175632.GA5288@fifo99.com>
 <20140804203604.02c74b22@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140804203604.02c74b22-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Aug 04, 2014 at 08:36:04PM +0200, Jean Delvare wrote:
> Hi Daniel,
> 
> Please note my new e-mail address.
> 
> On Mon, 4 Aug 2014 17:56:32 +0000, dwalker-zu3NM2574RrQT0dZR+AlfA@public.gmane.org wrote:
> > I had an issue with the i2c dev-interface. The executable runs i2c_smbus_write_word_data() and it hangs at
> > that point. The issues wasn't present in earlier kernels , so I was able to bisect this to ,
> > 
> > commit 29b608540b030d38a978c972cbe99d40efdb7267
> > Author: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > Date:   Tue Jul 24 14:13:59 2012 +0200
> >  
> >     i2c-i801: Enable interrupts on ICH5/7/8/9/10
> > 
> > 
> > The system I'm testing on is an ICH9 from and Intel BearLake.
> 
> I have had a few reports of problems with interrupts so far but could
> never find the time to track it down. Maybe now is the time.

It's up to you ..
 
> Please provide the output of:
> # lspci -s 00:1f.3 -vvv
> # grep i801_smbus /proc/interrupts

00:1f.3 SMBus: Intel Corporation 82801I (ICH9 Family) SMBus Controller (rev 02)
        Subsystem: Intel Corporation Device 7270
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin C routed to IRQ 18
        Region 0: Memory at cc227400 (64-bit, non-prefetchable) [size=256]
        Region 4: I/O ports at 8000 [size=32]
        Kernel driver in use: i801_smbus


"grep i801_smbus /proc/interrupts" had no output, might explain something.

So because of lack of an interrupt I test on the latest kernel. I was using v3.10 , but there wasn't a large 
difference in the i801 driver from v3.10 to v3.16. In the latest kernel the interrupt gets allocated, and the
test application I was using doesn't hang. So the problem is resolved ..

However, the ideas you had are valid, like adding the timeout .. Also there was no indication of a failed
interrupt allocation that I could see. I can see the code is suppose to catch if there's an error
requesting the interrupt, but I didn't get any of those messages, must have been another issues.

Daniel
