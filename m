Return-Path: <SRS0=/45J=A4=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB26DC433E2
	for <linux-i2c@archiver.kernel.org>; Fri, 17 Jul 2020 14:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CAA72083B
	for <linux-i2c@archiver.kernel.org>; Fri, 17 Jul 2020 14:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594997996;
	bh=gPk+OxwQsYR0sre3+/Sj2FBMmBEKWNScuTpjspQFRIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RpThb0oiIakrHFLEKi58iARrte+4HY896N2/NEzIBB4/9BvuGO7j0ncJb5oCir3MK
	 Kyhd2KTgSFIvmBcRqAGS7uGipOfD7v0iAd3TmlbwVqs49ZsPgGhykARH4dtqGOAGPw
	 r7bX5uA2YpU7bRixh047eetNR1Hw9VgbalYaLGD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgGQO7z (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:59:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbgGQO7z (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 17 Jul 2020 10:59:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C1DD2076D;
        Fri, 17 Jul 2020 14:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594997994;
        bh=gPk+OxwQsYR0sre3+/Sj2FBMmBEKWNScuTpjspQFRIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ycTDdP3BGWXGYZbbuFdq44X3Vrs3WqCKVlKd/8oX4OTGtzpVLgwx0esILsumRgXpm
         F6qXZALlzsC3Imid7++S0Y4f460L8ls0eymk5MfH/+ek3roSIcplhR7/Wik/G+wAlg
         hDf+4nSS3DPxdXiWsKqX1kTsBP+62P1sXtlUVl6A=
Date:   Fri, 17 Jul 2020 16:59:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     corbet@lwn.net, michal.simek@xilinx.com,
        wsa+renesas@sang-engineering.com, linus.walleij@linaro.org,
        linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 1/2] drivers: provide devm_platform_request_irq()
Message-ID: <20200717145946.GC3008378@kroah.com>
References: <20200527142611.9006-1-zhengdejin5@gmail.com>
 <20200717143030.GB25998@nuc8i5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717143030.GB25998@nuc8i5>
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Fri, Jul 17, 2020 at 10:30:30PM +0800, Dejin Zheng wrote:
> On Wed, May 27, 2020 at 10:26:10PM +0800, Dejin Zheng wrote:
> Hi Jonathan, Greg, Rafael, Linus, Michal and Wolfram:
> 
> Could you help me review this patch if you have free time?

It's not anywhere in queue, sorry, please resend it?

thanks,

greg k-h
