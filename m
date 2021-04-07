Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C8EC433ED
	for <linux-i2c@archiver.kernel.org>; Wed,  7 Apr 2021 08:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 549F461246
	for <linux-i2c@archiver.kernel.org>; Wed,  7 Apr 2021 08:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbhDGI3v (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 7 Apr 2021 04:29:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16810 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349659AbhDGI3q (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 7 Apr 2021 04:29:46 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FFcvc3HX9z7tQ2;
        Wed,  7 Apr 2021 16:27:24 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Wed, 7 Apr 2021
 16:29:28 +0800
Subject: Re: [PATCH v6 2/5] i2c: core: add api to provide frequency mode
 strings
To:     Wolfram Sang <wsa@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <linux-i2c@vger.kernel.org>, <Sergey.Semin@baikalelectronics.ru>,
        <linux-kernel@vger.kernel.org>, <digetx@gmail.com>,
        <treding@nvidia.com>, <jarkko.nikula@linux.intel.com>,
        <rmk+kernel@armlinux.org.uk>, <song.bao.hua@hisilicon.com>,
        <john.garry@huawei.com>, <mika.westerberg@linux.intel.com>,
        <prime.zeng@huawei.com>, <linuxarm@huawei.com>
References: <1617197790-30627-1-git-send-email-yangyicong@hisilicon.com>
 <1617197790-30627-3-git-send-email-yangyicong@hisilicon.com>
 <20210406195414.GG3122@kunai>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <0d48f447-d1f2-1c86-27f4-3c8b23dcaf30@hisilicon.com>
Date:   Wed, 7 Apr 2021 16:29:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210406195414.GG3122@kunai>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On 2021/4/7 3:54, Wolfram Sang wrote:
> 
>> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
>> index 10bd0b0..7268180 100644
>> --- a/include/linux/i2c.h
>> +++ b/include/linux/i2c.h
>> @@ -47,6 +47,26 @@ typedef int (*i2c_slave_cb_t)(struct i2c_client *client,
>>  #define I2C_MAX_HIGH_SPEED_MODE_FREQ	3400000
>>  #define I2C_MAX_ULTRA_FAST_MODE_FREQ	5000000
>>  
>> +static inline const char *i2c_freq_mode_string(u32 bus_freq_hz)
>> +{
>> +	switch (bus_freq_hz) {
>> +	case I2C_MAX_STANDARD_MODE_FREQ:
>> +		return "Standard Mode (100 kHz)";
>> +	case I2C_MAX_FAST_MODE_FREQ:
>> +		return "Fast Mode (400 kHz)";
>> +	case I2C_MAX_FAST_MODE_PLUS_FREQ:
>> +		return "Fast Mode Plus (1.0 MHz)";
>> +	case I2C_MAX_TURBO_MODE_FREQ:
>> +		return "Turbo Mode (1.4 MHz)";
>> +	case I2C_MAX_HIGH_SPEED_MODE_FREQ:
>> +		return "High Speed Mode (3.4 MHz)";
>> +	case I2C_MAX_ULTRA_FAST_MODE_FREQ:
>> +		return "Ultra Fast Mode (5.0 MHz)";
>> +	default:
>> +		return "Unknown Mode";
>> +	}
>> +}
> 
> Any reason ehy this is an inline function? My gut feeling says it would
> be better added to the core?
> 

it's not a complicated function so i didn't think it'll make much difference,
so i just put it in the header along with the coresponding macro definitions.
do you want me to move it to the core?

Thanks


