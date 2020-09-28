Return-Path: <SRS0=w0lc=DF=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BFEC2D0A8
	for <linux-i2c@archiver.kernel.org>; Mon, 28 Sep 2020 15:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B4B1208FE
	for <linux-i2c@archiver.kernel.org>; Mon, 28 Sep 2020 15:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgI1PTF (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 28 Sep 2020 11:19:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:45202 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbgI1PTF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 28 Sep 2020 11:19:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9EB91ADCA;
        Mon, 28 Sep 2020 15:19:04 +0000 (UTC)
Date:   Mon, 28 Sep 2020 17:19:03 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-i2c@vger.kernel.org, Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH] i2c: i801: Add support for Intel Alder Lake PCH-S
Message-ID: <20200928171903.2e5af4c0@endymion>
In-Reply-To: <20200924135217.797605-1-jarkko.nikula@linux.intel.com>
References: <20200924135217.797605-1-jarkko.nikula@linux.intel.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Thu, 24 Sep 2020 16:52:17 +0300, Jarkko Nikula wrote:
> Add PCI ID of SMBus controller on Intel Alder Lake PCH-S
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
>  Documentation/i2c/busses/i2c-i801.rst | 1 +
>  drivers/i2c/busses/Kconfig            | 1 +
>  drivers/i2c/busses/i2c-i801.c         | 4 ++++
>  3 files changed, 6 insertions(+)
> (...)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
