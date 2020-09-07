Return-Path: <SRS0=j4Wp=CQ=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B71C43461
	for <linux-i2c@archiver.kernel.org>; Mon,  7 Sep 2020 15:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5996D21897
	for <linux-i2c@archiver.kernel.org>; Mon,  7 Sep 2020 15:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ee header.i=@mail.ee header.b="o9wy2TSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbgIGP16 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:27:58 -0400
Received: from eu-shark2.inbox.eu ([195.216.236.82]:51736 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730111AbgIGPTx (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 7 Sep 2020 11:19:53 -0400
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 2F412414806;
        Mon,  7 Sep 2020 18:10:03 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.ee; s=20150108;
        t=1599491403; bh=ggQqbkpst5wL1v1rCSXyE8dZBbpQBROcgwPPtpjFxJE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=o9wy2TSvLhWKsJvUnb9TWBU0+OIDamF+kkCEzdOsjZAJxB3XVcu4gj3j8JbSSPtcc
         I11qqK1hbty62MOHFpsra6ubjdTCdM2f9Ye8zmY6BeAUg12e97zawOscnIyQlNFQWJ
         3z5raX6nFgzFWRAsXd3tohVcXhVIeQAxf9oVd314=
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 330904147FB;
        Mon,  7 Sep 2020 18:08:47 +0300 (EEST)
Received: from hp15 (unknown [185.176.221.195])
        (Authenticated sender: arzamas-16@mail.ee)
        by mail.inbox.eu (Postfix) with ESMTPA id 810801BE0030;
        Mon,  7 Sep 2020 18:08:46 +0300 (EEST)
Date:   Mon, 7 Sep 2020 18:08:41 +0300
From:   Boris Lysov <arzamas-16@mail.ee>
To:     Qii Wang <qii.wang@mediatek.com>
Cc:     <linux-i2c@vger.kernel.org>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: i2c: i2c-mt65xx: Update binding example
Message-ID: <20200907180841.0044d571@hp15>
In-Reply-To: <1599442087.25719.2.camel@mhfsdcap03>
References: <20200904223345.3daea5ad@hp15>
        <1599442087.25719.2.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: OK
X-ESPOL: +d1m6OxSaUCpygHhXxmtCAMr1kpEXeXg5ea91gNbnnrkMCeBYg==
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Mon, 7 Sep 2020 09:28:07 +0800
Qii Wang <qii.wang@mediatek.com> wrote:

> On Fri, 2020-09-04 at 22:33 +0300, Boris Lysov wrote:
> > Example uses values for MT6589 SoC, but MT6577 was specified in "compatible" property.
> >   
> 
> Why do you think the example is MT6589 SoC, not MT6577?
> 

The best way to explain why it's for MT6589 instead of MT6577 is to provide
an example ;) I will refer to various downstream Linux kernel sources, I hope
sharing GitHub links is appropriate.


This is the kernel source code of Lenovo P780 (MT6589)
https://github.com/andreya108/bindu-kernel-mediatek

mediatek/platform/mt6589/kernel/core/include/mach/mt_reg_base.h , line 115:
> #define I2C0_BASE                  0xF100D000
This address is virtual, and it translates into physical address 0x1100D000
0x1100D000 equals to the value in example

mediatek/platform/mt6589/kernel/core/mt_devs.c , line 846:
> .end    = IO_VIRT_TO_PHYS(I2C0_BASE) + 0x70,
0x70 shows length of memory region, which also equals to the value in example

mediatek/platform/mt6589/kernel/drivers/i2c/i2c.c , line 1140:
> i2c->pdmabase = AP_DMA_BASE + 0x300 + (0x80*(i2c->id));
For id=0, physical pdmabase is 0x11000300 which also matches the address in example

mediatek/platform/mt6589/kernel/core/include/mach/mt_irq.h , line 29:
> #define MT_I2C0_IRQ_ID                      (GIC_PRIVATE_SIGNALS + 44)
The IRQ ID (44) equals to one specified in dt-binding example:
> interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_LOW>;

These values are same for other MT6589 devices, here are few other repositories
containing same lines of code as above (line numbers might be off for a few lines,
but the values I am referring to are same):
Micromax A116 (MT6589) - https://github.com/neomanu/NeoKernel-MT6589-A116
Acer V370 (MT6589) - https://github.com/Shr3ps/android_kernel_acer_V370_MT6589
bq Aquaris 5.7 (MT6589) - https://github.com/luckasfb/aquaris-5.7


Now lets take a look at MT6577 devices. This is the kernel source code of ZTE v970:
https://github.com/dragonpt/Kernel_3.4.67_KK_ZTE_v970

mediatek/platform/mt6589/kernel/core/include/mach/mt_reg_base.h , line 68:
> #define I2C0_BASE 0xF1012000
This address is virtual, and it translates into physical address 0xC1012000
0xC1012000 does not equal to 0x1100d000 listed in example!

mediatek/platform/mt6577/kernel/drivers/i2c/i2c.c
No mentions of pdmabase. There are no DMA addresses in this file!

mediatek/platform/mt6577/kernel/core/include/mach/mt_irq.h , line 70:
> #define MT_I2C0_IRQ_ID                  (GIC_PRIVATE_SIGNALS + 49)
The IRQ ID (49) does not match the ID (44) specified in example!

Other MT6577 kernels with same values:
Acer V360 (MT6577) - https://github.com/aquila-dev/mt6577_kernel3.4
Acer C10 (MT6577) - https://github.com/Dr-Shadow/android_kernel_acer_c10
Wiko Cink Slim (MT6577) - https://github.com/theboleslaw/kernel_wiko_s8073


As you can see, current dt-binding example represents MT6589 SoC values, not MT6577.
I have sent additional email about i2c-mt65xx and MT6577 compatibility, where
I voiced my concerns about I2C DMA on that SoC. I hope you can look into it.
