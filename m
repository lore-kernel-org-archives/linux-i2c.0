Return-Path: <SRS0=p1Da=BA=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65C7C433E2
	for <linux-i2c@archiver.kernel.org>; Tue, 21 Jul 2020 10:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B690F20729
	for <linux-i2c@archiver.kernel.org>; Tue, 21 Jul 2020 10:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595327942;
	bh=gPtQSJcxNwPCdZzu4MjV8u9d2PdXnbL3Gy75/JQmnmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XMipD0Gh7cQoJZTNkUHkyE/8hU/f/QOOf/6xG98XUTrVqxxrmwdmCEo3wC0sZv9to
	 ZZnTzvcL9WVdQp2sN82xK6108m2u1m57RL4DHKyvv8OpPYx6ulRr2q0oD0ayo0ekYL
	 T2Z2z4+9GccyKr9iIVoCJjfvTho8t9wCLZe2q8Mo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgGUKjC (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:39:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbgGUKjC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 21 Jul 2020 06:39:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D50720714;
        Tue, 21 Jul 2020 10:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595327941;
        bh=gPtQSJcxNwPCdZzu4MjV8u9d2PdXnbL3Gy75/JQmnmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xX6vP0XgrRW27NwWhrUQIzEBBM4rqaHGndD2Zh1zR2FleWqZgidqzQd0Pp50cPEz7
         7UMaV1eMLK6LFpgT0hpzfycILl9Y2v0l1fdPZp7ZCbalASI8AYs47vAOBgtcr81qhQ
         nAloarfN2T6nUVAYnjPIdLp5JFQ6oCMv4s+5bnio=
Date:   Tue, 21 Jul 2020 12:39:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org
Subject: Re: Two weeks off..
Message-ID: <20200721103910.GB1676612@kroah.com>
References: <20200706210412.GA11492@ninjato>
 <20200707061931.GA214289@kroah.com>
 <20200721062525.GB1044@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721062525.GB1044@kunai>
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Tue, Jul 21, 2020 at 08:25:25AM +0200, Wolfram Sang wrote:
> 
> > Sure, I'll be glad to take anything urgent that has to go in "now".
> 
> And I am back again. Thanks a lot, Greg!

No problem, welcome back :)
