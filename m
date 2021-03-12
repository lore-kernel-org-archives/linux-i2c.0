Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BB0C433DB
	for <linux-i2c@archiver.kernel.org>; Fri, 12 Mar 2021 05:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CEFA64F3B
	for <linux-i2c@archiver.kernel.org>; Fri, 12 Mar 2021 05:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhCLFyI (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 12 Mar 2021 00:54:08 -0500
Received: from mga07.intel.com ([134.134.136.100]:57204 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231299AbhCLFxx (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 12 Mar 2021 00:53:53 -0500
IronPort-SDR: eTD9ZleEw1wzcW5nhqltIE/6ZmpWpjSuGY9ZbnxuBBido8R16oELEJ8ZWhrEf02+usYNVJ5eAw
 WXeZUgnuxESg==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="252804755"
X-IronPort-AV: E=Sophos;i="5.81,242,1610438400"; 
   d="scan'208";a="252804755"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 21:53:52 -0800
IronPort-SDR: LPhcShtxF/YBny8tnC929I12DprUa0sQvim2bSFKI1A/mR9xIAq62mzAeg02lP6qWS5MrC9mjc
 75+CJSHVOSAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,242,1610438400"; 
   d="scan'208";a="377606218"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
  by fmsmga007.fm.intel.com with ESMTP; 11 Mar 2021 21:53:47 -0800
Subject: Re: [PATCH v7] i2c: virtio: add a virtio i2c frontend driver
To:     linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     mst@redhat.com, wsa@kernel.org, jasowang@redhat.com,
        wsa+renesas@sang-engineering.com,
        andriy.shevchenko@linux.intel.com, conghui.chen@intel.com,
        arnd@arndb.de, kblaiech@mellanox.com,
        jarkko.nikula@linux.intel.com, Sergey.Semin@baikalelectronics.ru,
        rppt@kernel.org, loic.poulain@linaro.org, tali.perry1@gmail.com,
        u.kleine-koenig@pengutronix.de, bjorn.andersson@linaro.org,
        yu1.wang@intel.com, shuo.a.liu@intel.com, viresh.kumar@linaro.org,
        stefanha@redhat.com, pbonzini@redhat.com
References: <cd3b0c9138824b0a5fad9d3bc872d8836e829946.1615554673.git.jie.deng@intel.com>
From:   Jie Deng <jie.deng@intel.com>
Message-ID: <26a1c5e4-c924-ba3f-83d8-5794641b0cbe@intel.com>
Date:   Fri, 12 Mar 2021 13:53:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <cd3b0c9138824b0a5fad9d3bc872d8836e829946.1615554673.git.jie.deng@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Sorry , sent the wrong version. Please ignore this. I will resend.

