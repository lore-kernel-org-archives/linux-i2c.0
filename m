Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FDEC77B73
	for <linux-i2c@archiver.kernel.org>; Wed, 24 May 2023 12:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbjEXMyE (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 24 May 2023 08:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjEXMyB (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 24 May 2023 08:54:01 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469F19B;
        Wed, 24 May 2023 05:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=p9Q5194TwdL1NH2VMS2rBLfbJy1xEgC/lFh6m5wHdrk=; b=NDz5NOdoqoYVvt0+Fg3JVYBIsP
        CiAK5TBXX7XxWuZcxDeVqLJPDDvXmIimEXVUWvYsyFRSrgp7jZpOiuoYIJyXHQTl8BmeNlOzmgvK3
        SkEIxHCWBlFrrO5lx7PY9IVMygSsWN2uM/5vOIc/IJED+xCMudKLa8ku0fGbHX7GDGbM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q1nzz-00Dn5S-1M; Wed, 24 May 2023 14:53:51 +0200
Date:   Wed, 24 May 2023 14:53:51 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jiawen Wu <jiawenwu@trustnetic.com>
Cc:     netdev@vger.kernel.org, jarkko.nikula@linux.intel.com,
        andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        jsd@semihalf.com, Jose.Abreu@synopsys.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, linux-i2c@vger.kernel.org,
        linux-gpio@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v9 8/9] net: txgbe: Implement phylink pcs
Message-ID: <f3e31390-e4a2-4050-8f5a-5191342738e6@lunn.ch>
References: <20230524091722.522118-1-jiawenwu@trustnetic.com>
 <20230524091722.522118-9-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524091722.522118-9-jiawenwu@trustnetic.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Wed, May 24, 2023 at 05:17:21PM +0800, Jiawen Wu wrote:
> Register MDIO bus for PCS layer to use Synopsys designware XPCS, support
> 10GBASE-R interface to the controller.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
