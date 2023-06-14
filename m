Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4ADEB64D8
	for <linux-i2c@archiver.kernel.org>; Wed, 14 Jun 2023 00:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbjFNAbj (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 13 Jun 2023 20:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjFNAbh (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 13 Jun 2023 20:31:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0D419B6;
        Tue, 13 Jun 2023 17:31:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14ACC63C07;
        Wed, 14 Jun 2023 00:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A55C433C0;
        Wed, 14 Jun 2023 00:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686702683;
        bh=nKk8K4gS4i+dtpfNAE55MHLviuYdg41WXrQw29a7DDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nsRm+48dy7UJWp8X38FIFBAHAiC6WSPyXxjIzpQx9e3Adhy9X9UjVc89X2MQRPclC
         w9iIkeXieJYU0Ag3GjErFHBSZWkjp3dTK//t8uaXWuWPMya7W72fArMVG/DXHvlFPm
         AUmVVCDcpzl7zSpzo//jw2HDNoldBDZUv4lw/qGc/KCECWN82zsDlgX+dOiBlCev4i
         KwcTNovJ3g2VlOc4/SB6FkGKLZScrUKSWmouAANfA0Aj37tGyIvm1hGmy1SkN0xgxM
         FPLrn9EQ6X57RellvmtHMHZfgK7XW/An2DW/2kfuO96z+77hyjma5yFjPe0U0fjzxh
         mk3/lM3S/Ekxw==
Date:   Wed, 14 Jun 2023 02:31:19 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Korsgaard <peter@korsgaard.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: opencores: Add missing type for
 "regstep"
Message-ID: <20230614003119.daadqyydzax6jjvz@intel.intel>
References: <20230613201105.2824399-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613201105.2824399-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi Rob,

On Tue, Jun 13, 2023 at 02:11:04PM -0600, Rob Herring wrote:
> "regstep" may be deprecated, but it still needs a type.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Andi Shyti <andi.shyti@kernel.org> 

Thanks,
Andi
