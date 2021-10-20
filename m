Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D551AC433F5
	for <linux-i2c@archiver.kernel.org>; Wed, 20 Oct 2021 03:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1BB760F9D
	for <linux-i2c@archiver.kernel.org>; Wed, 20 Oct 2021 03:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhJTDkr (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 19 Oct 2021 23:40:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:46912 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhJTDkr (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 19 Oct 2021 23:40:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="228953344"
X-IronPort-AV: E=Sophos;i="5.87,165,1631602800"; 
   d="scan'208";a="228953344"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 20:36:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,165,1631602800"; 
   d="scan'208";a="483547120"
Received: from unknown (HELO [10.239.154.68]) ([10.239.154.68])
  by orsmga007.jf.intel.com with ESMTP; 19 Oct 2021 20:36:31 -0700
Subject: Re: [PATCH 1/2] i2c: virtio: disable timeout handling
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        gregkh@linuxfoundation.org
Cc:     wsa@kernel.org, virtualization@lists.linux-foundation.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
References: <20211019074647.19061-1-vincent.whitchurch@axis.com>
 <20211019074647.19061-2-vincent.whitchurch@axis.com>
 <20211019080913.oajrvr2msz5enzvz@vireshk-i7>
From:   Jie Deng <jie.deng@intel.com>
Message-ID: <d16fed64-6aa9-8c68-91e0-06fc84c3049c@intel.com>
Date:   Wed, 20 Oct 2021 11:36:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211019080913.oajrvr2msz5enzvz@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


On 2021/10/19 16:09, Viresh Kumar wrote:
> Doing this may not be a good thing based on the kernel rules I have
> understood until now. Maybe Greg and Wolfram can clarify on this.
>
> We are waiting here for an external entity (Host kernel) or a firmware
> that uses virtio for transport. If the other side is hacked, it can
> make the kernel hang here for ever. I thought that is something that
> the kernel should never do.


I'm also worried about this. We may be able to solve it by setting a big

timeout value in the driver.

