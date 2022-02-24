Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC27C433EF
	for <linux-i2c@archiver.kernel.org>; Thu, 24 Feb 2022 13:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbiBXNEa (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 24 Feb 2022 08:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbiBXNE3 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 24 Feb 2022 08:04:29 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D858230E67
        for <linux-i2c@vger.kernel.org>; Thu, 24 Feb 2022 05:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645707840; x=1677243840;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xMs4+OS6I0/43kybTp9enltpVXjwItiyN4hGHATi0xQ=;
  b=Od8cQP/jkdt+B5UGhTclu69CCflvyVsee888hEyFhT1AAwaLL+OiU1yb
   ou/9maTH/+kO20EuED+G6ntx66JPq3vz7UaIZ9HPwICTCLm73GFZHgyq7
   WLYmz3sm08sI3FtS09qFgZCWTfLXSRsRVrsys171kjRa6ku/ssl0JsdAB
   9UjB0tCipjhXvkfib1sJGtfgozlmMJpSffL7CzmkZFaW8kfkgzIgJLbHk
   eAxDKL/MHjFPBhNyWGQNUvDJM4tS51BaV29r+emMqmT/9fLpBmkEyxKv0
   9LJL2u+MqB55dPtUuXoISd32P6/Ax0QKuEN6r7qO4eQnAF8kc3G1Iex0m
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="251056627"
X-IronPort-AV: E=Sophos;i="5.88,134,1635231600"; 
   d="scan'208";a="251056627"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 05:04:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,134,1635231600"; 
   d="scan'208";a="548738505"
Received: from mylly.fi.intel.com (HELO [10.237.72.156]) ([10.237.72.156])
  by orsmga008.jf.intel.com with ESMTP; 24 Feb 2022 05:03:58 -0800
Message-ID: <929b0821-0a4b-008a-1bf0-22a02831d197@linux.intel.com>
Date:   Thu, 24 Feb 2022 15:03:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.0
Subject: Re: [PATCH 2/2] i2c: designware: Use the
 i2c_mark_adapter_suspended/resumed() helpers
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-i2c@vger.kernel.org
References: <20220223134839.731138-1-hdegoede@redhat.com>
 <20220223134839.731138-2-hdegoede@redhat.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20220223134839.731138-2-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On 2/23/22 15:48, Hans de Goede wrote:
> Use the i2c_mark_adapter_suspended/resumed() i2c-core helpers and rely
> on the i2c-core's suspended checking instead of using DIY code.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/i2c/busses/i2c-designware-core.h    | 2 --
>   drivers/i2c/busses/i2c-designware-master.c  | 5 -----
>   drivers/i2c/busses/i2c-designware-pcidrv.c  | 8 ++------
>   drivers/i2c/busses/i2c-designware-platdrv.c | 9 ++-------
>   4 files changed, 4 insertions(+), 20 deletions(-)
> 
I think Andy's Reviewed-by for 1/2 holds here too: "Both patches look 
good to me and seems like a nice clean up".

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
