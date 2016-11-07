From: Sebastian Frias <sf84@laposte.net>
Subject: Re: [Linux-parport] True Parallel Port Interface for Bit-banging?
Date: Mon, 7 Nov 2016 13:44:54 +0100
Message-ID: <58207746.2020802@laposte.net>
References: <580F4042.5070201@laposte.net> <20161025120951.GL1597@katana>
 <580F6A1D.4000409@laposte.net> <20161025142935.GA2875@katana>
 <580F72AF.9070900@laposte.net>
 <7bd6ea08-361e-316f-be7f-d400b59aec0d@maciej.szmigiero.name>
 <581327AC.8060404@laposte.net>
 <5461ac01-6054-e222-f707-0b475c24276d@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtpoutz27.laposte.net ([194.117.213.102]:46966 "EHLO
        smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751325AbcKGMo7 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 7 Nov 2016 07:44:59 -0500
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout015 (Postfix) with ESMTP id ABA1D1C9186
        for <linux-i2c@vger.kernel.org>; Mon,  7 Nov 2016 13:44:56 +0100 (CET)
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout015 (Postfix) with ESMTP id 9CE651C918B
        for <linux-i2c@vger.kernel.org>; Mon,  7 Nov 2016 13:44:56 +0100 (CET)
Received: from lpn-prd-vrin003 (lpn-prd-vrin003.prosodie [10.128.63.4])
        by lpn-prd-vrout015 (Postfix) with ESMTP id 9878F1C9186
        for <linux-i2c@vger.kernel.org>; Mon,  7 Nov 2016 13:44:56 +0100 (CET)
Received: from lpn-prd-vrin003 (localhost [127.0.0.1])
        by lpn-prd-vrin003 (Postfix) with ESMTP id 7D1D248E079
        for <linux-i2c@vger.kernel.org>; Mon,  7 Nov 2016 13:44:56 +0100 (CET)
In-Reply-To: <5461ac01-6054-e222-f707-0b475c24276d@maciej.szmigiero.name>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Wolfram Sang <wsa@the-dreams.de>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-parport@lists.infradead.org, philb@gnu.org, tim@cyberelk.net, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org

On 10/29/2016 01:12 AM, Maciej S. Szmigiero wrote:
>> Would you mind sharing the laptop's model?
> 
> This is Elitebook model 8570p.

That seems like a fairly recent laptop:

http://www.notebookcheck.net/Review-HP-EliteBook-8570p-B6Q03EA-ABD-Notebook.82291.0.html

and it has a true parallel port? Thanks a lot for the pointer!

>> There are a bunch of
>> Elitebooks and maybe not all have the ports wired.
>> Does your laptop has the Parallel Port on the docking or on the laptop
>> itself?
> 
> Only a serial port socket is built-it, parallel port socket is
> available only via a port replicator.
> 
> According to description of this replicator it is compatible with
> a lot of different Elitebooks and Probooks:
> http://h30094.www3.hp.com/product.aspx?sku=10432928&mfg_part=A7E34AA&pagemode=ca
> 
> I wasn't able find any note in this replicator description that port
> availability depends on connected laptop model.
> You can try to search for particular laptop model schematics, even
> if it is available only for sale sometimes there is a preview
> page with block diagram which clearly show where the parallel port
> is connected (this is true for my laptop model for example).
> 
> However, whether the port is on standard I/O address and interrupt
> line requires some more digging.

Thanks for the information.

>> Do you know the command to enable them thru PnP? Shouldn't loading
>> the kernel module be enough? Or is it the other way around and 
>> enabling thru PnP triggers the kernel module load process?
> 
> If you want to use them under Linux then everything should be taken
> care of by kernel's PnP support.
> It can be problem if you want to use them under pure DOS.
> 

I see, thanks.
