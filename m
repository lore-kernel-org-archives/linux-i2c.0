Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C101C433ED
	for <linux-i2c@archiver.kernel.org>; Mon, 17 May 2021 09:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 776AE611CA
	for <linux-i2c@archiver.kernel.org>; Mon, 17 May 2021 09:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbhEQJi1 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 17 May 2021 05:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236101AbhEQJiX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 17 May 2021 05:38:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9633E61059;
        Mon, 17 May 2021 09:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621244227;
        bh=vKAHVJuH8OQ18fLIntkXwduQ75EM0VANeKDRppsT4m8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BLa2+ccGGkmYghRZAoihsxhVuDPUnCU6weuZMLruoY/5AyOGb3X/gDjyOC3RG4xd/
         nPt0YsDWtHwTJ7szjkjOOlo++IJZCLU+1ddRh4RlBIX/O9i/U33wv64xjNuUMqfPys
         PVKh38JxeZpDUVpZVh9y+7Jc3VeRvFkQ/pToLToDXvLat4kr/BocOXtKPxLTQMefmj
         oiu3zr9MsKuTLfP/vjh++k4Uqo7Kx24Xa4ZxtWXtzTIvsfQoTAEnddsuxtZ3+xRodl
         YOSkt/E0EOF6L5M1n8VR6AxfJ8t5jDos9m9CewwyszHupUQQpDVg66ehlzAOgowIc0
         o8fdeW6GzGmeQ==
Date:   Mon, 17 May 2021 15:07:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, robert.foss@linaro.org,
        andrey.konovalov@linaro.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:QUALCOMM I2C CCI DRIVER" <linux-i2c@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: qcom-cci: add sm8250 compatible
Message-ID: <YKI5P06F0KliMCCR@vkoul-mobl.Dlink>
References: <20210513175518.6023-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513175518.6023-1-jonathan@marek.ca>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On 13-05-21, 13:55, Jonathan Marek wrote:
> SM8250 CCI is the same as SDM845, add an equivalent compatible for SM8250.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
