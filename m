Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F83C6FD18
	for <linux-i2c@archiver.kernel.org>; Wed, 19 Apr 2023 20:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjDSUx0 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 19 Apr 2023 16:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjDSUxZ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 19 Apr 2023 16:53:25 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6089210E0;
        Wed, 19 Apr 2023 13:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=IPpaRq7RkHGEIgO7ssT5lhNb08FGjc367jKeixSh0T4=; b=VS62STdgUIKXXmjtJRcjS/hKMx
        R1goMZZ8actf5rqEzxmaEX8wXQJzThexKZLLBntGND69EK+M6bwAUQlr0mg8ioodNbumzZKxIvcRk
        hsQWXIbo1memEQ/EFgZWbzrTeqtK3PLQkIkg14lXQjwOeKuicPABkyHBCB7GABkbckgE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1ppEnj-00Aj9c-6z; Wed, 19 Apr 2023 22:53:15 +0200
Date:   Wed, 19 Apr 2023 22:53:15 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jiawen Wu <jiawenwu@trustnetic.com>
Cc:     netdev@vger.kernel.org, linux@armlinux.org.uk,
        linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
        olteanv@gmail.com, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v3 1/8] net: txgbe: Add software nodes to
 support phylink
Message-ID: <b13b8cdd-d169-4a4c-8a15-1f9a6e60cac7@lunn.ch>
References: <20230419082739.295180-1-jiawenwu@trustnetic.com>
 <20230419082739.295180-2-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419082739.295180-2-jiawenwu@trustnetic.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Wed, Apr 19, 2023 at 04:27:32PM +0800, Jiawen Wu wrote:
> Register software nodes for GPIO, I2C, SFP and PHYLINK. Define the
> device properties.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
