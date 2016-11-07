From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [Linux-parport] True Parallel Port Interface for Bit-banging?
Date: Tue, 8 Nov 2016 00:53:24 +0100
Message-ID: <fe33933b-c2ae-e3c6-0a17-f86d5e144e63@maciej.szmigiero.name>
References: <580F4042.5070201@laposte.net> <20161025120951.GL1597@katana>
 <580F6A1D.4000409@laposte.net> <20161025142935.GA2875@katana>
 <580F72AF.9070900@laposte.net>
 <7bd6ea08-361e-316f-be7f-d400b59aec0d@maciej.szmigiero.name>
 <581327AC.8060404@laposte.net>
 <5461ac01-6054-e222-f707-0b475c24276d@maciej.szmigiero.name>
 <58207746.2020802@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from vps-vb.mhejs.net ([37.28.154.113]:51163 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750926AbcKGXxb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 7 Nov 2016 18:53:31 -0500
In-Reply-To: <58207746.2020802@laposte.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sebastian Frias <sf84@laposte.net>
Cc: Wolfram Sang <wsa@the-dreams.de>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-parport@lists.infradead.org, philb@gnu.org, tim@cyberelk.net, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org

On 07.11.2016 13:44, Sebastian Frias wrote:
> On 10/29/2016 01:12 AM, Maciej S. Szmigiero wrote:
>>> Would you mind sharing the laptop's model?
>>
>> This is Elitebook model 8570p.
> 
> That seems like a fairly recent laptop:
> 
> http://www.notebookcheck.net/Review-HP-EliteBook-8570p-B6Q03EA-ABD-Notebook.82291.0.html
> 
> and it has a true parallel port?

It has parallel port on address 0x378/0x778, IRQ 5 by default which is
realized by Super IO chip.

In PnP config also available for selection are addresses 0x278/0x678,
0x3bc/0x7bc, IRQ 7 and ISA DMA channels 1 and 3.

Although I have never used this port personally it looks like what can
be considered a "true" parallel port.

> Thanks a lot for the pointer!

You are welcome.

Maciej
