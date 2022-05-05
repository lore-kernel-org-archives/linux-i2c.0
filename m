Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6942C433F5
	for <linux-i2c@archiver.kernel.org>; Thu,  5 May 2022 15:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351224AbiEEPl4 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 5 May 2022 11:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238590AbiEEPl4 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 5 May 2022 11:41:56 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5802182B;
        Thu,  5 May 2022 08:38:16 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D71A022205;
        Thu,  5 May 2022 17:38:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1651765095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pXolXFD/8YvBpURyLprQMd66AYD3SbrwCVNfcxqyXZk=;
        b=WTVjWTjBe9fipZn5j8DnckvD149tei47OB9AfFABgbqxXilmu+1KhmVirxdz20oZJhFufL
        LHrTCTnGrpgZSV0wgPW6MOgicicmQeEwwwFwA0MS4ZY5wSQNHYmxnsWeU5d6Oev5/RXsJi
        GGDHzyei9ewg+WTy85lGYpT+9ZdgNvA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 May 2022 17:38:14 +0200
From:   Michael Walle <michael@walle.cc>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Wolfram Sang <wsa@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] i2c: at91: Initialize dma_buf in at91_twi_xfer()
In-Reply-To: <20220505152738.1440249-1-nathan@kernel.org>
References: <20220505152738.1440249-1-nathan@kernel.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <9ffec526be965d37579b573f1a0debb6@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Am 2022-05-05 17:27, schrieb Nathan Chancellor:
> Clang warns:
> 
>   drivers/i2c/busses/i2c-at91-master.c:707:6: warning: variable
> 'dma_buf' is used uninitialized whenever 'if' condition is false
> [-Wsometimes-uninitialized]
>           if (dev->use_dma) {
>               ^~~~~~~~~~~~
>   drivers/i2c/busses/i2c-at91-master.c:717:27: note: uninitialized use
> occurs here
>           i2c_put_dma_safe_msg_buf(dma_buf, m_start, !ret);
>                                    ^~~~~~~
> 
> Initialize dma_buf to NULL, as i2c_put_dma_safe_msg_buf() is a no-op
> when the first argument is NULL, which will work for the !dev->use_dma
> case.
> 
> Fixes: 03fbb903c8bf ("i2c: at91: use dma safe buffers")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1629
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for fixing.

Reviewed-by: Michael Walle <michael@walle.cc>

-michael
