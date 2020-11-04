Return-Path: <SRS0=rSJr=EK=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBAAC2D0A3
	for <linux-i2c@archiver.kernel.org>; Wed,  4 Nov 2020 03:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B2452071A
	for <linux-i2c@archiver.kernel.org>; Wed,  4 Nov 2020 03:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WclOyY96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbgKDD2n (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 3 Nov 2020 22:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgKDD2n (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 3 Nov 2020 22:28:43 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45A4C061A4D;
        Tue,  3 Nov 2020 19:28:42 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id x23so9626132plr.6;
        Tue, 03 Nov 2020 19:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Mt/RRK3an2hQPGbvsD2/R/AL64mvbosYpdUxFPxb2m8=;
        b=WclOyY96b15QadMQxE/zRVI5+wiy86jbRFZs0lg6gXb1B7RPvps7ruITvDbzCCCH5+
         Ugok5Rdxa307HtpHk3+E+OVCDMhEJyWUZ3bz8GVoKnnZbwfDhN4PKPqNOulfY65o6wh2
         8pjFGLcVFxkQeaqsl5X/WZZ+ERDnQjeh73/LoHl34GoQFiO4FTd9iRsMnyDjog9axYLT
         xMehspWKeMXVJ3KIr4cqwkKW+g6Xk6PWtkEiSNe1q4n08U90aidM3wMYx4EK23Eskmc4
         JbhnLN/15i6bW2goAExeDwlnqFYeHG6BKWqP5F4tvejOV5+ntQJO3Vr5/Hb96ox9vjC9
         AblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mt/RRK3an2hQPGbvsD2/R/AL64mvbosYpdUxFPxb2m8=;
        b=RySM2XaaXMZDsnLS1kuRDs6l1hj1nA8FeRko0fxs94Up7jVToJ6lXDZiI8zxX7WRbe
         d8WQmMu3EivhrBO+4KjDZGICEgS1R5BJabEYTo4FiTOnFo2pFbnrNCpm+3EMIQ4TNcfp
         JKP+h1esRoY1vqJJpcjz74RgVAeagCExa3es4t3GU+DU4uuANInl1Kookr5TI8MocIiP
         w5aMTiaBqAq+/ArgIKzYZUmpdNWG2F7IYB5O7YzrsrTe78LkPN336k0Bs6Flk+D+0Vrr
         t5MsQ3bVZYFV5EKRFBsbHEUXfA5b+ze4owBQvUOUDM+9ebK0Gw85q0ol0bMqTEB/k9ha
         PIdw==
X-Gm-Message-State: AOAM531mSuKQsevjDNDtbQ06/zTByxFh56QStBNKMnzqtqRYzMUvqU5h
        P19MU91UbUJGkqn2uIHN6/qjiKnh4xs=
X-Google-Smtp-Source: ABdhPJzBHB7KZeH1cj3Irv9cB+2DgtQi/j0gssxzYxE77mu4AU61W3spBjZA0E8HCE63AQBNuBnWVg==
X-Received: by 2002:a17:902:d917:b029:d6:d1b8:5d9a with SMTP id c23-20020a170902d917b02900d6d1b85d9amr10331443plz.72.1604460522073;
        Tue, 03 Nov 2020 19:28:42 -0800 (PST)
Received: from [10.230.28.234] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y23sm514067pju.35.2020.11.03.19.28.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 19:28:41 -0800 (PST)
Subject: Re: [PATCH 3/5] i2c: brcmstb: remove unnecessary CONFIG_PM_SLEEP
To:     Coiby Xu <coiby.xu@gmail.com>, linux-i2c@vger.kernel.org
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20201029074654.227263-1-coiby.xu@gmail.com>
 <20201029074654.227263-3-coiby.xu@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <4b5622c5-fb29-fef5-1d56-76550118eca6@gmail.com>
Date:   Tue, 3 Nov 2020 19:28:39 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201029074654.227263-3-coiby.xu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org



On 10/29/2020 12:46 AM, Coiby Xu wrote:
> SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG.
> 
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>

You need to annotate brcmstb_i2c_suspend and brcmstb_i2c_resume with
__maybe_unused to avoid generating compiler warnings about unused
functions with CONFIG_PM_SLEEP disabled.
-- 
Florian
