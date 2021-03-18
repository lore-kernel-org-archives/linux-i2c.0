Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3C9C433E6
	for <linux-i2c@archiver.kernel.org>; Thu, 18 Mar 2021 10:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6781364F3B
	for <linux-i2c@archiver.kernel.org>; Thu, 18 Mar 2021 10:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhCRKhl (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 18 Mar 2021 06:37:41 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13570 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhCRKhM (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 18 Mar 2021 06:37:12 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F1Ngn3snxzPjvS;
        Thu, 18 Mar 2021 18:34:45 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Thu, 18 Mar 2021
 18:37:03 +0800
Subject: Re: [PATCH v2 2/3] i2c: add support for HiSilicon I2C controller
To:     <wsa@kernel.org>, <linux-i2c@vger.kernel.org>
CC:     <linuxarm@openeuler.org>, <prime.zeng@huawei.com>,
        John Garry <john.garry@huawei.com>
References: <1615296137-14558-1-git-send-email-yangyicong@hisilicon.com>
 <1615296137-14558-3-git-send-email-yangyicong@hisilicon.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <3a5ee50e-a876-178c-b6c6-87c125030d83@hisilicon.com>
Date:   Thu, 18 Mar 2021 18:37:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <1615296137-14558-3-git-send-email-yangyicong@hisilicon.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi,

On 2021/3/9 21:22, Yicong Yang wrote:
> +static int hisi_i2c_probe(struct platform_device *pdev)
> +{
> +	struct hisi_i2c_controller *ctlr;
> +	struct device *dev = &pdev->dev;
> +	struct i2c_adapter *adapter;
> +	u32 hw_version;
> +	int ret;
> +
> +	ctlr = devm_kzalloc(dev, sizeof(*ctlr), GFP_KERNEL);
> +	if (!ctlr)
> +		return -ENOMEM;
> +
> +	ctlr->dev = dev;
> +	ctlr->iobase = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(ctlr->iobase))
> +		return PTR_ERR(ctlr->iobase);
> +
> +	ctlr->irq = platform_get_irq(pdev, 0);
> +	if (ctlr->irq <= 0)
> +		return -ENOENT;
> +

here doesn't handle the -EPROBE_DEFER case, thanks john for noticing this.

Any other comments for this driver? or i'll send a v2 one with this fixed.

Thanks,
Yicong


