Return-Path: <SRS0=mSpG=6S=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA99DC28CBC
	for <linux-i2c@archiver.kernel.org>; Mon,  4 May 2020 00:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE46220735
	for <linux-i2c@archiver.kernel.org>; Mon,  4 May 2020 00:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588552061;
	bh=0Tty1V951Gt0QKZwHy3rwBw3E5MgSe0aqGGl80GVTLc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=H07HbVChUnFDrHZ9x+3r3+J9J2jpj3OMtuhRShhN/xszApEVLBkB1d44Cyor68fby
	 FXapC6k0Wk4W+Mm2qPsqmohPR5+bFt8InQDxCjzLU8kp2KsYM/7rTDxjMcXvCDjqWU
	 PN/0RvQVy6OoRLvG1bpaXGf4Xz6nuDThCY+QurDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgEDA1l (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sun, 3 May 2020 20:27:41 -0400
Received: from condef-09.nifty.com ([202.248.20.74]:51969 "EHLO
        condef-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgEDA1k (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 3 May 2020 20:27:40 -0400
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 May 2020 20:27:39 EDT
Received: from conssluserg-05.nifty.com ([10.126.8.84])by condef-09.nifty.com with ESMTP id 0440G9b4006708
        for <linux-i2c@vger.kernel.org>; Mon, 4 May 2020 09:16:09 +0900
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 0440FoVN019532;
        Mon, 4 May 2020 09:15:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 0440FoVN019532
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588551351;
        bh=lq9Uzj7pb5PQFw+VXMD0iM6sIqPMlYMT850vnF71eIo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HsBDug0cOUu+9rxknFugrSdSxYyIwJWW+s7GijIMgAsUFtnpSIoyJrCDiye8j/kPj
         scqMRUqeJSqFN68aD2vEzf6d6n1Ue6VPpBQaWbCxXrXc4JAICS1nlR4h0brVGviO3Q
         Um+tGVfkYN2958pvKXwzR8tfx0Ym7BsZebBqyuGvoFFH62xgqv30hVb/KC8qlaRXn/
         7Sjf0dNVy8Ov6IVcN+Rf3In46YOinVAtXp3APTbL98oo8HNkv5oeYhjbVZ/bBpgcP8
         v9dbfRvLJB8cy/+S/72yjVB/d678m9ebiBlYDXkKYh4TAshvcuSxQCLS4P9a9zIn9M
         M9v+0sXHqm50w==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id g2so10088114vsb.4;
        Sun, 03 May 2020 17:15:51 -0700 (PDT)
X-Gm-Message-State: AGi0PuYRev+NcrVBUzrKem0r7PRPZGwmGE+3H+7TtOEFMG7iKmZczw3n
        N9KAQ0aMg7Ihy+WVoalShjaQc8Z2oM//xBmnQCc=
X-Google-Smtp-Source: APiQypJF8ynSDKYMiOHyG945XHqTJ6m0pJp8ZtLPkrwqgVAa+C06wpn4TeCNBGXLAEEkRYNonO/ieONdJXKxdJY3GoI=
X-Received: by 2002:a67:e94d:: with SMTP id p13mr9916129vso.215.1588551349876;
 Sun, 03 May 2020 17:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200503120847.13528-1-aishwaryarj100@gmail.com> <20200503132906.GA32207@ninjato>
In-Reply-To: <20200503132906.GA32207@ninjato>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 4 May 2020 09:15:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNASXgD7Y2SToycCLYX2zVN-L5uWRoCzQ3N7MjoT+j0KfkQ@mail.gmail.com>
Message-ID: <CAK7LNASXgD7Y2SToycCLYX2zVN-L5uWRoCzQ3N7MjoT+j0KfkQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: uniphier: Remove superfluous error message in uniphier_i2c_probe()
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>,
        linux-i2c@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Sun, May 3, 2020 at 10:29 PM Wolfram Sang <wsa@kernel.org> wrote:
>
> On Sun, May 03, 2020 at 05:38:47PM +0530, Aishwarya Ramakrishnan wrote:
> > The function platform_get_irq can log an error by itself.
> > This omit a redundant message for exception handling in the
> > calling function.
> >
> > Suggested by Coccinelle.
> >
> > Signed-off-by: Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>
>
> Please send only one patch for the whole I2C subsystem.
>

Yeah, and then please add my ack to v2.

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


-- 
Best Regards
Masahiro Yamada
