Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6382C001DB
	for <linux-i2c@archiver.kernel.org>; Fri,  4 Aug 2023 21:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjHDVdz (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 4 Aug 2023 17:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjHDVdy (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 4 Aug 2023 17:33:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED98EB2;
        Fri,  4 Aug 2023 14:33:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F13E62135;
        Fri,  4 Aug 2023 21:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3FEC433C8;
        Fri,  4 Aug 2023 21:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691184832;
        bh=0JKGztK0/oD7aW2VlkSpPy2xc9sL5OVF6VYPFTaXPZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MsAL6R4SUz7p07SIckyaW52dbuvOS8UJ/0jBF2+7BIPnNQo/0hzdwVCu1Z6qLfeP0
         aJyQrW6p3HVx70BncmxidyRION1rwsJxPpPVnqIO5rv86xv73wWql9bDizhZLxOJph
         S6I1XHR+Z0sMiZ/rcJL3qt9BdLMFKRNRLYgvHgYzQv8k3KRlA01XDyGQxFHblxIrY+
         bQBAYpvH+rARoDNLxbDMK1JJRm9IXmIpkR4FHzayJmcHhX6bUVzVvDWVj/OURZRy7C
         +oltfIK0p65w++7H6q9OyauP0hY/pIQa3qWFpcdEvdsaef4t+3PhyEA9soELx/9kiV
         mQBS3j8KWcLhQ==
Date:   Fri, 4 Aug 2023 23:33:49 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>
Subject: Re: [PATCH v1 8/9] i2c: designware: Get rid of redundant 'else'
Message-ID: <20230804213349.6wluqjt2v3grjrsl@intel.intel>
References: <20230725143023.86325-1-andriy.shevchenko@linux.intel.com>
 <20230725143023.86325-9-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725143023.86325-9-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Tue, Jul 25, 2023 at 05:30:22PM +0300, Andy Shevchenko wrote:
> In the snippets like the following
> 
> 	if (...)
> 		return / goto / break / continue ...;
> 	else
> 		...
> 
> the 'else' is redundant. Get rid of it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 

Andi
