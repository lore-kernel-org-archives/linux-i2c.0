Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99236C2B9F7
	for <linux-i2c@archiver.kernel.org>; Wed, 26 May 2021 05:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78FF261378
	for <linux-i2c@archiver.kernel.org>; Wed, 26 May 2021 05:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbhEZFxX (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 26 May 2021 01:53:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:4954 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229552AbhEZFxW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 26 May 2021 01:53:22 -0400
IronPort-SDR: OHQXJokI9nLpDp+hTkBObex5XTeD8c9mJLnttLUp1pKAsXgW2nBwp6/edkiqQK2hX8LyAtkQzC
 3WG0LH038zqQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="199333441"
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="199333441"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 22:51:48 -0700
IronPort-SDR: x1NU05lizJzYgEHOeYdp2a3BbwQIfALeVCwpM2NHLy9iG5Exljf7iW2wNnUvAwNgkFdl63/Z9u
 7OwpXXDXdnag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="409071590"
Received: from unknown (HELO [10.237.72.166]) ([10.237.72.166])
  by fmsmga007.fm.intel.com with ESMTP; 25 May 2021 22:51:47 -0700
Subject: Re: [PATCH] i2c: designware: Fix kernel-doc
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1621998623-14846-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <350759ac-bcea-77ac-f005-f227f01d88ab@linux.intel.com>
Date:   Wed, 26 May 2021 08:51:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <1621998623-14846-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi

On 5/26/21 6:10 AM, Yang Li wrote:
> Fix function name in i2c-designware-master.c kernel-doc comment
> to remove a warning found by clang_w1.
> 
> drivers/i2c/busses/i2c-designware-master.c:176: warning: expecting
> prototype for i2c_dw_init(). Prototype was for i2c_dw_init_master()
> instead.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: 'commit 21bf440ce18e ("i2c: designware: Make HW init functions
> static")'
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   drivers/i2c/busses/i2c-designware-master.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
Lee Jones sent a fix for this last week:

https://www.spinics.net/lists/linux-i2c/msg51612.html

Jarkko
