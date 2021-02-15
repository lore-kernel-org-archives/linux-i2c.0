Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CAAC433DB
	for <linux-i2c@archiver.kernel.org>; Mon, 15 Feb 2021 09:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C6664DB1
	for <linux-i2c@archiver.kernel.org>; Mon, 15 Feb 2021 09:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhBOJiT (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 15 Feb 2021 04:38:19 -0500
Received: from mga02.intel.com ([134.134.136.20]:17757 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229948AbhBOJiQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 15 Feb 2021 04:38:16 -0500
IronPort-SDR: djomr3hM+ii1vYFivGAZIOmkUQ4J4PMZY5DD07jCZpkJ53H6ie6z+Agt2dSBNyx+vtPA1xk/im
 456VHrNJkk/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9895"; a="169779447"
X-IronPort-AV: E=Sophos;i="5.81,180,1610438400"; 
   d="scan'208";a="169779447"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 01:36:30 -0800
IronPort-SDR: MnCnN7VcQMxs2ZLpwxrnauA7/JtK2ktx6SzLVa00tlsTwZZ1HnYEeRzPULh/lEIuQ2xpw+nJ05
 xk+gl2j4LT7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,180,1610438400"; 
   d="scan'208";a="398992864"
Received: from mylly.fi.intel.com (HELO [10.237.72.57]) ([10.237.72.57])
  by orsmga008.jf.intel.com with ESMTP; 15 Feb 2021 01:36:28 -0800
Subject: Re: [PATCH i2c-next] i2c: designware: Consolidate
 pci_free_irq_vectors to a single place
To:     Dejin Zheng <zhengdejin5@gmail.com>,
        andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        wsa@kernel.org, linux-i2c@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20210214064529.481341-1-zhengdejin5@gmail.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <1f388e27-6fe3-e218-5873-2158906e1098@linux.intel.com>
Date:   Mon, 15 Feb 2021 11:36:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210214064529.481341-1-zhengdejin5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On 2/14/21 8:45 AM, Dejin Zheng wrote:
> Consolidate pci_free_irq_vectors to a single place using "goto free_irq"
> for simplify the code.
> 
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> ---
>   drivers/i2c/busses/i2c-designware-pcidrv.c | 22 ++++++++++------------
>   1 file changed, 10 insertions(+), 12 deletions(-)
> 
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
