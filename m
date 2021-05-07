Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1426C433B4
	for <linux-i2c@archiver.kernel.org>; Fri,  7 May 2021 11:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8237C6145D
	for <linux-i2c@archiver.kernel.org>; Fri,  7 May 2021 11:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbhEGLro (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 7 May 2021 07:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbhEGLrn (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 7 May 2021 07:47:43 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235C6C061574;
        Fri,  7 May 2021 04:46:43 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id i5so2219804pgm.0;
        Fri, 07 May 2021 04:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uR1cJZI3x3ph+ewlJwOwS07YkruOTk4an/PdVhtMkr8=;
        b=N/lqcnc7KQMPu+KrJo3SjocMaNEwCApyjgxnyQLW873BudWttiMLSpO4CUBq681LQL
         XBfOq5qyPexcbixQ6C3LY8k/dekbWv61aTSda52k3Jss+rBrxKEPxGKiiu0oci8iS+I3
         GfZ9D/GFQP157QsHBB7aYo1uT6L+ieQ09Iz5YldWpSOK4U3kRz39eqAaq56woDaBzEwW
         b22Lka5d7x5/A4PXygCls6CxhDGUo22iUBxMdctxDw2rszPIUw2bHJx56F4H7roRFrBS
         ULEr5IlntuCT5oNvY3yS4WlONi1CkH2oZO/boJi3YE+AvhgS4cITmZgJdFmTij450yCJ
         LjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uR1cJZI3x3ph+ewlJwOwS07YkruOTk4an/PdVhtMkr8=;
        b=ktw3PM9Nm31F2d8lVtVS3HbRHNH3y2wKlCymIYGInX6rWIxh54SiijnsCoCo7e1DJH
         lV9jMYy6a7X8qMQkLNePzOHuYfVVvDfdiRiCpMsszZypXccAb8BZlJcanmiKeeCHH747
         snHwMAsb28Sa0hxlSzQMdeHqDfyAkIb6cPRvfdytcDTB6GtMxU4En26piPqnRCfXlCef
         TJSICQ2doKa3F6SkuIfVuAgOMhmqwzZgyUzu29MxBFj9uDeLRkiK/5R5FuupVAP0Z6nX
         nVKIr+MkbodJn65yo9WE4pmIiogBjtc56WfTwYZAdOvKbt4DzNsS7auRaFY5UPpRFDQQ
         hUqA==
X-Gm-Message-State: AOAM532abKaN68Vr2t50EYAmu91dQdU+AP00K23fWK2LzXkWeOaJdNWf
        bKYPJK0ULtp+tiws0Yt9DJaDHbdo+jPhz7KmTKolU46rUrdAOA==
X-Google-Smtp-Source: ABdhPJyz37HmRfpOxF5mQuByQ13JMKLXTuCkq3L0IM/6cmbTE6aB/KmPmgneubUc0gs1GQQ1xr8QHMWXkkWhAUYArAo=
X-Received: by 2002:a63:cd11:: with SMTP id i17mr9429849pgg.74.1620388002532;
 Fri, 07 May 2021 04:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210507004047.4454-1-chris.packham@alliedtelesis.co.nz> <20210507004047.4454-4-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20210507004047.4454-4-chris.packham@alliedtelesis.co.nz>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 7 May 2021 14:46:26 +0300
Message-ID: <CAHp75VcEzgKjOD6WQ1=YAwK_hhZr=XtcmXZL8rK78gb7iXDbDg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] i2c: mpc: implement erratum A-004447 workaround
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Fri, May 7, 2021 at 3:40 AM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> The P2040/P2041 has an erratum where the normal i2c recovery mechanism
> does not work. Implement the alternative recovery mechanism documented
> in the P2040 Chip Errata Rev Q.

Thanks.

> +static int i2c_mpc_wait_sr(struct mpc_i2c *i2c, int mask)
> +{
> +       int ret;
> +       u8 val;
> +
> +       ret = readb_poll_timeout(i2c->base + MPC_I2C_SR, val,
> +                                val & mask, 0, 100);
> +
> +       return ret;
> +}

So, now you may shrink it even further, i.e.

       void __iomem *sr = i2c->base + MPC_I2C_SR;
       u8 val;

       return readb_poll_timeout(sr, val, val & mask, 0, 100);

-- 
With Best Regards,
Andy Shevchenko
