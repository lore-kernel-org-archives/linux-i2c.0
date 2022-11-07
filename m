Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35BAC4167D
	for <linux-i2c@archiver.kernel.org>; Mon,  7 Nov 2022 03:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiKGDPC (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sun, 6 Nov 2022 22:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiKGDOX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 6 Nov 2022 22:14:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB3FF001;
        Sun,  6 Nov 2022 19:13:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88DA660E9C;
        Mon,  7 Nov 2022 03:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C109C433C1;
        Mon,  7 Nov 2022 03:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790793;
        bh=gqBD7ZtZtS9cif+o5ssR48/e3KLMN7q7ACwTDHCVax0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hLBYLpSqLIU7qXQoCSY92jc/SJ4MODBxnwk0xLY6fNLo4gnlUTJ7SD2K9wuUlLIPZ
         TlDtqqNxh5fwmZ5hJD1/cRTLT1HBOkXJ+Wld9cVk9CBu4uFOgHuiI9fkCSRsNVG4UO
         VEqLrx/CAk3n8Qnma7gUmIXBiOwLy5zseZK7Svti1hIXnrA9mvcOBb+y8c3gq7eX/y
         vMnTmONt5vjDeOSvvBndYIVGOFnlOM3w8F1HPJwHE9lFrmriMolrpmd+ogDS/SwLXm
         4LDplfQ6mk+hzGOaZ0zBFf7R0+oyxo96eXJ13QsUCCSrrrWRTcW9f6h+QkTXX4DCwm
         raAPZO+x3lWbg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, matti.lehtimaki@gmail.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
        loic.poulain@linaro.org, linux-i2c@vger.kernel.org,
        konrad.dybcio@somainline.org, linux-kernel@vger.kernel.org,
        robert.foss@linaro.org, phone-devel@vger.kernel.org
Subject: Re: (subset) [PATCH v1 0/6] Qualcomm CCI for MSM8226 and fix CCI documentation for MSM8974
Date:   Sun,  6 Nov 2022 21:12:30 -0600
Message-Id: <166779074257.500303.6728193350503927388.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221002122859.75525-1-matti.lehtimaki@gmail.com>
References: <20221002122859.75525-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Sun, 2 Oct 2022 15:28:52 +0300, Matti Lehtimäki wrote:
> This series adds support for Camera Control Interface found on MSM8226
> and adds missing clock documentation for CCI found on MSM8974. In
> addition the series adds CCI device tree nodes for both MSM8226 and
> MSM8974.
> 
> Luca Weiss (1):
>   ARM: dts: qcom: msm8974: Add CCI bus
> 
> [...]

Applied, thanks!

[5/6] ARM: dts: qcom: msm8226: Add CCI bus
      commit: 4ab2f41b0850768716c446461653178372bcd35c
[6/6] ARM: dts: qcom: msm8974: Add CCI bus
      commit: 4dd3949d17b66144fe7c39cf68ff4bedb4154f61

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
