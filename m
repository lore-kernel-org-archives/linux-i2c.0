Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EFAEB64D7
	for <linux-i2c@archiver.kernel.org>; Wed, 21 Jun 2023 10:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjFUKfV (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 21 Jun 2023 06:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjFUKet (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 21 Jun 2023 06:34:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244AF30DD;
        Wed, 21 Jun 2023 03:32:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE070614F5;
        Wed, 21 Jun 2023 10:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D93C433C9;
        Wed, 21 Jun 2023 10:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687343543;
        bh=hMshcCHgU6cWWCxkVJqWVDGfY9Sv/m+TXQzv8roldis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cD8Zn/rmoMj91WfJF9JmRD9SPPLMGqDsihW2Ka0iMznqO15dcSOIVkFbICpPi9/d0
         jAVmz1c1JZGYCX8wKPAF0CYeOjE2JS0DpYCSBWhZ3hFz5myDu7I482/iAamiOF3uMx
         GJHbFGPI+tKUDjsDEygZy20/2elB2hkD14KkJ2v5vqvDT5TYf9m7+Wu8+Ssb9iPQLO
         Me7jph3l6LFizlqV3aNZGhh0m4Cf9CTPpU6Xegl2jxEMRiYS5QELAtNE9AyAs6NPmE
         zyEPXpiFi3u+wJ6dRCIoXsmTGw29oHf33thELRlX/pvXdWT6F0tF2b3CG7pQbzogLO
         +2hsNhmrJCgyQ==
Date:   Wed, 21 Jun 2023 12:32:19 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] i2c: Add GPIO-based hotplug gate
Message-ID: <20230621103219.o2u33nsok7zngikf@intel.intel>
References: <20230619153732.46258-1-clamor95@gmail.com>
 <20230619153732.46258-3-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230619153732.46258-3-clamor95@gmail.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi,

On Mon, Jun 19, 2023 at 06:37:32PM +0300, Svyatoslav Ryhel wrote:
> From: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> 
> Implement driver for hot-plugged I2C busses, where some devices on
> a bus are hot-pluggable and their presence is indicated by GPIO line.
> 
> Co-developed-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/i2c/Kconfig            |  11 ++
>  drivers/i2c/Makefile           |   1 +
>  drivers/i2c/i2c-hotplug-gpio.c | 266 +++++++++++++++++++++++++++++++++
>  3 files changed, 278 insertions(+)
>  create mode 100644 drivers/i2c/i2c-hotplug-gpio.c

without going through the code I am missing the big picture here.

What is this actually doing? Is this a new bus driver support? Is
this a feature to existing drivers? Is the GPIO an irq line for
signalling hoplugging and can be used by any driver or just this
one?

Without further discussing technicalities, can you please explain
better and more in detail what is the scope of this patch, why
there is a need for such a patch, how this new driver/feature
has been implemented and finally how it can be used.

This would help a lot so that I know already beforehand what I am
going to read without figuring it out.

Thanks,
Andi

PS Please notice that my set of questions is even longer than
your commit log :)
