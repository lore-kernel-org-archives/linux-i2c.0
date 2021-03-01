Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADBAC433E0
	for <linux-i2c@archiver.kernel.org>; Mon,  1 Mar 2021 12:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C48D64E37
	for <linux-i2c@archiver.kernel.org>; Mon,  1 Mar 2021 12:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbhCAMmr (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 1 Mar 2021 07:42:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:54052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235105AbhCAMmq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 1 Mar 2021 07:42:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 485D4AFCC;
        Mon,  1 Mar 2021 12:42:04 +0000 (UTC)
Date:   Mon, 1 Mar 2021 13:42:01 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     zuoqilin1@163.com
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
Subject: Re: [PATCH] i2c: sis630: fix spellint typo
Message-ID: <20210301134201.6cb3acf6@endymion>
In-Reply-To: <20210301014026.289-1-zuoqilin1@163.com>
References: <20210301014026.289-1-zuoqilin1@163.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi zuoqilin,

On Mon, 01 Mar 2021 09:40:26 +0800, zuoqilin1@163.com wrote:
> From: zuoqilin <zuoqilin@yulong.com>
> 
> change 'adress' to 'address'
> 
> Signed-off-by: zuoqilin <zuoqilin@yulong.com>
> ---
>  drivers/i2c/busses/i2c-sis630.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
> index cfb8e04..87d5625 100644
> --- a/drivers/i2c/busses/i2c-sis630.c
> +++ b/drivers/i2c/busses/i2c-sis630.c
> @@ -97,7 +97,7 @@
>  module_param(force, bool, 0);
>  MODULE_PARM_DESC(force, "Forcibly enable the SIS630. DANGEROUS!");
>  
> -/* SMBus base adress */
> +/* SMBus base address */
>  static unsigned short smbus_base;
>  
>  /* supported chips */

I pointed out 4 issues in your original patch, you fixed only one and
resubmitted with 3 issues remaining. I give up. Patch rejected, we can
live with a spelling mistake.

-- 
Jean Delvare
SUSE L3 Support
