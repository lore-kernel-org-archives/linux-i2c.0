Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2340C07E95
	for <linux-i2c@archiver.kernel.org>; Sun,  4 Jul 2021 08:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8519613C8
	for <linux-i2c@archiver.kernel.org>; Sun,  4 Jul 2021 08:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhGDIFX (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sun, 4 Jul 2021 04:05:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229540AbhGDIFX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 4 Jul 2021 04:05:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6CE3613BF;
        Sun,  4 Jul 2021 08:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625385768;
        bh=2GmzuRt/t7Ke1O6VsnMavEJQBIp/2XiRx8wdpbwLk0w=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=gJFEh9S2Z35DfPBcWdQhg1M5tnhLYzlHXlKFtPFRMVhJOFbK0bQRKUkjCsFxqftty
         a4ktejTrC4AWkfKyW4IWjLifWhCRDx/BymmJwNZMivlwZyB2LCfa1HfTwlSFH8UTSb
         WEuVjFro/GSHIGMqxoLmsrnTRp6MLSuNNHtAZtIg=
Date:   Sun, 4 Jul 2021 10:02:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org
Subject: Re: Unavailable for two weeks
Message-ID: <YOFrJYS3IJ5bXNbi@kroah.com>
References: <YOFlTrOWahNB2+oE@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOFlTrOWahNB2+oE@kunai>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Sun, Jul 04, 2021 at 09:37:50AM +0200, Wolfram Sang wrote:
> Hi everyone,
> 
> From tomorrow on, I will not have internet for the next two weeks. So,
> if there are urgent I2C things to fix which cannot wait, please upstream
> it directly. Greg, would you be there to pick them up?

Sure, would be glad to do so, just cc: me on the changes and I can queue
them up in my driver trees.

Have a nice vacation!

greg k-h
