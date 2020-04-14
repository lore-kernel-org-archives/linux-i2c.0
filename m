Return-Path: <SRS0=NIKx=56=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF20C2BA19
	for <linux-i2c@archiver.kernel.org>; Tue, 14 Apr 2020 16:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C76820678
	for <linux-i2c@archiver.kernel.org>; Tue, 14 Apr 2020 16:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586882258;
	bh=k9hJ2JywJenfK0iQECFcgZSz1u57nIXVFT2CZ5krMbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZRAHB56MmLDjZavZ1C2H8SJMGe41PSCCeQicVepgdo86H7eHDOZudYRgVUwA01BM8
	 CS25S1IBvzGsg8dcYRSjYCaB1HKy6K2An7stzf8+VaAG7gcefihwYKGarqIJVBZHVl
	 ofTZXFFKeZFt0ooKVDMVbEdzv+A+6A6r6yCcsQn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391848AbgDNQh2 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:37:28 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36517 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391833AbgDNQhO (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 14 Apr 2020 12:37:14 -0400
Received: by mail-oi1-f194.google.com with SMTP id s202so7731006oih.3;
        Tue, 14 Apr 2020 09:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jIvUlA66uFvx/00EVYaR8kJpiN2UPVF0b3hCl4OA1xo=;
        b=pRgxHbfceiXyLwFLafSsbbkd1hUwznWXO79Q8R9WvExzTiG/mGUtOQyY+CKxai+e3Q
         Bn5mmfgWBOVSTb3LojtctSVZPEtBv10KqmFa3vh8Hc8/bCLPJP8FJJRmd5twtVoMouMc
         hb3UliKIJF9ZIonUNuwrdXMgRGdokgiVwZ1/5ofW2ArKsG7uAeQlRZQyL2tCzG+Xe827
         0qB0UwbO4pkXEzy7YFvuMLbZTfNNG3ox6W7CDp/GrctVfBIPF5TVBXwPhpOZu+yKuK4L
         rnV06fo8r1NrBW+q5SzrTJ/e6XELFsHuB9sLR5u8NrCffrnJ+XLpidkR77qqsaWSicev
         O53w==
X-Gm-Message-State: AGi0PubXwupLN30D+WRR6chc06w28eu16vJNry6TOKcI7Gm/SBW0D80J
        LVNsZDVpAQC8FyvvnbS/97jXgtE=
X-Google-Smtp-Source: APiQypJkR6UcoYGEVORAFHlppvN5+UL0qeZSEHtFMBgD+pYKqCNXMKo+xTy5m/Hcu35x0L0MxMOJGg==
X-Received: by 2002:aca:c7c5:: with SMTP id x188mr16226493oif.130.1586882233216;
        Tue, 14 Apr 2020 09:37:13 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c13sm1173992otf.35.2020.04.14.09.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:37:12 -0700 (PDT)
Received: (nullmailer pid 1195 invoked by uid 1000);
        Tue, 14 Apr 2020 16:37:11 -0000
Date:   Tue, 14 Apr 2020 11:37:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc:     devicetree@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: Re: [PATCH] dt-bindings: i2c: xiic: Migrate i2c-xiic documentation
 to YAML
Message-ID: <20200414163711.GA1139@bogus>
References: <20200401134709.60421-1-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401134709.60421-1-iwamatsu@nigauri.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Wed,  1 Apr 2020 22:47:09 +0900, Nobuhiro Iwamatsu wrote:
> The document was migrated to YAML format and renamed xlnx,xps-iic-2.00.a.yaml
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  .../devicetree/bindings/i2c/i2c-xiic.txt      | 25 ----------
>  .../bindings/i2c/xlnx,xps-iic-2.00.a.yaml     | 49 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 50 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-xiic.txt
>  create mode 100644 Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
> 

Applied, thanks.

Rob
