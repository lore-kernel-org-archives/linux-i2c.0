Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9BDC07E99
	for <linux-i2c@archiver.kernel.org>; Mon,  5 Jul 2021 07:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 326A4613F6
	for <linux-i2c@archiver.kernel.org>; Mon,  5 Jul 2021 07:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhGEHQT (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 5 Jul 2021 03:16:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:8078 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229817AbhGEHQT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 5 Jul 2021 03:16:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10035"; a="208975314"
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; 
   d="scan'208";a="208975314"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2021 00:13:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; 
   d="scan'208";a="562446643"
Received: from dengjie-mobl1.ccr.corp.intel.com (HELO [10.239.154.58]) ([10.239.154.58])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2021 00:13:26 -0700
Subject: Re: [PATCH v12] i2c: virtio: add a virtio i2c frontend driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, wsa@kernel.org,
        wsa+renesas@sang-engineering.com, mst@redhat.com, arnd@arndb.de,
        jasowang@redhat.com, andriy.shevchenko@linux.intel.com,
        yu1.wang@intel.com, shuo.a.liu@intel.com, conghui.chen@intel.com,
        stefanha@redhat.com
References: <f229cd761048bc143f88f33a3437bdbf891c39fd.1625214435.git.jie.deng@intel.com>
 <20210705024056.ndth2bwn2itii5g3@vireshk-i7>
 <332af2be-0fb0-a846-8092-49d496fe8b6b@intel.com>
 <20210705043841.zujwo672nfdndpg2@vireshk-i7>
 <6aabc877-673a-e2bc-da2d-ec6741b4159b@intel.com>
 <20210705063003.a45ic3wn74nre6xe@vireshk-i7>
From:   Jie Deng <jie.deng@intel.com>
Message-ID: <273be5a6-c45f-8f12-361f-65caf0c3d08b@intel.com>
Date:   Mon, 5 Jul 2021 15:13:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210705063003.a45ic3wn74nre6xe@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On 2021/7/5 14:30, Viresh Kumar wrote:

>>
>> This is still not enough to convince me.  So I won't change them for now
>> until I see it
>>
>> is the consensus of the majority.
> Do you see reqs[i] to ever be NULL here ? If not, then if (req) is like if
> (true).
>
> Why would you want to have something like that ?

No. Currently, virtio_i2c_complete_reqs is only called by 
virtio_i2c_xfer, thus we don't

have reqs[i] to be NULL. But I think "virtio_i2c_complete_reqs" as an 
independent function

should consider this from a callee perspective.

Anyway, if you really think it should be changed, it can be fixed 
incrementally as Wolfram said.


