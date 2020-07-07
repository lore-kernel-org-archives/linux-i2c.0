Return-Path: <SRS0=/I/R=AS=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5CEC433E0
	for <linux-i2c@archiver.kernel.org>; Tue,  7 Jul 2020 13:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B60FB20658
	for <linux-i2c@archiver.kernel.org>; Tue,  7 Jul 2020 13:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgGGNfe (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 7 Jul 2020 09:35:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:58938 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgGGNfe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 7 Jul 2020 09:35:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 79C32AC23;
        Tue,  7 Jul 2020 13:35:33 +0000 (UTC)
Date:   Tue, 7 Jul 2020 15:35:32 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-i2c@vger.kernel.org, Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH 2/2] i2c: i801: Add support for Intel Tiger Lake PCH-H
Message-ID: <20200707153532.6aabbbf4@endymion>
In-Reply-To: <20200618134240.4091271-2-jarkko.nikula@linux.intel.com>
References: <20200618134240.4091271-1-jarkko.nikula@linux.intel.com>
        <20200618134240.4091271-2-jarkko.nikula@linux.intel.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Thu, 18 Jun 2020 16:42:40 +0300, Jarkko Nikula wrote:
> Add SMBus PCI ID on Intel Tiger Lake PCH-H.

s/ on / of / ?

> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-i801.c | 4 ++++
>  1 file changed, 4 insertions(+)
> (...)

Other than this (which Wolfram can probably fix on the fly):

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
