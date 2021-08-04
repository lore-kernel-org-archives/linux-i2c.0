Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696D0C4338F
	for <linux-i2c@archiver.kernel.org>; Wed,  4 Aug 2021 13:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41B9E60F41
	for <linux-i2c@archiver.kernel.org>; Wed,  4 Aug 2021 13:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238206AbhHDNgk (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 4 Aug 2021 09:36:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:56480 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234089AbhHDNgk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 4 Aug 2021 09:36:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="274971265"
X-IronPort-AV: E=Sophos;i="5.84,294,1620716400"; 
   d="scan'208";a="274971265"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 06:36:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,294,1620716400"; 
   d="scan'208";a="569028898"
Received: from mylly.fi.intel.com (HELO [10.237.72.175]) ([10.237.72.175])
  by orsmga004.jf.intel.com with ESMTP; 04 Aug 2021 06:36:23 -0700
Subject: Re: [PATCH 01/10] i2c: i801: Don't call pm_runtime_allow
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Jean Delvare <jdelvare@suse.de>
Cc:     linux-i2c@vger.kernel.org, "rafael@kernel.org" <rafael@kernel.org>
References: <7a1581de-7566-15da-d1af-08cbf8c5e46f@gmail.com>
 <c0eeddf6-f630-d18b-cdae-0d74ed095f9c@gmail.com>
 <20210802145347.605ce8d5@endymion>
 <b0bca52e-2bbc-18ef-5134-d5b6fe9df2bf@gmail.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <68929f0f-a44e-6617-3e4e-dcdb9933d856@linux.intel.com>
Date:   Wed, 4 Aug 2021 16:36:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <b0bca52e-2bbc-18ef-5134-d5b6fe9df2bf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi

On 8/2/21 7:31 PM, Heiner Kallweit wrote:
> On 02.08.2021 14:53, Jean Delvare wrote:
>> Hi Heiner,
>>
>> On Sun, 01 Aug 2021 16:16:56 +0200, Heiner Kallweit wrote:
>>> Drivers should not call pm_runtime_allow(), see
>>> Documentation/power/pci.rst. Therefore remove the call and leave this
>>> to user space. Also remove the not needed call to pm_runtime_forbid().
>>>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> ---
>>>   drivers/i2c/busses/i2c-i801.c | 2 --
>>>   1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
>>> index 92ec291c0..362e74761 100644
>>> --- a/drivers/i2c/busses/i2c-i801.c
>>> +++ b/drivers/i2c/busses/i2c-i801.c
>>> @@ -1891,7 +1891,6 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
>>>   	pm_runtime_set_autosuspend_delay(&dev->dev, 1000);
>>>   	pm_runtime_use_autosuspend(&dev->dev);
>>>   	pm_runtime_put_autosuspend(&dev->dev);
>>> -	pm_runtime_allow(&dev->dev);
>>>   
>>>   	return 0;
>>>   }
>>> @@ -1900,7 +1899,6 @@ static void i801_remove(struct pci_dev *dev)
>>>   {
>>>   	struct i801_priv *priv = pci_get_drvdata(dev);
>>>   
>>> -	pm_runtime_forbid(&dev->dev);
>>>   	pm_runtime_get_noresume(&dev->dev);
>>>   
>>>   	i801_disable_host_notify(priv);
>>
>> These calls were added by Jarkko (Cc'd) and I'm not familiar with power
>> management so I'll need an explicit ack from him before I can accept
>> this patch.
>>
> The calls were part of the initial submission for rpm support and supposedly
> just copied from another driver. But fine with me to wait for his feedback.
> 
Yes, I'm quite sure I've copied it from another driver :-)

This patch will cause the device here won't go automatically to D3 
before some user space script allows it. E.g

echo auto > /sys/bus/pci/devices/0000\:00\:1f.3/power/control

I think this is kind of PM regression with this patch. It's not clear to 
me from the Documentation/power/pci.rst why driver should not call the 
pm_runtime_allow() and what would be allowed kernel alternative for it.

Rafael: what would be the correct way here to allow runtime PM from the 
driver or does it really require some user space script for it?

Jarkko
