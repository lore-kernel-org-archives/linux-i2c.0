Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248B1C433DB
	for <linux-i2c@archiver.kernel.org>; Thu, 18 Feb 2021 12:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C276961493
	for <linux-i2c@archiver.kernel.org>; Thu, 18 Feb 2021 12:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhBRMAz (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 18 Feb 2021 07:00:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:49686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231847AbhBRJ3z (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 18 Feb 2021 04:29:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A45464E5F;
        Thu, 18 Feb 2021 09:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613640554;
        bh=i9kUQrGej5nnAqz252u1q780DHC6qw/nrdRa48+5dMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WYwLGQEAj9r+tSDsRfYFnaoSAv7+3GDGBztVhqPKuiSkb0sBI/NtnT1FqitYczK17
         MtEtfRgQWHEjkWDpMe9PsVhQ0+w7AEIn/HU6+Lr/qIUXQFDAt8c9r5xbmfb91iS/EW
         abJKRXNKgnh3cfuRFN16tqbvtCHr9s5Me/3+xs3T8QZy1/ZHb1AY6Hh+34+5Ee1ILH
         o3lpNde3LL7SLH3Rnr6oNFqNWH0yGbdZA+eIV4z4Yoqbm649HvdH/UqGE1RYuGK4WQ
         lzptPJuCUAul2Am0LathYzj0olR0IJK/O/uJgm37G2gMbzXXDKilPn+Oht987+3i5c
         sizpSveadc/ZQ==
Date:   Thu, 18 Feb 2021 10:29:09 +0100
From:   Robert Richter <rric@kernel.org>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     wsa+renesas@sang-engineering.com, jan.glauber@gmail.com,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: thunderx: Fix an issue about missing call to
 'pci_free_irq_vectors()'
Message-ID: <YC4zZNtRi4pql1H1@rric.localdomain>
References: <20210214143734.591789-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210214143734.591789-1-zhengdejin5@gmail.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On 14.02.21 22:37:34, Dejin Zheng wrote:
> Call to 'pci_free_irq_vectors()' are missing both in the error handling
> path of the probe function, and in the remove function. So add them.
> 
> Fixes: 4c21541d8da17fb ("i2c: thunderx: Replace pci_enable_msix()")
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>

This is already taken care of in pcim_release() as the device is
managed (pcim_enable_device()). Your change is not required.

-Robert
