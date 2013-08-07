From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: i2c-i801 driver quit working in 3.8.11 (was: adt7475 driver quit
 working)
Date: Wed, 7 Aug 2013 12:25:56 -0700
Message-ID: <20130807192556.GA31395@roeck-us.net>
References: <CANQojO4jbSM=03WfJtw-iSNfexBNSt6GwRLpVSmBx_KrAa0bWQ@mail.gmail.com>
 <20130806192228.GB8246@roeck-us.net>
 <CANQojO74882h+oFJDrq2dsSC71NZHuyf2sjTzCr4a+VmPMLyVA@mail.gmail.com>
 <52026530.2080301@roeck-us.net>
 <CANQojO5B+7c+J=fxV-_mT=Y19Uy=4cW-83vnrphPkN5pmgc2YQ@mail.gmail.com>
 <20130807174801.GB1862@roeck-us.net>
 <CANQojO5QuoGSmmNYxxZ=0MhbZt0mEW-8n6kTxVSWuZ4p6NFw5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CANQojO5QuoGSmmNYxxZ=0MhbZt0mEW-8n6kTxVSWuZ4p6NFw5Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Soren Harward <stharward-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Aug 07, 2013 at 02:19:42PM -0400, Soren Harward wrote:
> Yeah, that fixed it.  Sensors are working properly now.
> 
> My computer is a Lenovo D10, which uses the Intel 5400 chipset.
> Here's the lspci dump for the SMBus controller:
> 
> root@jens:~# lspci -vv -s 0000:00:1f.3
> 00:1f.3 SMBus: Intel Corporation 631xESB/632xESB/3100 Chipset SMBus
> Controller (rev 09)
>         Subsystem: Lenovo Device 101d
>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin B routed to IRQ 23
>         Region 4: I/O ports at 1100 [size=32]
>         Kernel driver in use: i801_smbus
> 
> So what else can I do to help debug this?
> 
I copied the i2c mailing list and the i2c maintainer, and also changed the
subject to reflect the real problem. I don't really know what else you can do.
Maybe Jean has an idea, or someone else on the list.

One possibility is that the driver doesn't enable/use MSI interrupts.
Maybe that is causing trouble with your chipset. Another option might be
that there are subtle differences with this chipset, and the interrupt code
simply does not work with it.

Guenter

> 
> On Wed, Aug 7, 2013 at 1:48 PM, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrote:
> > Can you try reverting commit 6676a847d48ac48908cf467b42da9045b5463a6e ?
> >
> > [ Unless you are using an ASUS Z8 board, then it's more complicated ]
> >
> > Guenter
> >
> > On Wed, Aug 07, 2013 at 01:38:15PM -0400, Soren Harward wrote:
> >> The module is i2c-i801, so I guess that's the i801_smbus driver.
> >>
> >> On Wed, Aug 7, 2013 at 11:18 AM, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrote:
> >> > Thought so. What is the driver ?
> >> >
> >> > Thanks,
> >> > Guenter
> >> >
> >> >
> >> > On 08/07/2013 05:08 AM, Soren Harward wrote:
> >> >>
> >> >> Oops, I swapped kernel numbers. 3.6.11 was good, 3.8.13 is broken.
> >> >>
> >> >> It looks like a problem with i2c bus driver because i2cdetect also locks
> >> >> up when trying to read from the bus.  I'll go pester one of the I2C
> >> >> developers.
> >> >>
> >> >> --
> >> >> Soren Harward
> >> >>
> >> >> On Aug 6, 2013 3:22 PM, "Guenter Roeck" <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org
> >> >> <mailto:linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>> wrote:
> >> >>
> >> >>     On Tue, Aug 06, 2013 at 02:30:47PM -0400, Soren Harward wrote:
> >> >>      > When I upgraded from 3.6.13 to kernel 3.8.11 (I know it's old; I'm
> >> >>      > limited by some binary drivers that don't work in >=3.9), hardware
> >> >>      > monitoring thru my ADT7475 quit working.  The chip is still
> >> >>      > recognized, the driver creates the sysfs entries in
> >> >>      > /sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002e, but if I try to
> >> >>      > read any of the files (eg, "cat fan1_input"), the process just gets
> >> >>      > stuck in "disk wait" status forever.
> >> >>      >
> >> >>      > Is this a known bug that has since been fixed?  If not, what can I
> >> >> do
> >> >>      > to help fix it?
> >> >>      >
> >> >>
> >> >>     Problem is that v3.6.13 does not exist in mainline. Are you sure this
> >> >> is your
> >> >>     version ? Assuming it is 3.6.11 vs. 3.8.13, the only difference in the
> >> >> driver is
> >> >>     an added include of linux/jiffies.h, which should not cause any
> >> >> problems. It is
> >> >>     more likely a problem with the i2c bus driver. Can you let us know
> >> >> what driver
> >> >>     that is, and check if you have the same problem with another chip on
> >> >> the same bus
> >> >>     (eg an eeprom if there is one) ?
> >> >>
> >> >>     Thanks,
> >> >>     Guenter
> >> >>
> >> >
> >>
> >>
> >>
> >> --
> >> Soren Harward
> >>
> 
> 
> 
> -- 
> Soren Harward
> 
