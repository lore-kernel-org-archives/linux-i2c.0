Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323BEC433F5
	for <linux-i2c@archiver.kernel.org>; Mon, 21 Feb 2022 16:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381059AbiBUQqn (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 21 Feb 2022 11:46:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381212AbiBUQql (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 21 Feb 2022 11:46:41 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D8F24BC0;
        Mon, 21 Feb 2022 08:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=D3xmKf375u67CO/G9sqxXWr4vZgoekVmpDRtUjOrF04=; b=SB0QIzn4rn0UlpJp+tsLYMtkys
        /i3l3UbM1Qf/ku2SiJVfsmvssun2zsnssq2c1EDY8O8FuQF3wXde7NWuOhAU8dlkVCfZKW3IE+Vok
        E7K1p++rxtu8N4QRdKZs415G1HSayhyU45m20nAtnhJMoJmPORVHo4BkFvH6EDdhRiinjH9P6OU9n
        km8oR/UyOkxtjQgpTL3+0YN9EbTacAlR+BfUUZ9YRdQzHRqiNpPnsPH+zyj/B1HNaMn50i3x7h0Vt
        +Bjj241Mzd0Tu475O0QigDKQtWteV+BusQzf9yKzXFKNAsmLGwcoVEKHFPAKw8md16B66/QZOM5q+
        gYqgLmZw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57398)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nMBp2-0000f2-Dm; Mon, 21 Feb 2022 16:46:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nMBoz-0007Sc-ME; Mon, 21 Feb 2022 16:45:57 +0000
Date:   Mon, 21 Feb 2022 16:45:57 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Wolfram Sang <wsa@kernel.org>, Peter Rosin <peda@axentia.se>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org,
        netdev@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [RFC 10/10] net: sfp: add support for fwnode
Message-ID: <YhPBxcaGinaBM21M@shell.armlinux.org.uk>
References: <20220221162652.103834-1-clement.leger@bootlin.com>
 <20220221162652.103834-11-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220221162652.103834-11-clement.leger@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Mon, Feb 21, 2022 at 05:26:52PM +0100, Clément Léger wrote:
> Add support to retrieve a i2c bus in sfp with a fwnode. This support
> is using the fwnode API which also works with device-tree and ACPI.
> For this purpose, the device-tree and ACPI code handling the i2c
> adapter retrieval was factorized with the new code. This also allows
> i2c devices using a software_node description to be used by sfp code.
> 
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>

I think this looks fine.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
