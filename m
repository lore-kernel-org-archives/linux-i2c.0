Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824ADC54EE9
	for <linux-i2c@archiver.kernel.org>; Tue, 20 Sep 2022 07:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiITHgE (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 20 Sep 2022 03:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiITHf6 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 20 Sep 2022 03:35:58 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D025460685;
        Tue, 20 Sep 2022 00:35:54 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MWtXM26ncz14Qj6;
        Tue, 20 Sep 2022 15:31:47 +0800 (CST)
Received: from [10.159.220.206] (10.159.220.206) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 15:35:52 +0800
Message-ID: <26a62e8c-b3cd-bf61-2113-1e8375f2cc9c@huawei.com>
Date:   Tue, 20 Sep 2022 15:35:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] i2c: hix5hd2: Add some debug enhancement for register
 access
To:     Wolfram Sang <wsa@kernel.org>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220913124820.48715-1-taolan@huawei.com>
 <YyYuK1UD7CpZQoFr@shikoro>
From:   taolan <taolan@huawei.com>
In-Reply-To: <YyYuK1UD7CpZQoFr@shikoro>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.159.220.206]
X-ClientProxiedBy: dggpeml100013.china.huawei.com (7.185.36.238) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org


 

-------- Original Message --------
Title: Re: [PATCH] i2c: hix5hd2: Add some debug enhancement for register access
From: wsa@kernel.org
To: taolan@huawei.com; Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Date: 2022/9/18 04:29
> On Tue, Sep 13, 2022 at 12:48:20PM +0000, Tao Lan wrote:
>> From: taolan <taolan@huawei.com>
>>
>> Sometimes, to locate a fault, we need to know how the register is
>> configured and whether the configuration is incorrect. Currently, no
>> better method is available for analysis.
>>
>> This patch tries to solve the problem by naming the registers and
>> printing the accessed values.
>>
>> Signed-off-by: taolan <taolan@huawei.com>
> 
> Such debug helpers are not suitable for upstream because they need quite
> some resources for rare cases...
Yeah, how about writing to proc as an event, or any suggestions？
> 
>> +		pr_notice("write 0x%04x to %s\n", val, g_i2c_reg_name[idx >> 0x2].name);
> 
> ... and using this loglevel you will flood logs of users.
The loglevel can be adjusted to DEBUG level,and this debug can be off by default. is this ok?
> 
> 
