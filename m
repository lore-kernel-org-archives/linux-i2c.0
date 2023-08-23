Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100D6EE49A0
	for <linux-i2c@archiver.kernel.org>; Wed, 23 Aug 2023 14:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjHWOQC (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 23 Aug 2023 10:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbjHWOP7 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 23 Aug 2023 10:15:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED44AE74;
        Wed, 23 Aug 2023 07:15:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 769A365578;
        Wed, 23 Aug 2023 14:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC97C433C7;
        Wed, 23 Aug 2023 14:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692800152;
        bh=A5t7oKsaIFF6FaZ2i4bS5BdT5O+At3AAk1Cjr/ElblA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K0Sv6LHl3X/RIfE4CoF2ftmMsisRJKONOECbcErxas0HY8QfdLwsXN30Ev50cHvR5
         /w4LcH+ko8ibR2eoWHC9X6Q4gfVyAGKw3soHtjsYtJKdoyd02tNkcBzskWBu6ift2O
         z1mlROrJ1owhpnlxoxbXP7olo9pWwkbN13Uv/peaSnFBU1Js+rdSvatarIo7WdTsAx
         D5X0JCZIl3RNIe9YuUhnIWdz7S78vL7q2mf7WPv22aKpE0mTlOePksEJC8D7hu1gIj
         xR9wZ7JOZa4tzLBnCJkjEuc9NzTKmbLxjULw0s5EMJUo4UInk9ryYgkPoWxMhMaO4i
         To3CXROgRp+Sg==
Date:   Wed, 23 Aug 2023 16:15:47 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Peter Rosin <peda@axentia.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        naresh.solanki@9elements.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v16 2/4] dt-bindings: i2c: Add Maxim MAX735x/MAX736x variants
Message-ID: <20230823141547.w33ieqnu4oshkhld@intel.intel>
References: <20230821062027.2631725-1-patrick.rudolph@9elements.com>
 <20230821062027.2631725-3-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821062027.2631725-3-patrick.rudolph@9elements.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi Patrick,

On Mon, Aug 21, 2023 at 08:20:22AM +0200, Patrick Rudolph wrote:
> Update the pca954x bindings to add support for the Maxim MAX735x/MAX736x
> chips. The functionality will be provided by the existing pca954x driver.
> 
> For chips that are powered off by default add a regulator called vdd-supply.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

you forgot:

Acked-by: Peter Rosin <peda@axentia.se>

Adding it for b4 and patchwork.

Thanks,
Andi
