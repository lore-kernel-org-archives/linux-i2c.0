From: Sebastian Frias <sf84@laposte.net>
Subject: Re: [Linux-parport] True Parallel Port Interface for Bit-banging?
Date: Fri, 28 Oct 2016 12:25:48 +0200
Message-ID: <581327AC.8060404@laposte.net>
References: <580F4042.5070201@laposte.net> <20161025120951.GL1597@katana>
 <580F6A1D.4000409@laposte.net> <20161025142935.GA2875@katana>
 <580F72AF.9070900@laposte.net>
 <7bd6ea08-361e-316f-be7f-d400b59aec0d@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtpoutz29.laposte.net ([194.117.213.104]:58737 "EHLO
        smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752497AbcJ1KZw (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 28 Oct 2016 06:25:52 -0400
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout017 (Postfix) with ESMTP id 8DA4EA01A2B
        for <linux-i2c@vger.kernel.org>; Fri, 28 Oct 2016 12:25:49 +0200 (CEST)
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout017 (Postfix) with ESMTP id 80164A01F6E
        for <linux-i2c@vger.kernel.org>; Fri, 28 Oct 2016 12:25:49 +0200 (CEST)
Received: from lpn-prd-vrin003 (lpn-prd-vrin003.prosodie [10.128.63.4])
        by lpn-prd-vrout017 (Postfix) with ESMTP id 7DB5CA01A2B
        for <linux-i2c@vger.kernel.org>; Fri, 28 Oct 2016 12:25:49 +0200 (CEST)
Received: from lpn-prd-vrin003 (localhost [127.0.0.1])
        by lpn-prd-vrin003 (Postfix) with ESMTP id 6945748DFEE
        for <linux-i2c@vger.kernel.org>; Fri, 28 Oct 2016 12:25:49 +0200 (CEST)
In-Reply-To: <7bd6ea08-361e-316f-be7f-d400b59aec0d@maciej.szmigiero.name>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Wolfram Sang <wsa@the-dreams.de>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-parport@lists.infradead.org, philb@gnu.org, tim@cyberelk.net, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org

On 10/26/2016 02:04 AM, Maciej S. Szmigiero wrote:
> 
> I don't have experience with bit-banging parallel port but I do have
> some with bit-banging PC serial ports (which should be very similar)
> and can confirm that old DOS software can be *very* fragile with regard
> to timing.
> I have tried dosemu, dosbox and as far I remember also VirtualBox
> with an old, DOS car service app.
> Wasn't able to make it communicate until I booted true DOS.
> That machine had old-style ISA serial ports so it was possible.
> 

Thanks for sharing your experience.
I think it should be related to the latencies Wolfram discussed.

> You also have asked previously whether laptop port would work.
> On my current HP Elitebook ports of both types are wired to Super IO,
> and using PC standard IO port and interrupt numbers.

Would you mind sharing the laptop's model? There are a bunch of
Elitebooks and maybe not all have the ports wired.
Does your laptop has the Parallel Port on the docking or on the laptop
itself?

> 
> I also remember that at least on ThinkPads and HP Compaqs that I had
> contact with (these were laptops from 10+ years ago) both serial and
> parallel ports were wired to Super IO chip (including ones available
> only via port replicator).
> So they were also at PC standard resources.
> 

Yes, it appears that Thinkad T42 could work:

https://forum.linuxcnc.org/forum/49-basic-configuration/15999-thinkpad-t42-parallel-port-not-working

> However, other issue is that sometimes such ports are inactive by
> default (don't respond) until enabled by PnP.
> 
> This is also a problem with PCMCIA cards - they are disabled
> by default.

Do you know the command to enable them thru PnP? Shouldn't loading
the kernel module be enough? Or is it the other way around and 
enabling thru PnP triggers the kernel module load process?

> I have Argosy 2xRS232 PCMCIA card and remember it came with
> DOS driver which could enable them on I/O port close to standard
> one - this was one of their major selling points.
> So your ExpressCard would probably need similar software.
> 

Thanks for the pointer.
