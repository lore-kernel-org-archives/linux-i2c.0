Return-Path: <SRS0=zHkP=CY=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE35CC433E2
	for <linux-i2c@archiver.kernel.org>; Tue, 15 Sep 2020 22:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B267E20770
	for <linux-i2c@archiver.kernel.org>; Tue, 15 Sep 2020 22:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600209174;
	bh=q42+/wpUmN4eZ0yu5PlUG685rGa98SKdmIV9BMHWRDQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=V/MBtLSGkjei81uZATkxTSmvJ2hQbNnDv+zg/hosTVWabQCs6aLUnQrI2QNFsdFdU
	 M/mC5cyL+7MDjiRcAxdkV0zEjgFAFp9Ct/30cTAGGt0rh89DfTnU70n1bG+oP6StRt
	 g4WpIk6CE5332UBKzkAxUIJh+i7UFHihDPTdikTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbgIOWcu (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 15 Sep 2020 18:32:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727601AbgIOQRQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 15 Sep 2020 12:17:16 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9EE220756;
        Tue, 15 Sep 2020 16:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600185814;
        bh=q42+/wpUmN4eZ0yu5PlUG685rGa98SKdmIV9BMHWRDQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RWf6/tCCvS0qMs/lq3DKOy4wAnM2Ydbn4uVhTdC+xYNTp9T01BPh1hhDaXmbKfrxE
         9BS2Sn8TOrnO0cR2dnohIIOBmL9S4a1gzEwGzWvj5M/rfNtzcyi2jnn7afttvpPiZa
         FC7viIn7yJKQKnVnYp+Mth73OM9gq/HopRSz7/H4=
Received: by mail-oi1-f178.google.com with SMTP id w16so4483485oia.2;
        Tue, 15 Sep 2020 09:03:34 -0700 (PDT)
X-Gm-Message-State: AOAM532t5RR5O8w3e1lqJYbbMCzo4eSoyb4cR+Yg60kBu1tM0mjU1Hhd
        79cwknahTUuQ21xQwejx/1CXMCe37RA7nKpqXw==
X-Google-Smtp-Source: ABdhPJyUKGvP0wG/kq4Hb79DLpxwODYN7/aFfqWCgGMAQfuXXCBLhCHDWE4ybg06z4KXQ4XmDknmNU4TjMY7z9SUGf0=
X-Received: by 2002:aca:4cc7:: with SMTP id z190mr48013oia.147.1600185814063;
 Tue, 15 Sep 2020 09:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200904131152.17390-1-paul@crapouillou.net> <20200904131152.17390-3-paul@crapouillou.net>
 <20200914221230.GA349829@bogus> <CS2PGQ.I4UMQBYTB15I2@crapouillou.net>
In-Reply-To: <CS2PGQ.I4UMQBYTB15I2@crapouillou.net>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 15 Sep 2020 10:03:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLUSZFf_3zgFrapc7vJETG9+XDTZPtD_yEBvi4GO3xPSA@mail.gmail.com>
Message-ID: <CAL_JsqLUSZFf_3zgFrapc7vJETG9+XDTZPtD_yEBvi4GO3xPSA@mail.gmail.com>
Subject: Re: [PATCH 3/3] i2c: jz4780: Remove of_match_ptr()
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     od@zcrc.me, Linux I2C <linux-i2c@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Tue, Sep 15, 2020 at 4:07 AM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi Rob,
>
> Le lun. 14 sept. 2020 =C3=A0 16:12, Rob Herring <robh@kernel.org> a =C3=
=A9crit :
> > On Fri, Sep 04, 2020 at 03:11:52PM +0200, Paul Cercueil wrote:
> >>  CONFIG_OF is selected by CONFIG_MACH_INGENIC, therefore we don't
> >> need to
> >>  handle the case where Device Tree is not supported.
> >
> > What about COMPILE_TEST? If not supported, why not?
>
> What about it? It will still compile fine with COMPILE_TEST.

CONFIG_OF could be disabled in that case, so the above reasoning doesn't ho=
ld.

Rob
