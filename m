Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDC0C433E0
	for <linux-i2c@archiver.kernel.org>; Thu, 25 Feb 2021 16:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EACF364F0D
	for <linux-i2c@archiver.kernel.org>; Thu, 25 Feb 2021 16:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbhBYQTM (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 25 Feb 2021 11:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbhBYQQ6 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 25 Feb 2021 11:16:58 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8A7C061788
        for <linux-i2c@vger.kernel.org>; Thu, 25 Feb 2021 08:16:16 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id b145so3929811pfb.4
        for <linux-i2c@vger.kernel.org>; Thu, 25 Feb 2021 08:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EPxzFIzk+OPBic5laaUxAjpd1oZixdsHlH5/TXOrqh4=;
        b=slidVYDex4rvIeHMvzeAWAu65DP1drxk8ezMTo7x885xrZBREQF9aAALdBVJeQx1Xc
         rOYHQqbFrGXUHiJ+/8J718LRcR8b3bjfRYH7nd1WaZFDCsANygW2XaOwWerFyZ8hBBDj
         Y/cEv/4SclrMxHbziw+KayAoQAvG6IIxzAb/ngTYKHAqcfXWfC2lHt1coRnTPktnOsah
         NOKwvV5rBc2cdaJmJ2l99YM8e2mHbrFOFDUtYpLksD9gwT6FLHbV2eLJrZiXqZFhNgSG
         Q5l48jv0dl5H4PXMOqgIiy+8C4enevzMY2Jr7qsZt49ZmEttdaWVkyKii64mVGPaby/2
         duYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EPxzFIzk+OPBic5laaUxAjpd1oZixdsHlH5/TXOrqh4=;
        b=F/MdbQLkjd6BIG7JeM11Ky1AWwMSCQyJNEBS7UgtkdgUGGERSBOui/UkAt85lUdkEA
         bS0Kkicx5rWb4759+XhYgcYsrIeC0GcEt2dxcUBRcnE7PpXotHkISdSoyvhzWbejNB3t
         nAb0t07lZkXWnqsl8iN2C3LYHR5Qq2uUTnKoOp1r4puhn9nKcPSy/x0Abm4wC0ybJ8RC
         b9MhOX0MZXEZ/TCwMiguV7atsCbrQt9+GekhSXjvCC+dda8MDD1kK5RZXgJIbnnY4+lw
         P42DXa3gGNtP4vcqvDuoXX3yk4bGJrMyF9Tnk6DS034LVQAEpEZ6L+t7hVYwBlUusfv3
         qb/A==
X-Gm-Message-State: AOAM530gpGPwlPRBYbFB6lqWugvJww+jQhOW73yAB3ywIUBKfhNZyxUN
        l8kvttLsWb8aX2U1GtaABaU=
X-Google-Smtp-Source: ABdhPJwaWN6akMojQ9JU6SeT/2Y0UH/NM2iDIlNs68TZl5s5Ni9JG3aZL8QU1Nr3Iw7ZYilbSh2lxQ==
X-Received: by 2002:a63:ec4d:: with SMTP id r13mr3625264pgj.53.1614269775702;
        Thu, 25 Feb 2021 08:16:15 -0800 (PST)
Received: from [192.168.1.67] (99-44-17-11.lightspeed.irvnca.sbcglobal.net. [99.44.17.11])
        by smtp.gmail.com with ESMTPSA id g19sm6310679pjv.43.2021.02.25.08.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 08:16:14 -0800 (PST)
Subject: Re: [PATCH] i2c: brcmstb: Fix brcmstd_send_i2c_cmd condition
To:     Maxime Ripard <maxime@cerno.tech>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa@kernel.org>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20210225161101.1856192-1-maxime@cerno.tech>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <8edadda5-ca19-6cc4-d539-2dec848fb73d@gmail.com>
Date:   Thu, 25 Feb 2021 08:16:07 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210225161101.1856192-1-maxime@cerno.tech>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org



On 2/25/2021 8:11 AM, Maxime Ripard wrote:
> The brcmstb_send_i2c_cmd currently has a condition that is (CMD_RD ||
> CMD_WR) which always evaluates to true, while the obvious fix is to test
> whether the cmd variable passed as parameter holds one of these two
> values.
> 
> Reported-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Fixes: dd1aa2524bc5 ("i2c: brcmstb: Add Broadcom settop SoC i2c
controller driver")

Thanks!
-- 
Florian
