Return-Path: <SRS0=JF8M=AA=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDB0C433E0
	for <linux-i2c@archiver.kernel.org>; Fri, 19 Jun 2020 10:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B7972080C
	for <linux-i2c@archiver.kernel.org>; Fri, 19 Jun 2020 10:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jdmx4jid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732048AbgFSKZ2 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 19 Jun 2020 06:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732332AbgFSKYl (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 19 Jun 2020 06:24:41 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16034C06174E
        for <linux-i2c@vger.kernel.org>; Fri, 19 Jun 2020 03:24:27 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 97so6908750otg.3
        for <linux-i2c@vger.kernel.org>; Fri, 19 Jun 2020 03:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SJAW+EWFKTAkhJuvQ0R/dCvDVgZTQuU0f892zwKxaQ8=;
        b=jdmx4jidsb7FKZ0HuzEba1r3W+lkQ4IzIrcSB6YGKy7fabD9UvT1BoY7+3Th9GH5F5
         kYqzM2IDESZnyniYxA+2T1zWQD4j0jMwbqavx1diICqli9JTB+X/RI7EHoug9Ltdtcsy
         v3TP4xorwKDleKwA93XNbvuM1G5ApVD+PFRN90c+jZWJNFJNLW9ufqT3pdvrfBCGLTNy
         guDgdlGrwVZ8JjcjrA272uX3FB8gc+9nQRoCuxbV+3wmYM3nXVgnzeoTRS0vnDJ1JAy1
         2zlKtfTPCWPWxbKGlS76SGX0RdRB3WczPQ6Q+JEqfIPe832vJ6ZIBd+U4L8FgzbT3zMc
         hThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SJAW+EWFKTAkhJuvQ0R/dCvDVgZTQuU0f892zwKxaQ8=;
        b=iMgSnUgTLi0luoydg33x884+W5R5bf5xcyJ9FUBSvP4h0CMCEA0b9L25EZOmBLP2uY
         C2hRfWF4vld6td6m35pE8jXRteWt7q93S1n3dDkRzx4zGFgCvenxzk9IKgyJDpqSwiqN
         lYYGYJz4xufBzuFdmVjHhTGcU0eL6jyLoc8uUbu+SlPrbuN3rPkjdVMt8l52X30FQx87
         Ka8yXBU8l/uEZjP83RRvZX/YDHHbKPfZJpJumYXaCKbLuCgAU4f+elvchC7E7ERhGZGy
         WfXOt+vgE3E5WPvim8MnMwvPPKmGidnWcGc3P1ydM3Ttegc5xxbKJyzem9MFBxZaBxSO
         lDpw==
X-Gm-Message-State: AOAM531n4t29+8pZHfKNECMPXdwpDUo8EM9lQCYwK3Y/dYNHrZTbDhNd
        v7oyHvPeVCo/5fqoPjmUakydWCrDfeIiadbpugnaRMp1GQYe0A==
X-Google-Smtp-Source: ABdhPJxa/y8FN7caqgtz7qSONZclcq4jF0B0RqZECd20fcqL970UK8QkoT97nfUftfuvuAQTFmrTkymBRnuQi1IK2L4=
X-Received: by 2002:a05:6830:8d:: with SMTP id a13mr2370887oto.91.1592562266520;
 Fri, 19 Jun 2020 03:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <1592561864-6406-1-git-send-email-loic.poulain@linaro.org>
In-Reply-To: <1592561864-6406-1-git-send-email-loic.poulain@linaro.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 19 Jun 2020 12:24:15 +0200
Message-ID: <CAG3jFyt3=4TjR6JMVb7JLV_aUi+5kVtM9Ax8d8s+MYrrof70kg@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: Add robert and myself as qcom i2c cci maintainers
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     wsa@the-dreams.de, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Signed-off-by: Robert Foss <robert.foss@linaro.org>

On Fri, 19 Jun 2020 at 12:12, Loic Poulain <loic.poulain@linaro.org> wrote:
>
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 50659d7..632c441 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14023,6 +14023,15 @@ L:     dmaengine@vger.kernel.org
>  S:     Supported
>  F:     drivers/dma/qcom/hidma*
>
> +QUALCOMM I2C CCI DRIVER
> +M:     Loic Poulain <loic.poulain@linaro.org>
> +M:     Robert Foss <robert.foss@linaro.org>
> +L:     linux-i2c@vger.kernel.org
> +L:     linux-arm-msm@vger.kernel.org
> +S:     Maintained
> +F:     drivers/i2c/busses/i2c-qcom-cci.c
> +F:     Documentation/devicetree/bindings/i2c/i2c-qcom-cci.txt
> +
>  QUALCOMM IOMMU
>  M:     Rob Clark <robdclark@gmail.com>
>  L:     iommu@lists.linux-foundation.org
> --
> 2.7.4
>
