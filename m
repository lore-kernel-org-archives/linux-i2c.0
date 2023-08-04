Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3CDC001DE
	for <linux-i2c@archiver.kernel.org>; Fri,  4 Aug 2023 21:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjHDVBA (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 4 Aug 2023 17:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjHDVA7 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 4 Aug 2023 17:00:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4185E42;
        Fri,  4 Aug 2023 14:00:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 464E262089;
        Fri,  4 Aug 2023 21:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50895C433C7;
        Fri,  4 Aug 2023 21:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691182857;
        bh=wRZ3rQW3njry72R33WoUyNQvRAO3k+4UfyNKdLLPmRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o73Gcf2v71Pj0DgU8IChVQD6LzDROczuPJk4+7ngDZ9wu6HyyYqufCT8jTiNO1DB1
         /XajXZ5zw5vxCezmpUzBvmdy51tNkMSj3vpbkuX31eckFjxjJG9rlrS9Es/34jdYai
         V7Pda8D77L+BRrwGIFLyYY+acOPOuUU1amUs/Laa/9TeYMCZ1OvchbI/X3PlFniESg
         UHyNMK0aYQu+P1uBKqHmLncr55rQU3sXQqggN2HgEqD2YMS421JD11mNu2PRxF4Tyq
         xbhVlg5i8tecUh9lh625hl6NWvT+mYlXZog+i9YeQXREJ/UgfD50KbuVYX5uvwMDKs
         mwm7Hy1y5REfA==
Date:   Fri, 4 Aug 2023 23:00:55 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>
Subject: Re: [PATCH v1 5/9] i2c: designware: Always provide ID tables
Message-ID: <20230804210055.i4hnjsr4ltfak53e@intel.intel>
References: <20230725143023.86325-1-andriy.shevchenko@linux.intel.com>
 <20230725143023.86325-6-andriy.shevchenko@linux.intel.com>
 <7be19d99-b197-662c-5157-dfdd9c793e3c@linux.intel.com>
 <ZMgT8bYGnGwTSAPf@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMgT8bYGnGwTSAPf@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi Andy,

On Mon, Jul 31, 2023 at 11:05:05PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 28, 2023 at 03:33:59PM +0300, Jarkko Nikula wrote:
> > On 7/25/23 17:30, Andy Shevchenko wrote:
> 
> ...
> 
> > > +/* Work with hotplug and coldplug */
> > > +MODULE_ALIAS("platform:i2c_designware");
> > 
> > Perhaps this comment can be retired, i.e. dropped.
> 
> Then it needs to be done in a separate patch, because in the other file the
> comment will be left untouched.

You are being a bit too religios here... if you want to stick to
this, then you need to send a patch for sorting by ID, a patch
for grouping together MODULE_*, a patch to remove this comment
and a patch to always provide the id table.

I think, "while at it", you can safely remove the redundant
comment :)

It doesn't make too much difference to me anyway:

Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 

Andi
