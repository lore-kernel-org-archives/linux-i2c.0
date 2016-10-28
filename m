From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [Linux-parport] True Parallel Port Interface for Bit-banging?
Date: Sat, 29 Oct 2016 01:12:10 +0200
Message-ID: <5461ac01-6054-e222-f707-0b475c24276d@maciej.szmigiero.name>
References: <580F4042.5070201@laposte.net> <20161025120951.GL1597@katana>
 <580F6A1D.4000409@laposte.net> <20161025142935.GA2875@katana>
 <580F72AF.9070900@laposte.net>
 <7bd6ea08-361e-316f-be7f-d400b59aec0d@maciej.szmigiero.name>
 <581327AC.8060404@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from vps-vb.mhejs.net ([37.28.154.113]:35881 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753245AbcJ1XMS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 28 Oct 2016 19:12:18 -0400
In-Reply-To: <581327AC.8060404@laposte.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sebastian Frias <sf84@laposte.net>
Cc: Wolfram Sang <wsa@the-dreams.de>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-parport@lists.infradead.org, philb@gnu.org, tim@cyberelk.net, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org

On 28.10.2016 12:25, Sebastian Frias wrote:
> On 10/26/2016 02:04 AM, Maciej S. Szmigiero wrote:
>>
>> I don't have experience with bit-banging parallel port but I do have
>> some with bit-banging PC serial ports (which should be very similar)
>> and can confirm that old DOS software can be *very* fragile with regard
>> to timing.
>> I have tried dosemu, dosbox and as far I remember also VirtualBox
>> with an old, DOS car service app.
>> Wasn't able to make it communicate until I booted true DOS.
>> That machine had old-style ISA serial ports so it was possible.
>>
> 
> Thanks for sharing your experience.
> I think it should be related to the latencies Wolfram discussed.

And probably also baudrate UART tweaks than Jan wrote about.

>> You also have asked previously whether laptop port would work.
>> On my current HP Elitebook ports of both types are wired to Super IO,
>> and using PC standard IO port and interrupt numbers.
> 
> Would you mind sharing the laptop's model?

This is Elitebook model 8570p.

> There are a bunch of
> Elitebooks and maybe not all have the ports wired.
> Does your laptop has the Parallel Port on the docking or on the laptop
> itself?

Only a serial port socket is built-it, parallel port socket is
available only via a port replicator.

According to description of this replicator it is compatible with
a lot of different Elitebooks and Probooks:
http://h30094.www3.hp.com/product.aspx?sku=10432928&mfg_part=A7E34AA&pagemode=ca

I wasn't able find any note in this replicator description that port
availability depends on connected laptop model.
You can try to search for particular laptop model schematics, even
if it is available only for sale sometimes there is a preview
page with block diagram which clearly show where the parallel port
is connected (this is true for my laptop model for example).

However, whether the port is on standard I/O address and interrupt
line requires some more digging.

>> I also remember that at least on ThinkPads and HP Compaqs that I had
>> contact with (these were laptops from 10+ years ago) both serial and
>> parallel ports were wired to Super IO chip (including ones available
>> only via port replicator).
>> So they were also at PC standard resources.
>>
> 
> Yes, it appears that Thinkad T42 could work:
> 
> https://forum.linuxcnc.org/forum/49-basic-configuration/15999-thinkpad-t42-parallel-port-not-working
> 
>> However, other issue is that sometimes such ports are inactive by
>> default (don't respond) until enabled by PnP.
>>
>> This is also a problem with PCMCIA cards - they are disabled
>> by default.
> 
> Do you know the command to enable them thru PnP? Shouldn't loading
> the kernel module be enough? Or is it the other way around and 
> enabling thru PnP triggers the kernel module load process?

If you want to use them under Linux then everything should be taken
care of by kernel's PnP support.
It can be problem if you want to use them under pure DOS.

>> I have Argosy 2xRS232 PCMCIA card and remember it came with
>> DOS driver which could enable them on I/O port close to standard
>> one - this was one of their major selling points.
>> So your ExpressCard would probably need similar software.
>>
> 
> Thanks for the pointer.

Maciej
