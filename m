From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: i2c-i801 driver quit working in 3.8.11
Date: Thu, 7 Aug 2014 10:11:47 +0200
Message-ID: <20140807101147.34087264@endymion.delvare>
References: <CANQojO4jbSM=03WfJtw-iSNfexBNSt6GwRLpVSmBx_KrAa0bWQ@mail.gmail.com>
	<20130806192228.GB8246@roeck-us.net>
	<CANQojO74882h+oFJDrq2dsSC71NZHuyf2sjTzCr4a+VmPMLyVA@mail.gmail.com>
	<52026530.2080301@roeck-us.net>
	<CANQojO5B+7c+J=fxV-_mT=Y19Uy=4cW-83vnrphPkN5pmgc2YQ@mail.gmail.com>
	<20130807174801.GB1862@roeck-us.net>
	<CANQojO5QuoGSmmNYxxZ=0MhbZt0mEW-8n6kTxVSWuZ4p6NFw5Q@mail.gmail.com>
	<20130807192556.GA31395@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130807192556.GA31395-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Soren Harward <stharward-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Guenter, Soren,

Sorry for the late reply. Yes, one year, no kidding :(

On Wed, 7 Aug 2013 12:25:56 -0700, Guenter Roeck wrote:
> On Wed, Aug 07, 2013 at 02:19:42PM -0400, Soren Harward wrote:
> > Yeah, that fixed it.  Sensors are working properly now.
> > 
> > My computer is a Lenovo D10, which uses the Intel 5400 chipset.
> > Here's the lspci dump for the SMBus controller:
> > 
> > root@jens:~# lspci -vv -s 0000:00:1f.3
> > 00:1f.3 SMBus: Intel Corporation 631xESB/632xESB/3100 Chipset SMBus
> > Controller (rev 09)
> >         Subsystem: Lenovo Device 101d
> >         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B- DisINTx-
> >         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
> > >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> >         Interrupt: pin B routed to IRQ 23
> >         Region 4: I/O ports at 1100 [size=32]
> >         Kernel driver in use: i801_smbus
> > 
> > So what else can I do to help debug this?
>
> I copied the i2c mailing list and the i2c maintainer, and also changed the
> subject to reflect the real problem. I don't really know what else you cMSIan do.
> Maybe Jean has an idea, or someone else on the list.

The interrupt code in i2c-i801 has worked for a majority of users and
brought up major performance improvements. So I'm not going to revert
it. However I really would like to understand the few failure reports
we had, and hopefully fix them.

Soren, what's the status on your side? Are you still running a kernel
with commit 6676a847 reverted? Note that you can also disable interrupt
support in i2c-i801 manually by passing option disable_features=0x10 to
the driver.

Also I had one report of a problem with the same chipset you are using,
and the reporter claims that kernel v3.16 no longer has the problem. We
don't know why yet, but it might be worth a try.

> One possibility is that the driver doesn't enable/use MSI interrupts.
> Maybe that is causing trouble with your chipset. Another option might be
> that there are subtle differences with this chipset, and the interrupt code
> simply does not work with it.

Guenter, I can confirm that the i2c-i801 driver only uses regular
interrupts. The datasheet does not mention anything about MSI. What
makes you think the problem could be related to the lack of MSI support?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
