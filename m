From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 2/2] i2c: mv64xxx: Fix clock resource by adding an optional bus clock
Date: Wed, 10 Jan 2018 18:07:32 +0100
Message-ID: <87po6h7icr.fsf@free-electrons.com>
References: <20180110165147.26605-1-gregory.clement@free-electrons.com>
        <20180110165147.26605-3-gregory.clement@free-electrons.com>
        <20180110175407.2185e95c@windsurf.lan>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:40836 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752484AbeAJRHd (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 10 Jan 2018 12:07:33 -0500
In-Reply-To: <20180110175407.2185e95c@windsurf.lan> (Thomas Petazzoni's
        message of "Wed, 10 Jan 2018 17:54:07 +0100")
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Omri Itach <omrii@marvell.com>, Hanna Hawa <hannah@marvell.com>, Igal Liberman <igall@marvell.com>, Marcin Wojtas <mw@semihalf.com>

Hi Thomas,
 
 On mer., janv. 10 2018, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> Hello,
>
> On Wed, 10 Jan 2018 17:51:47 +0100, Gregory CLEMENT wrote:
>> On Armada 7K/8K we need to explicitly enable the bus clock. The bus clock
>> is optional because not all the SoCs need them but at least for Armada
>> 7K/8K it is actually mandatory.
>> 
>> The binding documentation is updating accordingly.
>
> Seems like the binding documentation update is not part of this patch
> :)

Indeed, I forgot to do the "git commit --amend".

Thanks,

Gregory


>
> Thomas
> -- 
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
