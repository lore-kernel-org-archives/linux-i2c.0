Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B78AC07E95
	for <linux-i2c@archiver.kernel.org>; Mon,  5 Jul 2021 03:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BB276124B
	for <linux-i2c@archiver.kernel.org>; Mon,  5 Jul 2021 03:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhGEDEc (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sun, 4 Jul 2021 23:04:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:19836 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhGEDEb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 4 Jul 2021 23:04:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10035"; a="188597361"
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; 
   d="scan'208";a="188597361"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2021 20:01:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; 
   d="scan'208";a="562375722"
Received: from dengjie-mobl1.ccr.corp.intel.com (HELO [10.239.154.58]) ([10.239.154.58])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jul 2021 20:01:49 -0700
Subject: Re: [PATCH v12] i2c: virtio: add a virtio i2c frontend driver
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, wsa@kernel.org,
        wsa+renesas@sang-engineering.com, mst@redhat.com, arnd@arndb.de,
        jasowang@redhat.com, yu1.wang@intel.com, shuo.a.liu@intel.com,
        conghui.chen@intel.com, stefanha@redhat.com
References: <f229cd761048bc143f88f33a3437bdbf891c39fd.1625214435.git.jie.deng@intel.com>
 <YN7jOm68fUL4UA2Q@smile.fi.intel.com>
 <20210705024340.mb5sv5epxbdatgsg@vireshk-i7>
From:   Jie Deng <jie.deng@intel.com>
Message-ID: <e1bcae54-bdbf-6fbd-986d-5c25e1745341@intel.com>
Date:   Mon, 5 Jul 2021 11:01:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210705024340.mb5sv5epxbdatgsg@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


On 2021/7/5 10:43, Viresh Kumar wrote:
> On 02-07-21, 12:58, Andy Shevchenko wrote:
>> On Fri, Jul 02, 2021 at 04:46:47PM +0800, Jie Deng wrote:
>>> +static int virtio_i2c_complete_reqs(struct virtqueue *vq,
>>> +				    struct virtio_i2c_req *reqs,
>>> +				    struct i2c_msg *msgs, int nr,
>>> +				    bool fail)
>>> +{
>>> +	struct virtio_i2c_req *req;
>>> +	bool failed = fail;
> Jie, you can actually get rid of this variable too. Jut rename fail to failed
> and everything shall work as you want.

Sure.

