Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B4FC0015E
	for <linux-i2c@archiver.kernel.org>; Tue,  1 Aug 2023 23:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjHAXwd (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 1 Aug 2023 19:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHAXwc (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 1 Aug 2023 19:52:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C811B1
        for <linux-i2c@vger.kernel.org>; Tue,  1 Aug 2023 16:52:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 270556173F
        for <linux-i2c@vger.kernel.org>; Tue,  1 Aug 2023 23:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14966C433C7;
        Tue,  1 Aug 2023 23:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690933950;
        bh=FbBie7f8Ak5baPz3jl5nqWc3Zkl5vg8At/LcSILAFWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TQXyTbrvh3WcrlIVevcmc8pihTxluE0YJcl9wlEvUdQgSHCs8S2KDYK+HlJo9HIUt
         5w5ZQ5hU675bvb5TjATKzJP8V76jkN3rUXr6r1oMF8cVePvXWUUDJxLmUEyHr99Vdb
         Izfpjujh15z8TtrArB0r4Qao/nLeTY9SnVLb4C25nRq3dIXdJMZQQdxX5nhI3GAW3c
         7OwmJnaTs/42CfUINDkQ4S73XSLxFBUCjnyDqn2w4wezuF94m8ZPz/pRcYJthAXPOd
         OXUEPN1ipUnBd2NyzZQZWqcsGBQlbNi9Q2s41DUbSP0ljWI/5yGj/R8UMPrkCgS/Ua
         dZBMZCUK05LKw==
Date:   Wed, 2 Aug 2023 01:52:27 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     pierre-yves.mordret@foss.st.com, alain.volmat@foss.st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH -next] i2c: stm32: fix the return value handle for
 platform_get_irq()
Message-ID: <20230801235227.swouzgtcro4p4itv@intel.intel>
References: <20230731112755.1943630-1-ruanjinjie@huawei.com>
 <20230801233603.iztyd2wqhcogr72r@intel.intel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801233603.iztyd2wqhcogr72r@intel.intel>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi Ruan,

Just a nitpick here that does not affect my r-b...

> On Mon, Jul 31, 2023 at 07:27:55PM +0800, Ruan Jinjie wrote:
> > There is no possible for platform_get_irq() to return 0,
> > and the return value of platform_get_irq() is more sensible
> > to show the error reason.

can we rephrase the whole commit to:

  i2c: stm32: Do not check for 0 return after calling platform_get_irq()
  
  It is not possible for platform_get_irq() to return 0. Use the
  return value from platform_get_irq().

Two notes on the commit log:

 - Use capital letter after "i2c: stm32: Fix..."
 - This is not a fix, so that we shouldn't use the word "fix" in
   the title.

just little notes for future patches :)

Thanks,
Andi

> > Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> > ---
> >  drivers/i2c/busses/i2c-stm32f7.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
> > index e897d9101434..579b30581725 100644
> > --- a/drivers/i2c/busses/i2c-stm32f7.c
> > +++ b/drivers/i2c/busses/i2c-stm32f7.c
> > @@ -2121,12 +2121,12 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
> >  	phy_addr = (dma_addr_t)res->start;
> >  
> >  	irq_event = platform_get_irq(pdev, 0);
> > -	if (irq_event <= 0)
> > -		return irq_event ? : -ENOENT;
> > +	if (irq_event < 0)
> > +		return irq_event;
> >  
> >  	irq_error = platform_get_irq(pdev, 1);
> > -	if (irq_error <= 0)
> > -		return irq_error ? : -ENOENT;
> > +	if (irq_error < 0)
> > +		return irq_error;
> 
> Correct, from patch ce753ad1549cbe ("platform: finally disallow
> IRQ0 in platform_get_irq() and its ilk") this check is already
> done inside platform_get_irq();
> 
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 
> 
> Andi
> 
> >  
> >  	i2c_dev->wakeup_src = of_property_read_bool(pdev->dev.of_node,
> >  						    "wakeup-source");
> > -- 
> > 2.34.1
> > 
