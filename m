Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE30C001DE
	for <linux-i2c@archiver.kernel.org>; Wed, 12 Jul 2023 16:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbjGLQAa (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 12 Jul 2023 12:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbjGLQA2 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 12 Jul 2023 12:00:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D84E198A;
        Wed, 12 Jul 2023 09:00:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E94461802;
        Wed, 12 Jul 2023 16:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CF0C433C7;
        Wed, 12 Jul 2023 16:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689177626;
        bh=Kx3mh3w7vjnYoTMaIJ95Wmw+voRErv92EZwVApiB+VE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nCxeKP2hGd4kBnO3AMLuGr8oC219z3jedYCk0eFDqMvHtdGEwkA6s7CXw1G4EJJMX
         YBDMUhI8W+egtiRh+y5Z/+PnRArRV25Z0tK9jVo91G0dqzHRhsW4LB2ZxNIqPB4o6Z
         nubJl4K7DWtkKDOUyUR+UNRGollafdR8yOuKGMKCp5S93hQn2eO1Q+6MAL4W6H+aJh
         nlaxMOco0kfk6f1HA/U+ROSpzk5uIkjohctz0UgURFAT3uJDVFyG6xKTC3IIF94V4+
         FS690ATmvPGg+qgUGNe4hvl6XfXwmSG8bEB6Y2dGabDUj4hyDbQv4Ba58lN5cS20V5
         o3bCN2h0LSE9g==
Date:   Wed, 12 Jul 2023 18:00:22 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/11] i2c: pnx: Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <20230712160022.33iyxpqv4xvtjknz@intel.intel>
References: <20230710063351.17490-1-frank.li@vivo.com>
 <20230710063351.17490-11-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710063351.17490-11-frank.li@vivo.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi Yangtao,

On Mon, Jul 10, 2023 at 02:33:50PM +0800, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 

Andi
