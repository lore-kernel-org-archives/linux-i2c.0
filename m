Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42287C27C40
	for <linux-i2c@archiver.kernel.org>; Thu, 24 Aug 2023 16:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbjHXQ51 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 24 Aug 2023 12:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242900AbjHXQ5S (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 24 Aug 2023 12:57:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A92212B
        for <linux-i2c@vger.kernel.org>; Thu, 24 Aug 2023 09:57:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28FF566424
        for <linux-i2c@vger.kernel.org>; Thu, 24 Aug 2023 16:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACC4C433C7;
        Thu, 24 Aug 2023 16:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692896227;
        bh=U8xwxwIxHb/+1cR7BVHH8EBcYrBz4G6jS4mn0Qf+8oM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QTADnQKOn0J1wde5/m6v6qe5Pkvd78mfHwnGJzFQCCL9cFinaRZIa57JenkrzAL5j
         gUWukY6Bb4y4MygYM5ge4TBBGlwmBYa7JHIgIkVqS6JcwrMAdgbPMmxVjw1QAGzI6y
         8oYo14CxRYeEt4L5lfLU61SaRdcLneNDBPfM5d15FI6XstCzcZtyWApE2Is2KzN6AM
         /QdSqDHJpT4yfNsMbIy2Zo0Tda5a9RESuwbFkGGkPzlNoB+yf6H5yaFxx3YJeEQGHp
         v0Jiwoz6TnD2rVDcZep+LEB7f6ICygtZsRSwzc28hKQ62qTf0OJiGQbULWvAMv4z+P
         CFocrtlPd10IQ==
Date:   Thu, 24 Aug 2023 18:57:03 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Hans Hu <HansHu-oc@zhaoxin.com>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        cobechen@zhaoxin.com, hanshu@zhaoxin.com
Subject: Re: [RFC] i2c: whether need create *-common.{c,h} for i801 piix4
 viapro driver
Message-ID: <20230824165703.f34girkhqw6vbqsp@intel.intel>
References: <a74b19fc-1c7d-6e69-1f66-0bf81b4912f0@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a74b19fc-1c7d-6e69-1f66-0bf81b4912f0@zhaoxin.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi Hans,

> Recently I plan to submit one SMBus driver for Zhaoxin platform.
> I studied the existing SMBus drivers, including i2c-viapro.c,
> i2c-i801.c, and i2c-piix4.c. These driver's register layout looks
> similar, and the implementation of their .smbus_xfer callback
> functions is similar too.
> 
> Zhaoxin SMBus also uses some of the same design scheme
> (follow VIA's design IP). Then, should I create *-common.{c,h}
> for these dirvers? Or keep the register layout and .smbus_xfer's
> implementation in my own driver? Or any other suggestion?
> 
> Look forward to your suggestions!

Sorry for the late reply, I see that you already sent the
patches, will check them.

Andi
