From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: i2c-i801 driver quit working in 3.8.11
Date: Thu, 7 Aug 2014 09:52:25 -0700
Message-ID: <20140807165225.GB5203@roeck-us.net>
References: <20130806192228.GB8246@roeck-us.net>
 <CANQojO74882h+oFJDrq2dsSC71NZHuyf2sjTzCr4a+VmPMLyVA@mail.gmail.com>
 <52026530.2080301@roeck-us.net>
 <CANQojO5B+7c+J=fxV-_mT=Y19Uy=4cW-83vnrphPkN5pmgc2YQ@mail.gmail.com>
 <20130807174801.GB1862@roeck-us.net>
 <CANQojO5QuoGSmmNYxxZ=0MhbZt0mEW-8n6kTxVSWuZ4p6NFw5Q@mail.gmail.com>
 <20130807192556.GA31395@roeck-us.net>
 <20140807101147.34087264@endymion.delvare>
 <53E38AD9.5030708@roeck-us.net>
 <1407427494.4314.91.camel@chaos.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1407427494.4314.91.camel-H7Kp9ZFCxt/N0uC3ymp8PA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Soren Harward <stharward-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 07, 2014 at 06:04:54PM +0200, Jean Delvare wrote:
> Hi Guenter,
>=20
> Le Thursday 07 August 2014 =E0 07:19 -0700, Guenter Roeck a =E9crit :
> > On 08/07/2014 01:11 AM, Jean Delvare wrote:
> > > Guenter, I can confirm that the i2c-i801 driver only uses regular
> > > interrupts. The datasheet does not mention anything about MSI. Wh=
at
> > > makes you think the problem could be related to the lack of MSI s=
upport?
> >=20
> > Working for a company that does lots of weird and non-standard stuf=
f with PCIe
> > creates a state of constant paranoia ;-). For example, INTB / irq23=
 may be
> > used by some other chip and may not be handled properly, masking th=
e interrupt.
> > Really, I don't know. I have had instances at work where INTx didn'=
t work
> > and I _had_ to use MSI, that is all I can say.
>=20
> I had my share of MSI (and MSI-X) drama at work too, but in most case=
s
> the problem was in the MSI/MSI-X handling code and using legacy
> interrupts solved the problem (although at the expense of
> performance...)
>=20
> Anyway, my understanding is that using MSI requires support at the
> hardware level, you can't do that for any arbitrary PCI device, can y=
ou?
> As I said I saw no mention of MSI support for the Intel SMBus device =
in
> the datasheet, so I don't think this is possible, and thus I don't th=
ink
> this can be the issue.
>=20
As far as I recall, MSI support is mandatory in PCIe.

> However I found a few interesting interrupt-related bits which the
> i2c-i801 driver does not handle properly. I have patches almost ready=
,
> I'll post the soon.
>=20
> Speaking of "masking the interrupt", I am debugging another i2c-i801
> issue. On one system at work, I see the following in dmesg:
>=20
> [  601.485791] irq 18: nobody cared (try booting with the "irqpoll" o=
ption)
> [  601.489785] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G          I   =
  3.12.25-2-default #1
> [  601.489785] Hardware name: Supermicro X7DW3/X7DWN, BIOS 6.00 08/28=
/2007
> [  601.489785]  ffff880220d9574c ffffffff815096a7 ffff880220d956c0 ff=
ffffff810ad6ad
> [  601.489785]  ffff880220d956c0 0000000000000012 0000000000000000 ff=
ffffff810adb15
> [  601.489785]  0000000000000000 0000000000000000 0000000000000012 00=
00000000000000
> [  601.489785] Call Trace:
> [  601.489785]  [<ffffffff810044bd>] dump_trace+0x7d/0x2d0
> [  601.489785]  [<ffffffff810047a4>] show_stack_log_lvl+0x94/0x170
> [  601.489785]  [<ffffffff81005be1>] show_stack+0x21/0x50
> [  601.489785]  [<ffffffff815096a7>] dump_stack+0x41/0x51
> [  601.489785]  [<ffffffff810ad6ad>] __report_bad_irq+0x2d/0xc0
> [  601.489785]  [<ffffffff810adb15>] note_interrupt+0x1a5/0x260
> [  601.489785]  [<ffffffff810ab649>] handle_irq_event_percpu+0xc9/0x1=
b0
> [  601.489785]  [<ffffffff810ab762>] handle_irq_event+0x32/0x50
> [  601.489785]  [<ffffffff810ae5e1>] handle_fasteoi_irq+0x51/0xf0
> [  601.489785]  [<ffffffff8100439a>] handle_irq+0x1a/0x30
> [  601.489785]  [<ffffffff815198f5>] do_IRQ+0x45/0xb0
> [  601.489785]  [<ffffffff8150faad>] common_interrupt+0x6d/0x6d
> [  601.489785]  [<ffffffff8103f0c2>] native_safe_halt+0x2/0x10
> [  601.489785]  [<ffffffff8100b029>] default_idle+0x19/0xb0
> [  601.489785]  [<ffffffff810aab51>] cpu_startup_entry+0xe1/0x270
> [  601.489785]  [<ffffffff8103097a>] start_secondary+0x21a/0x2c0
> [  601.489785] handlers:
> [  601.489785] [<ffffffffa01ee220>] i801_isr [i2c_i801]
> [  601.489785] Disabling IRQ #18
>=20
> I suppose that the IRQ is shared with another device, for which no
> driver is loaded. I wonder if/how I can figure out which device this
> is. /proc/interrupts says:
>  18:          0      50001          0      49999          0          =
0          1          0   IO-APIC-fasteoi   i801_smbus
> and 100000 is the number of unhandled interrupts it takes to trigger =
the
> code which disables the interrupt (note_interrupt in
> kernel/irq/spurious.c.) So far so good.
>=20
You could just try to enable MSI in the driver. That won't solve the
unhandled interrupt problem, but it may help you discover the other
interrupt source. What happens if you do not load the i801 driver ?
Do you still see an unhandled interrupt ?

As for how to find the source of the unhandled interrupt - once you
find out, please let me know. I have a similar problem at work.

> But what I do not understand is that even after that, the i2c-i801
> driver is still working. It is very slow, it takes 100 ms to complete
> each command, which is even more than when using polling. And the fac=
t
> that the figures in /proc/interrupts do not increase, mean that IRQ 1=
8
> is really disabled. But it does not hang. However, looking at the cod=
e,
> it's using wait_event() to wait for the interrupt, so I think it shou=
ld
> hang there is interrupt is disabled.
>=20
> Can you (or anyone else) explain this mystery? I am most certainly
> missing something, maybe something obvious.
>=20
Not me, sorry. Time for some debug messages ?

Guenter
