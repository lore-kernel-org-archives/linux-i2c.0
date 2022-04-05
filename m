Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F74C43219
	for <linux-i2c@archiver.kernel.org>; Tue,  5 Apr 2022 10:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbiDEKcX (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 5 Apr 2022 06:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiDEJsx (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 5 Apr 2022 05:48:53 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56DFBF42;
        Tue,  5 Apr 2022 02:38:51 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id ED257221D4;
        Tue,  5 Apr 2022 11:38:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1649151529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cme5G99Kw03Q3PMwqARJ3oZGQNThcMAZiuiroO5tMfI=;
        b=SY+iXZBaTEbsYxQm9C8NS+xIkam6S40SYinAgWqXx7yVBbP0U7m1PQ+n2FVS0nkMemAsSF
        oIusfw3o4ZSQmmb0tXMzcv8j6/kAkfduO5LydJR27QZVsOl7HNKG6yxxT5sM5GAxGZ9uGe
        95uH8xSM6toIgpjvoFtsnZCiRjU1ws0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 Apr 2022 11:38:48 +0200
From:   Michael Walle <michael@walle.cc>
To:     Codrin.Ciubotariu@microchip.com
Cc:     Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Claudiu.Beznea@microchip.com, sumit.semwal@linaro.org,
        christian.koenig@amd.com, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH] i2c: at91: use dma safe buffers
In-Reply-To: <46e1be55-9377-75b7-634d-9eadbebc98d7@microchip.com>
References: <20220303161724.3324948-1-michael@walle.cc>
 <46e1be55-9377-75b7-634d-9eadbebc98d7@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <bc32f1107786ebcbfb4952e1a6142304@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Am 2022-04-05 11:23, schrieb Codrin.Ciubotariu@microchip.com:
> On 03.03.2022 18:17, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> The supplied buffer might be on the stack and we get the following 
>> error
>> message:
>> [    3.312058] at91_i2c e0070600.i2c: rejecting DMA map of vmalloc 
>> memory
>> 
>> Use i2c_{get,put}_dma_safe_msg_buf() to get a DMA-able memory region 
>> if
>> necessary.
>> 
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Michael Walle <michael@walle.cc>
> 
> Reviewed-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

Thanks!

>> I'm not sure if or which Fixes: tag I should add to this patch. The 
>> issue
>> seems to be since a very long time, but nobody seem to have triggered 
>> it.
>> FWIW, I'm using the sff,sfp driver, which triggers this.
> 
> I think it should be:
> Fixes: 60937b2cdbf9 ("i2c: at91: add dma support")
> 
>> +       if (dev->use_dma) {
>> +               dma_buf = i2c_get_dma_safe_msg_buf(m_start, 1);
> 
> If you want, you could just dev->buf = i2c_get_dma_safe...

But where is the error handling in that case? dev->buf will
be NULL, which is eventually passed to dma_map_single().

Also, I need the dma_buf for the i2c_put_dma_safe_msg_buf()
call anyway, because dev->buf will be modified during
processing.

-michael
