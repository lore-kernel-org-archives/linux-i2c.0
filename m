From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 3/3] dt-bindings: i2c: pxa: Update the documentation
 for the Armada 3700
Date: Mon, 14 Nov 2016 11:28:26 -0600
Message-ID: <20161114172826.75mctimsbh4snk4w@rob-hp-laptop>
References: <20161109115715.2557-1-romain.perier@free-electrons.com>
 <20161109115715.2557-4-romain.perier@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:34337 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932956AbcKNR2a (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 14 Nov 2016 12:28:30 -0500
Content-Disposition: inline
In-Reply-To: <20161109115715.2557-4-romain.perier@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Romain Perier <romain.perier@free-electrons.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Omri Itach <omrii@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Yahuda Yitschak <yehuday@marvell.com>, Hanna Hawa <hannah@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>, Igal Liberman <igall@marv>

On Wed, Nov 09, 2016 at 12:57:15PM +0100, Romain Perier wrote:
> This commit documents the compatible string to have the compatibility for
> the I2C unit found in the Armada 3700.
> 
> Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
> ---
> 
> Changes in v2:
>  - Fixed wrong compatible string, it should be "marvell,armada-3700-i2c"
>    and not "marvell,armada-3700".
> 
>  Documentation/devicetree/bindings/i2c/i2c-pxa.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
