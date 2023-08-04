Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FB1C00528
	for <linux-i2c@archiver.kernel.org>; Fri,  4 Aug 2023 22:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjHDWLM (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 4 Aug 2023 18:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjHDWLL (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 4 Aug 2023 18:11:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D485E10D2;
        Fri,  4 Aug 2023 15:11:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 731A96213C;
        Fri,  4 Aug 2023 22:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C03C433C7;
        Fri,  4 Aug 2023 22:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691187064;
        bh=1T+OCT3e+BN09TUMdtfFEkioQzLfCNFE/X9MgWNdROc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MqD1dkhCWLwSDA1SwOcMgf12EFxBzgLcq2q4DNOskkbULFASr8gla8GxWuxhg6UG8
         6SC7YtheS++wGLVS8tC5M4YnpVfcKklIFBbYYM5Bly2679OijJP3bdvV5gGfWH/bV8
         t+UBuSnfyzRTPpJB7X7HDlJIZ6jTKoL2j19Uft0wLHcDweIAdKLAIkNC8JaSuy53pr
         IYxjjJo4n4juGA8HCpaiToWG/RDp42ocpR1j3ySPQlDiatycwI/EJ855fCU0eFyaaC
         AYOchlXcN2ChVcC+Q1rcHfsHtjGgLS/5tTxZ/Ln8S2e0F9A6mMULDINx4kF8sUM1Qe
         BWVv8vB3kWS1w==
Date:   Sat, 5 Aug 2023 00:11:02 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     florian.fainelli@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, rjui@broadcom.com,
        sbranden@broadcom.com, yangyicong@hisilicon.com,
        aisheng.dong@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kblaiech@nvidia.com, asmaa@nvidia.com, loic.poulain@linaro.org,
        rfoss@kernel.org, ardb@kernel.org, gcherian@marvell.com,
        linux-i2c@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/9] i2c: mlxbf: Use dev_err_probe in probe function
Message-ID: <20230804221102.iw4ikxysfyz5as5r@intel.intel>
References: <20230802095737.3957587-1-liaochang1@huawei.com>
 <20230802095737.3957587-3-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802095737.3957587-3-liaochang1@huawei.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi Liao,

On Wed, Aug 02, 2023 at 05:57:30PM +0800, Liao Chang wrote:
> Use the dev_err_probe function instead of dev_err in the probe function
> so that the printed messge includes the return value and also handles
> -EPROBE_DEFER nicely.
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 

Andi
