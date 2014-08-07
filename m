From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: i2c-i801 driver quit working in 3.8.11
Date: Thu, 07 Aug 2014 18:04:54 +0200
Message-ID: <1407427494.4314.91.camel@chaos.site>
References: <CANQojO4jbSM=03WfJtw-iSNfexBNSt6GwRLpVSmBx_KrAa0bWQ@mail.gmail.com>
	 <20130806192228.GB8246@roeck-us.net>
	 <CANQojO74882h+oFJDrq2dsSC71NZHuyf2sjTzCr4a+VmPMLyVA@mail.gmail.com>
	 <52026530.2080301@roeck-us.net>
	 <CANQojO5B+7c+J=fxV-_mT=Y19Uy=4cW-83vnrphPkN5pmgc2YQ@mail.gmail.com>
	 <20130807174801.GB1862@roeck-us.net>
	 <CANQojO5QuoGSmmNYxxZ=0MhbZt0mEW-8n6kTxVSWuZ4p6NFw5Q@mail.gmail.com>
	 <20130807192556.GA31395@roeck-us.net>
	 <20140807101147.34087264@endymion.delvare>  <53E38AD9.5030708@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53E38AD9.5030708-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Soren Harward <stharward-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Guenter,

Le Thursday 07 August 2014 =C3=A0 07:19 -0700, Guenter Roeck a =C3=A9cr=
it :
> On 08/07/2014 01:11 AM, Jean Delvare wrote:
> > Guenter, I can confirm that the i2c-i801 driver only uses regular
> > interrupts. The datasheet does not mention anything about MSI. What
> > makes you think the problem could be related to the lack of MSI sup=
port?
>=20
> Working for a company that does lots of weird and non-standard stuff =
with PCIe
> creates a state of constant paranoia ;-). For example, INTB / irq23 m=
ay be
> used by some other chip and may not be handled properly, masking the =
interrupt.
> Really, I don't know. I have had instances at work where INTx didn't =
work
> and I _had_ to use MSI, that is all I can say.

I had my share of MSI (and MSI-X) drama at work too, but in most cases
the problem was in the MSI/MSI-X handling code and using legacy
interrupts solved the problem (although at the expense of
performance...)

Anyway, my understanding is that using MSI requires support at the
hardware level, you can't do that for any arbitrary PCI device, can you=
?
As I said I saw no mention of MSI support for the Intel SMBus device in
the datasheet, so I don't think this is possible, and thus I don't thin=
k
this can be the issue.

However I found a few interesting interrupt-related bits which the
i2c-i801 driver does not handle properly. I have patches almost ready,
I'll post the soon.

Speaking of "masking the interrupt", I am debugging another i2c-i801
issue. On one system at work, I see the following in dmesg:

[  601.485791] irq 18: nobody cared (try booting with the "irqpoll" opt=
ion)
[  601.489785] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G          I     =
3.12.25-2-default #1
[  601.489785] Hardware name: Supermicro X7DW3/X7DWN, BIOS 6.00 08/28/2=
007
[  601.489785]  ffff880220d9574c ffffffff815096a7 ffff880220d956c0 ffff=
ffff810ad6ad
[  601.489785]  ffff880220d956c0 0000000000000012 0000000000000000 ffff=
ffff810adb15
[  601.489785]  0000000000000000 0000000000000000 0000000000000012 0000=
000000000000
[  601.489785] Call Trace:
[  601.489785]  [<ffffffff810044bd>] dump_trace+0x7d/0x2d0
[  601.489785]  [<ffffffff810047a4>] show_stack_log_lvl+0x94/0x170
[  601.489785]  [<ffffffff81005be1>] show_stack+0x21/0x50
[  601.489785]  [<ffffffff815096a7>] dump_stack+0x41/0x51
[  601.489785]  [<ffffffff810ad6ad>] __report_bad_irq+0x2d/0xc0
[  601.489785]  [<ffffffff810adb15>] note_interrupt+0x1a5/0x260
[  601.489785]  [<ffffffff810ab649>] handle_irq_event_percpu+0xc9/0x1b0
[  601.489785]  [<ffffffff810ab762>] handle_irq_event+0x32/0x50
[  601.489785]  [<ffffffff810ae5e1>] handle_fasteoi_irq+0x51/0xf0
[  601.489785]  [<ffffffff8100439a>] handle_irq+0x1a/0x30
[  601.489785]  [<ffffffff815198f5>] do_IRQ+0x45/0xb0
[  601.489785]  [<ffffffff8150faad>] common_interrupt+0x6d/0x6d
[  601.489785]  [<ffffffff8103f0c2>] native_safe_halt+0x2/0x10
[  601.489785]  [<ffffffff8100b029>] default_idle+0x19/0xb0
[  601.489785]  [<ffffffff810aab51>] cpu_startup_entry+0xe1/0x270
[  601.489785]  [<ffffffff8103097a>] start_secondary+0x21a/0x2c0
[  601.489785] handlers:
[  601.489785] [<ffffffffa01ee220>] i801_isr [i2c_i801]
[  601.489785] Disabling IRQ #18

I suppose that the IRQ is shared with another device, for which no
driver is loaded. I wonder if/how I can figure out which device this
is. /proc/interrupts says:
 18:          0      50001          0      49999          0          0 =
         1          0   IO-APIC-fasteoi   i801_smbus
and 100000 is the number of unhandled interrupts it takes to trigger th=
e
code which disables the interrupt (note_interrupt in
kernel/irq/spurious.c.) So far so good.

But what I do not understand is that even after that, the i2c-i801
driver is still working. It is very slow, it takes 100 ms to complete
each command, which is even more than when using polling. And the fact
that the figures in /proc/interrupts do not increase, mean that IRQ 18
is really disabled. But it does not hang. However, looking at the code,
it's using wait_event() to wait for the interrupt, so I think it should
hang there is interrupt is disabled.

Can you (or anyone else) explain this mystery? I am most certainly
missing something, maybe something obvious.

--=20
Jean Delvare
SUSE L3 Support
