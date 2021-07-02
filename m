Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5DFC11F68
	for <linux-i2c@archiver.kernel.org>; Fri,  2 Jul 2021 06:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF0216141C
	for <linux-i2c@archiver.kernel.org>; Fri,  2 Jul 2021 06:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhGBGlc (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 2 Jul 2021 02:41:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:54302 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhGBGl2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 2 Jul 2021 02:41:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="294327958"
X-IronPort-AV: E=Sophos;i="5.83,316,1616482800"; 
   d="scan'208";a="294327958"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 23:38:56 -0700
X-IronPort-AV: E=Sophos;i="5.83,316,1616482800"; 
   d="scan'208";a="559657878"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 23:38:54 -0700
Subject: Re: [kbuild-all] Re: [PATCH v11] i2c: virtio: add a virtio i2c
 frontend driver
To:     Jie Deng <jie.deng@intel.com>, kernel test robot <lkp@intel.com>,
        linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, wsa@kernel.org,
        wsa+renesas@sang-engineering.com, mst@redhat.com, arnd@arndb.de,
        jasowang@redhat.com, andriy.shevchenko@linux.intel.com
References: <510c876952efa693339ab0d6cc78ba7be9ef6897.1625104206.git.jie.deng@intel.com>
 <202107011701.sZA89A1D-lkp@intel.com>
 <68b2b36b-f1ee-d1aa-d4a5-d45f36602be6@intel.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <8e5e81b0-37f5-3863-9a9e-c66bf2a9d42f@intel.com>
Date:   Fri, 2 Jul 2021 14:38:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <68b2b36b-f1ee-d1aa-d4a5-d45f36602be6@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org



On 7/2/21 11:12 AM, Jie Deng wrote:
>
> On 2021/7/1 18:00, kernel test robot wrote:
>> Hi Jie,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on wsa/i2c/for-next]
>> [also build test ERROR on linux/master linus/master v5.13 next-20210630]
>> [cannot apply to vhost/linux-next]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url: 
>> https://github.com/0day-ci/linux/commits/Jie-Deng/i2c-virtio-add-a-virtio-i2c-frontend-driver/20210701-112619
>> base: https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git 
>> i2c/for-next
>> config: i386-randconfig-c021-20210630 (attached as .config)
>> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>> reproduce (this is a W=1 build):
>>          # 
>> https://github.com/0day-ci/linux/commit/e8dedd2a8577148d7655d0affe35adf34efbbf15
>>          git remote add linux-review https://github.com/0day-ci/linux
>>          git fetch --no-tags linux-review 
>> Jie-Deng/i2c-virtio-add-a-virtio-i2c-frontend-driver/20210701-112619
>>          git checkout e8dedd2a8577148d7655d0affe35adf34efbbf15
>>          # save the attached .config to linux build tree
>>          mkdir build_dir
>>          make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     In file included from <command-line>:32:
>>>> ./usr/include/linux/virtio_i2c.h:12:10: fatal error: linux/bits.h: 
>>>> No such file or directory
>>        12 | #include <linux/bits.h>
>>           |          ^~~~~~~~~~~~~~
>>     compilation terminated.
>
>
> I didn't see this error. Why did you say no such file? Anything wrong ?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git/tree/include/linux/bits.h 
>
>
> Thank you !


Hi Jie,

The problem is reproducible, I guess it's due to bits.h not in 
include/uapi/linux.

Best Regards,
Rong Chen
