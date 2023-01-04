Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5223C46467
	for <linux-i2c@archiver.kernel.org>; Wed,  4 Jan 2023 17:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjADRVJ (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 4 Jan 2023 12:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240067AbjADRUv (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 4 Jan 2023 12:20:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E876DF5;
        Wed,  4 Jan 2023 09:20:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAE8361745;
        Wed,  4 Jan 2023 17:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3D3C433D2;
        Wed,  4 Jan 2023 17:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672852849;
        bh=V9Nlr575fsIGjR4hqUwGZDJuhnTPVV17n4JpGgEjv6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N81Ya6qUM7Z+BoCLPpLUQp1BDEtWhV5n21I6odKD0N8lOr/+s4T9b1Ov4vOCWRewK
         7MfSGTzWxPCiNIyNB/mzp8z2zt8UlfcFzHFKU8TAAs/cugJViQTpWAT/EyLoffXrue
         inuh2+fBjb8rZQKGDDjOm1F9NUNrmO5QewnNrgnLRqtXTOUuLo7WgI9ZaAyodqIAB4
         FylJP3cqHpEMEfEYB5BWru3sKlgtFYSezV8E4oHLYzg3FWurY7/rnT6Hrngte9PUOC
         LzEoxuTWYPZRZ9L2v6YDo0HTu0Uq6rjx8KrwfmTlqhAawlZrcd+iPh/G+MJYeXJSmV
         9nv0ADGZNGGxQ==
Date:   Wed, 4 Jan 2023 17:20:42 +0000
From:   Lee Jones <lee@kernel.org>
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@armlinux.org.uk,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 3/6] dt-bindings: mfd: syscon: Document GXP register
 compatible
Message-ID: <Y7W1aiMRolW0UTqd@google.com>
References: <20221216183532.78933-1-nick.hawkins@hpe.com>
 <20221216183532.78933-4-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221216183532.78933-4-nick.hawkins@hpe.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Fri, 16 Dec 2022, nick.hawkins@hpe.com wrote:

> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Document hpe,gxp-sysreg compatible for GXP registers.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
