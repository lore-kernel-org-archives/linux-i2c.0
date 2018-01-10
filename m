From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 2/2] i2c: mv64xxx: Fix clock resource by adding an
 optional bus clock
Date: Wed, 10 Jan 2018 18:14:08 +0100
Message-ID: <20180110181408.43d51df9@windsurf.lan>
References: <20180110170743.27082-1-gregory.clement@free-electrons.com>
        <20180110170743.27082-3-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:41206 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933445AbeAJROV (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 10 Jan 2018 12:14:21 -0500
In-Reply-To: <20180110170743.27082-3-gregory.clement@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?UTF-8?B?TWlxdcOobA==?= Raynal <miquel.raynal@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Omri Itach <omrii@marvell.com>, Hanna Hawa <hannah@marvell.com>, Igal Liberman <igall@marvell.com>, Marcin Wojtas <mw@semihalf.com>

Hello,

On Wed, 10 Jan 2018 18:07:43 +0100, Gregory CLEMENT wrote:
> On Armada 7K/8K we need to explicitly enable the bus clock. The bus clock
> is optional because not all the SoCs need them but at least for Armada
> 7K/8K it is actually mandatory.
> 
> The binding documentation is updating accordingly.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  .../devicetree/bindings/i2c/i2c-mv64xxx.txt          | 20 ++++++++++++++++++++
>  drivers/i2c/busses/i2c-mv64xxx.c                     | 12 +++++++++++-
>  2 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> index 5c30026921ae..a835b724c738 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> @@ -25,6 +25,15 @@ default frequency is 100kHz
>                       whenever you're using the "allwinner,sun6i-a31-i2c"
>                       compatible.
>  
> + - clocks:	   : pointers to the reference clocks for this device, the first
> +		     one is the one used for the clock on the i2c bus, the second
> +		     one is the clock used for the functional part of the
> +		     controller
> +
> + - clock-names	   : names of used clocks, mandatory if the second clock is
> +		   : used, the name must be "core", and "axi_clk" (the latter is

Spurious ":" at beginning of line. In addition, the name is "axi" not
"axi_clk", at least according to your code.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
