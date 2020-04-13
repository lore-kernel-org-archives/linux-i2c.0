Return-Path: <SRS0=EBOO=55=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BEFC2BA19
	for <linux-i2c@archiver.kernel.org>; Mon, 13 Apr 2020 10:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29A8A2054F
	for <linux-i2c@archiver.kernel.org>; Mon, 13 Apr 2020 10:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586773760;
	bh=FWeVRIyWkL/JshvXdy8LFNdpW91Hb8C+xVdufAOd0tE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c+XbPE104Fc3s8lCSCSZTJwz06/bzkJ4JY+v03MfRyHSSUdvG8rKtBf05fFBKUBeN
	 UaNZFC/6mQ6xZKEhQG2sUs00otO+nlE2JPLo7p0F8MxYUCKK0C+9dQjFVl9RiTZAk/
	 6wRbYBmbQLwwnUfrLskCTNqLnt3FQPPgNl90p9m0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgDMK3T (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 13 Apr 2020 06:29:19 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35321 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgDMK3S (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 13 Apr 2020 06:29:18 -0400
Received: by mail-ed1-f66.google.com with SMTP id c7so11401332edl.2;
        Mon, 13 Apr 2020 03:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BbWHjSsUQrh2BcH16tvNHQAGyd0qaneJDULzKls8PTI=;
        b=EACqoFiZ7YXHLwEmyEKf/nPegskQGdQBOonHclZldN6+NXmkU0B9/0omQdswXEroeh
         ZSIBZ9wCtq5xpvymxh3Yod3KAvGMepCyOsRLkiHzwEprXSSwX+NdLCVCuGflwpQs/j5F
         /NaFz5c7uCdeec6CIAOeKErmCPaMT26o6/7KE9Walu/q9ZhDXYy4bE38L0kgEWZPViEk
         FvMRMnCzIepQJIXTCe6BJIwKOUgpNWf6wDHD9zB7+c+pK7QFVf4agdSLks2qFHupaW7j
         0mZ7zEHVVB22kUfrQnfI9c/yxjov7Tnm8gdUJ2PtUMwse61u9kE6fqqXUsiJAqSPVxds
         pywA==
X-Gm-Message-State: AGi0PuaUrW1S8Nz0KPCdOU23OLRtd4AwLvnqoTwKagbq3doSR6SPQuTX
        aqyW9a5RPAm7yoZ8iJucJYY=
X-Google-Smtp-Source: APiQypIedXmcxclTCvgH+IO52NsgOdHSPUM9V+iK7b0YTTiONfFblt3zVHInsMkfzBnfKdib4MGamw==
X-Received: by 2002:a05:6402:16d5:: with SMTP id r21mr5822530edx.150.1586773757041;
        Mon, 13 Apr 2020 03:29:17 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id w3sm1557471ejf.21.2020.04.13.03.29.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Apr 2020 03:29:16 -0700 (PDT)
Date:   Mon, 13 Apr 2020 12:29:14 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        patches@opensource.cirrus.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ARM: mach-s3c64xx: convert to use
 i2c_new_client_device()
Message-ID: <20200413102914.GA14922@kozik-lap>
References: <20200326211014.13591-1-wsa+renesas@sang-engineering.com>
 <20200326211014.13591-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200326211014.13591-2-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Thu, Mar 26, 2020 at 10:10:14PM +0100, Wolfram Sang wrote:
> Move away from the deprecated API and remove printing a stale 'ret'
> value.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  arch/arm/mach-s3c64xx/mach-crag6410-module.c | 7 +++----

Thanks, applied.

Best regards,
Krzysztof

