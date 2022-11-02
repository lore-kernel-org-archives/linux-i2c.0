Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD00DC433FE
	for <linux-i2c@archiver.kernel.org>; Wed,  2 Nov 2022 07:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiKBHaB (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 2 Nov 2022 03:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiKBHaA (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 2 Nov 2022 03:30:00 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5267513E3D
        for <linux-i2c@vger.kernel.org>; Wed,  2 Nov 2022 00:29:58 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N2JP23qYczJnKt;
        Wed,  2 Nov 2022 15:27:02 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 15:29:56 +0800
CC:     <yangyicong@hisilicon.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Wolfram Sang <wsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: devres: add missing I2C helper
To:     Yang Yingliang <yangyingliang@huawei.com>,
        <linux-i2c@vger.kernel.org>
References: <20221102034053.1708845-1-yangyingliang@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <bc4ad590-a051-f0d2-9f7d-c5ccb1ffee19@huawei.com>
Date:   Wed, 2 Nov 2022 15:29:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20221102034053.1708845-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On 2022/11/2 11:40, Yang Yingliang wrote:
> Add missing devm_i2c_add_adapter() to devres.rst. It's introduced by
> commit 07740c92ae57 ("i2c: core: add managed function for adding i2c
> adapters").
> 
> Fixes: 07740c92ae57 ("i2c: core: add managed function for adding i2c adapters")
> Cc: Yicong Yang <yangyicong@hisilicon.com>

I forgot to update the doc, sorry for that.

Acked-by: Yicong Yang <yangyicong@hisilicon.com>

> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Dmitry Osipenko <digetx@gmail.com>
> Cc: Wolfram Sang <wsa@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  Documentation/driver-api/driver-model/devres.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> index 853396d19419..ec97261530da 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -280,6 +280,7 @@ GPIO
>  
>  I2C
>    devm_i2c_new_dummy_device()
> +  devm_i2c_add_adapter()
>  
>  IIO
>    devm_iio_device_alloc()
> 
