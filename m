From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v3 2/2] i2c: mv64xxx: Fix clock resource by adding an optional bus clock
Date: Tue, 16 Jan 2018 15:40:00 +0100
Message-ID: <87mv1d7tq7.fsf@free-electrons.com>
References: <20180112103956.4875-1-gregory.clement@free-electrons.com>
        <20180112103956.4875-3-gregory.clement@free-electrons.com>
        <20180112105434.juefp2apuber3zti@flea.lan>
        <87wp0n5nw1.fsf@free-electrons.com>
        <20180115171859.nukvtrez5yun4564@ninjato>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:53389 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbeAPOkD (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 16 Jan 2018 09:40:03 -0500
In-Reply-To: <20180115171859.nukvtrez5yun4564@ninjato> (Wolfram Sang's message
        of "Mon, 15 Jan 2018 18:19:00 +0100")
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, linux-i2c@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Antoine Tenart <antoine.tenart@free-electrons.com>, Omri Itach <omrii@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Igal Liberman <igall@marvell.com>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@free-electrons.com>, Marcin Wojtas <mw@semihalf.com>, Hanna Hawa <hannah@marvell.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Hi Wolfram,
 
 On lun., janv. 15 2018, Wolfram Sang <wsa@the-dreams.de> wrote:

>> > Are you sure the i2c controller is on the AXI bus? It seems more
>> > likely to be on an APB bus.
>> 
>> No I am not sure :)
>> Actually I don't have this information, so lets call it "reg" for
>> register clock.
>
> So, I assume a V4 is needed for this series.
>
> BTW would be someone from FreeElectrons be up to maintaining this
> driver?

So I am going to add a patch adding myself as maintainer to the series
in the v4.

Gregory

>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
