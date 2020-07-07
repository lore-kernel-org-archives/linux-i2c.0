Return-Path: <SRS0=/I/R=AS=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B582DC433E0
	for <linux-i2c@archiver.kernel.org>; Tue,  7 Jul 2020 06:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BBA920758
	for <linux-i2c@archiver.kernel.org>; Tue,  7 Jul 2020 06:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594102775;
	bh=p/mnFSd41cEmI9tbMU9PSi8Y4O8Mm7EAAFnT3DxhQX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=svNvp0AuHkBVvlnawzChpVLWeP/RxUyvBCRFNJaSl72iQHlUmrinW3KQEY50Gfayw
	 tHZb0ISZsj1LZV7mkVAQD24Rdo/0Jk89A+KFsgzRZ0SjD9NiadUS97BbL6YcuWtpqP
	 Zoo8TU2qgASQDkwmfV7ALrqZmxhxVUpE9WsmemME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgGGGTf (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:19:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbgGGGTf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 7 Jul 2020 02:19:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 220BB20739;
        Tue,  7 Jul 2020 06:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594102774;
        bh=p/mnFSd41cEmI9tbMU9PSi8Y4O8Mm7EAAFnT3DxhQX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mcDzPHsws9fYAKnfyw5tZ8YxkQAJffa6Annk4o0z/TA8m9J7hhGvjbJa2UAS2Z3sZ
         n1YfdGjRX9UEIBjhFDUb9CmSW7oi94MF8L0oiWfaempMogSyfXDXMH9k/AtU3LJUwD
         XSUuBbtAZTj0KC3PbdRMziPwTxwv9nSqvyHShcIE=
Date:   Tue, 7 Jul 2020 08:19:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org
Subject: Re: Two weeks off..
Message-ID: <20200707061931.GA214289@kroah.com>
References: <20200706210412.GA11492@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706210412.GA11492@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Mon, Jul 06, 2020 at 11:04:13PM +0200, Wolfram Sang wrote:
> Hiya all,
> 
> I hope you are well!
> 
> I'll be off the internet for the next two weeks. My for current-queue is
> empty and my for-next not very full, but I hope I have provided enough
> feedback for some series, so they can be applied easily when I am back.
> 
> If there is something super urgent, I guess you will find a tree it can
> go through. Probably Greg KH, as the driver maintainer (Hi Greg! :)) Or
> just wait the two weeks.

Sure, I'll be glad to take anything urgent that has to go in "now".

Enjoy your break!

greg k-h
