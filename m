From: Jan Kandziora <jjj@gmx.de>
Subject: Re: [Linux-parport] True Parallel Port Interface for Bit-banging?
Date: Wed, 26 Oct 2016 07:20:46 +0200
Message-ID: <ef5f581c-e419-2ab9-be98-30899c2e75f3@gmx.de>
References: <580F4042.5070201@laposte.net> <20161025120951.GL1597@katana>
 <580F6A1D.4000409@laposte.net> <20161025142935.GA2875@katana>
 <580F72AF.9070900@laposte.net>
 <7bd6ea08-361e-316f-be7f-d400b59aec0d@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:54790 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751222AbcJZFVe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 26 Oct 2016 01:21:34 -0400
In-Reply-To: <7bd6ea08-361e-316f-be7f-d400b59aec0d@maciej.szmigiero.name>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Sebastian Frias <sf84@laposte.net>
Cc: Wolfram Sang <wsa@the-dreams.de>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-parport@lists.infradead.org, philb@gnu.org, tim@cyberelk.net, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org

Am 26.10.2016 um 02:04 schrieb Maciej S. Szmigiero:
>
> I have tried dosemu, dosbox and as far I remember also VirtualBox
> with an old, DOS car service app.
> Wasn't able to make it communicate until I booted true DOS.
> That machine had old-style ISA serial ports so it was possible.
>
This is because it most likely uses the K-Line protocol, which needs to
output two bytes at 5 (in words: FIVE) baud at the very beginning of
each package.

It's no possible to have such a bitrate through any standard driver.
Those old car service apps tweak the UART hardware heavily to output
that signalling. It literally needs a 8250 chip. May even fail with some
SuperIO "16550" emulations in current mainboards.

Newer cars have CAN, but these K-Line cars (up to model year 2005 I
think) can give you headaches.

Kind regards

	Jan
