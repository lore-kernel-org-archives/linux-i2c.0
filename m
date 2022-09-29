Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00906C04A95
	for <linux-i2c@archiver.kernel.org>; Thu, 29 Sep 2022 06:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbiI2GYl (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 29 Sep 2022 02:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbiI2GYk (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 29 Sep 2022 02:24:40 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BB326F0;
        Wed, 28 Sep 2022 23:24:35 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MdNWh5SHlz1P6wN;
        Thu, 29 Sep 2022 14:20:16 +0800 (CST)
Received: from [10.174.179.106] (10.174.179.106) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 14:24:33 +0800
Subject: Re: [PATCH next v3] i2c: hisi: Add support to get clock frequency
 from clock property
To:     Wolfram Sang <wsa@kernel.org>, <yangyicong@hisilicon.com>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220926091503.199474-1-chenweilong@huawei.com>
 <YzSl5Dm15ZDCxf15@shikoro>
From:   chenweilong <chenweilong@huawei.com>
Message-ID: <d17e461b-b59b-41c3-3f98-016f25e83818@huawei.com>
Date:   Thu, 29 Sep 2022 14:24:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <YzSl5Dm15ZDCxf15@shikoro>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.179.106]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On 2022/9/29 3:52, Wolfram Sang wrote:
> On Mon, Sep 26, 2022 at 05:15:03PM +0800, Weilong Chen wrote:
>> Support the driver to obtain clock information by clk_rate or
>> clock property. Find clock first, if not, fall back to clk_rate.
> This commit message describes what the patch does. But it misses the
> explanation why this needs to be done. Could you add this information,
> please? Patch itself looks also good to me.

OK, I'll update it.

Thanks.

>> Signed-off-by: Weilong Chen <chenweilong@huawei.com>
>> Acked-by: Yicong Yang <yangyicong@hisilicon.com>


