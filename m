Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC03AC4167B
	for <linux-i2c@archiver.kernel.org>; Thu,  3 Dec 2020 15:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F53620784
	for <linux-i2c@archiver.kernel.org>; Thu,  3 Dec 2020 15:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgLCPVm (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 3 Dec 2020 10:21:42 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:36660 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbgLCPVl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 3 Dec 2020 10:21:41 -0500
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kkqPh-00A3Xs-Pq; Thu, 03 Dec 2020 16:20:57 +0100
Date:   Thu, 3 Dec 2020 16:20:57 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Stefan =?iso-8859-1?Q?L=E4sser?= 
        <stefan.laesser@omicronenergy.com>
Cc:     peter@korsgaard.com, linux-i2c@vger.kernel.org
Subject: Re: [PATCH] i2c: ocores: Avoid false-positive error log message.
Message-ID: <20201203152057.GO2324545@lunn.ch>
References: <6185f3fc-35ed-4de2-8bf7-fb991555580c@EXC03-ATKLA.omicron.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6185f3fc-35ed-4de2-8bf7-fb991555580c@EXC03-ATKLA.omicron.at>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Thu, Dec 03, 2020 at 04:02:52PM +0100, Stefan Lässer wrote:
> Since commit 7723f4c5ecdb ("driver core: platform: Add an error message to
> platform_get_irq*()"), platform_get_irq() will call dev_err() on an error.
> In case of i2c ocores this leads to a false-positive error being logged:
> 
> [ 4.173989] 007: ocores-i2c ocores-i2c: IRQ index 0 not found
> 
> i2c ocores already handles the case when the IRQ cannot be found and
> therefore there is no benefit in having this error message being logged.
> 
> This commit switches to platform_get_irq_optional(), which does not log
> in case the IRQ cannot be found.
> 
> Signed-off-by: Stefan Lässer <stefan.laesser@omicronenergy.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
