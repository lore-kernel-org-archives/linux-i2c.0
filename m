From: santosh shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH] i2c: davinci: Increase module clock frequency
Date: Thu, 19 Nov 2015 16:22:07 -0800
Message-ID: <564E67AF.7010900@oracle.com>
References: <564DBEE3.4030508@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:31247 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161228AbbKTAWW (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 19 Nov 2015 19:22:22 -0500
In-Reply-To: <564DBEE3.4030508@nokia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alexander Sverdlin <alexander.sverdlin@nokia.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-i2c@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>

On 11/19/2015 4:21 AM, Alexander Sverdlin wrote:
> I2C controller used in Keystone SoC has an undocumented peculiarity which
> results in SDA-SCL margins being dependent on module clock. Driving high
> capacity bus near its limits can result in STOP condition sometimes being
> understood as REPEATED-START by slaves (or NACK instead of ACK, etc...).
> Driving the module with higher clocks increases the margin between SDA and SCL
> transitions, making the operations with higher bus rates more robust. Therefore,
> target the module clock to 12MHz instead of 7MHz, still staying within
> the specification limits.
>
> Before the change STOP timing looked like this on 400kHz:
>
> SDA   ----------+          +----
>                   \        /
>                    \      /
>                     +----+
>                         (1)
> SCL   --+          +------------
>           \        /
>            \      /
>             +----+
>                 (2)
>
> While only point (1) signals STOP, point (2) could be incorrectly recognized as
> repeated-START (almost no margin between SDA and SCL transitions).
>
> After the change there is at least 600ns margin measured between SCL fall and
> SDA fall during STOP generation:
>
> SDA   ------+          +----
>               \        /
>                \      /
>                 +----+
>
> SCL   --+          +--------
>           \        /
>            \      /
>             +----+
>             ->|    |<- 600ns
>                  ->|   |<- tSUSTO
>
> So called tSUSTO (setup time for STOP condition) is still slightly higher than
> 600ns, so no problem here.
>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> ---
Nice text artwork.
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
