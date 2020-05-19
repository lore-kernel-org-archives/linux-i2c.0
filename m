Return-Path: <SRS0=M+6Y=7B=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455E5C433DF
	for <linux-i2c@archiver.kernel.org>; Tue, 19 May 2020 18:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23DDE20829
	for <linux-i2c@archiver.kernel.org>; Tue, 19 May 2020 18:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589914363;
	bh=6Pn0fN8x9T3DaCrnwcBRjMIhKk8IxgX7WAs6eYgUunM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nHOem30GDzA+bVzeqlGrklgNTFtiwv2DOME5usaLSroPiC55lyslRR+7TAth9WvJj
	 7US6kK+0UN8ZjXTVs95BN95BF337nfxwQk5fbYBo1wdR8TExJg12OU1l7Og6ja1/2f
	 QA7SmbJ+jVNxKQ3Y0UqmA4za6J7P8aeLC4m2ztUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgESSwm (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 19 May 2020 14:52:42 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:42750 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgESSwm (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 19 May 2020 14:52:42 -0400
Received: by mail-il1-f194.google.com with SMTP id 18so447435iln.9;
        Tue, 19 May 2020 11:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HMRNysK7idMmu7BvR5VTbVghXE/SUfxxeNA9Jql37t8=;
        b=A8hrrFtR98DX9hlRHlMPN4t68szlsRbRe3oTe/D2b+0KzVj59aHwt7ACF6sFCf1BWl
         e/dEBhGRO3eDcZyAbfIqWorPa3YjsTta0ID2sjvyB4s2JIrARxpE9BzSlLOd3mnaB/CB
         Nkb3fzTcbCb7xVTjMheMb1acYU3m9XBO2bLoUCBN9lDRTo588rxL7QFZJw+59mYTSc1N
         wogB0ASzKNas+elon48Ca/Qgona+1M9TEdC3399L0ICrf1/kUhsNMI2DhK6Rxiyz0y/a
         0V/vCMdV6O+C2tgUi9cWEj+w6YIvTFD0R7eoTz5kskLApzFL62w+WCHu2JPuDfAACRv+
         1b4w==
X-Gm-Message-State: AOAM530JLsxcv9LpwiQTDO/hZbaroxl9k5VJ7lAREx7Uj3SIY6g3uyzQ
        m5rOVu9LRGwGHH6BjCQXqQ==
X-Google-Smtp-Source: ABdhPJwICzymNwkDVvqws9DTa/sDPOXwVe8u63wyzZ9iLNMZ9uqIWCcioChH2qHFMYl8ToMRA8Zb9Q==
X-Received: by 2002:a92:2801:: with SMTP id l1mr473703ilf.132.1589914361419;
        Tue, 19 May 2020 11:52:41 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id r9sm130432ilm.10.2020.05.19.11.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:52:40 -0700 (PDT)
Received: (nullmailer pid 466038 invoked by uid 1000);
        Tue, 19 May 2020 18:52:40 -0000
Date:   Tue, 19 May 2020 12:52:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: eeprom: at24: Fix list of page sizes for
 writing
Message-ID: <20200519185240.GA465837@bogus>
References: <20200512122450.20205-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512122450.20205-1-geert+renesas@glider.be>
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Tue, 12 May 2020 14:24:47 +0200, Geert Uytterhoeven wrote:
> "258" is an odd power-of-two ;-)
> Obviously this is a typo, and the intended value is "256".
> 
> Fixes: 7f3bf4203774013b ("dt-bindings: at24: convert the binding document to yaml")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
