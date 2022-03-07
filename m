Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512A1C433F5
	for <linux-i2c@archiver.kernel.org>; Mon,  7 Mar 2022 08:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiCGIOv (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 7 Mar 2022 03:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiCGIOu (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 7 Mar 2022 03:14:50 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0185A09C
        for <linux-i2c@vger.kernel.org>; Mon,  7 Mar 2022 00:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646640835; x=1678176835;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HzAu/XSoEig5fPmfl1zNC0iKX8Pqh5h4XbWbRhQpAH8=;
  b=PZpn+OzTTpKszEY2BPkTyA1GsZqG/mr/hJ0KWY+4ppq3yX7DZ0/Yz743
   tn7w1uLwDUtSqwMccbKnurXHneTqSjIRGfLv9vBSgFKSYVz3KZ2PiJQh6
   Ge3I3A/Aoa2s0iHQtKLw3M4o5fguejfeiwFpfgKj6Wi3G0R/tBlTPAxGV
   iwxCNtUnmYInEtPxMmuOmQPRjyZQqW97dDA758X8XP9hg10Qvf7rBl3Ou
   0fHvFapnggBlP27H+fQz+FEmkfdRYaUUWz4rGxxfqwxlCPJJI/jKM5VhP
   75/zmIhDKm4jlW2ZF83n/w0AQIYPpmdFUrJvu82IjIn2vVIOesvmtYneU
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="340764812"
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="340764812"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 00:13:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="512595135"
Received: from mylly.fi.intel.com (HELO [10.237.72.156]) ([10.237.72.156])
  by orsmga006.jf.intel.com with ESMTP; 07 Mar 2022 00:13:53 -0800
Message-ID: <58dc14d2-969e-256b-077c-2147827e5a86@linux.intel.com>
Date:   Mon, 7 Mar 2022 10:13:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH -next] i2c: designware: Mark
 dw_i2c_plat_{suspend,resume}() as __maybe_unused
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Wolfram Sang <wsa@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>, linux-i2c@vger.kernel.org,
        patches@lists.linux.dev
References: <20220303191713.2402461-1-nathan@kernel.org>
 <b7f8ad61-4dcd-a7cd-94f5-2a37aa57fd6a@redhat.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <b7f8ad61-4dcd-a7cd-94f5-2a37aa57fd6a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On 3/4/22 13:46, Hans de Goede wrote:
> Hi,
> 
> On 3/3/22 20:17, Nathan Chancellor wrote:
>> When CONFIG_PM is set but CONFIG_PM_SLEEP is not, two compiler warnings
>> appear:
>>
>>    drivers/i2c/busses/i2c-designware-platdrv.c:444:12: error: unused function 'dw_i2c_plat_suspend' [-Werror,-Wunused-function]
>>    static int dw_i2c_plat_suspend(struct device *dev)
>>               ^
>>    drivers/i2c/busses/i2c-designware-platdrv.c:465:12: error: unused function 'dw_i2c_plat_resume' [-Werror,-Wunused-function]
>>    static int dw_i2c_plat_resume(struct device *dev)
>>               ^
>>    2 errors generated.
>>
>> These functions are only used in SET_LATE_SYSTEM_SLEEP_PM_OPS(), which
>> is defined as empty when CONFIG_PM_SLEEP is not defined. Mark the
>> functions as __maybe_unused to make it clear that these functions might
>> be unused in this configuration.
>>
>> Fixes: c57813b8b288 ("i2c: designware: Lock the adapter while setting the suspended flag")
>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
