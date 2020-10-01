Return-Path: <SRS0=QTNc=DI=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23C0C4727C
	for <linux-i2c@archiver.kernel.org>; Thu,  1 Oct 2020 15:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A073D207F7
	for <linux-i2c@archiver.kernel.org>; Thu,  1 Oct 2020 15:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hr0a0OQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732279AbgJAPkX (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 1 Oct 2020 11:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731885AbgJAPkX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 1 Oct 2020 11:40:23 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC372C0613D0;
        Thu,  1 Oct 2020 08:40:23 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n14so4867788pff.6;
        Thu, 01 Oct 2020 08:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CRuZs9KHdyyYtPSV5xRlxB+ahr3F1mpnApAGbMQJe8k=;
        b=Hr0a0OQtfgl4zIji3XUa3fFfK5RfJpAdY+yQbTzoZFPH2Qaj5Ekstbrf+p376/SWuX
         ey4jfFLEpIQDoFFQ04RY0xw/ZVkato24qgCdFW4tmDTFbxHbZakFX19SqtroY5RVY/ed
         MypLcyzoRvaek0+JXyylZo+szdxuhwoTTCtB+NDiO9EVcZ/fHGQBU8vj2krdUCLtJLWt
         ph+LnPVIJwpFTfMqEakJU9vQ0eDcs60i/i38w3DNdDYEW29leIjYwGnq+2bvNijooqDr
         Ay6MKB735oJdFDj3KkgKn84B/PbZLeHHcV/uuBU24GcbZ6VTjcllfzz0O+eRADTe6yR1
         Pf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CRuZs9KHdyyYtPSV5xRlxB+ahr3F1mpnApAGbMQJe8k=;
        b=qnC9QxLQl0aIrASN51Lg6BQU6pET0WTKuwnsgCzC/SV5Rc2me9lZSHQ61a5Abb5sVS
         mycUwOSpEwEEj4IuANP/Sa5WFJ9HUUiJiwOwG/Uo9YCQVywifWeKIn1jmdqqcwUfzspf
         sXCU48fFip8uJz1BfNyGf4D4etud01ch0/0j3fx86v3D1AmP4sdD+zlmArilPj58HaOQ
         vhTujT6HQ00q9+bjDQ/d8YF8NDMPr+gPoe0ZsIbQprzHR9vOXDhe78YduQfo19y4r02w
         cSCiWIXL6nP+y8WHtfWYuQh3pRIQlZ4g0zA299XAXHu8WUIx6boTiHJYKtWUFh9qVLo5
         aumQ==
X-Gm-Message-State: AOAM531ifbmdVWyARrY5zYr3YAnfXenxQhS3lGhn8xfIB46BubPkAtax
        MwXENA+CQ0Sm4c9H3M0Q4SvyRYLEASBSdB98Wv8=
X-Google-Smtp-Source: ABdhPJwT899GYXRw8GE7u8G1rtsolFPiTLN/iw8E9NSTOKvHjNfKr8yObP+2SnbsOi0vqP2w/nYBf0U5cszAq8Iq8ZQ=
X-Received: by 2002:a63:d648:: with SMTP id d8mr6561587pgj.4.1601566823284;
 Thu, 01 Oct 2020 08:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200930071342.98691-1-tali.perry1@gmail.com> <20200930093117.GY3956970@smile.fi.intel.com>
 <CAHb3i=sWxiVLCC0hfY+6-_x92ZEMY7Ctyyuz9CbMYxrH_BqAZQ@mail.gmail.com>
In-Reply-To: <CAHb3i=sWxiVLCC0hfY+6-_x92ZEMY7Ctyyuz9CbMYxrH_BqAZQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Oct 2020 18:40:04 +0300
Message-ID: <CAHp75Vc3Bw-dTpEmpeUpB4n5-8-xGPx+jm_HkB5Pj6Qr8U=CAw@mail.gmail.com>
Subject: Re: [PATCH v1] i2c: npcm7xx: Support changing bus speed using debugfs.
To:     Tali Perry <tali.perry1@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, Alex Qiu <xqiu@google.com>,
        Kun Yi <kunyi@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Thu, Oct 1, 2020 at 8:34 AM Tali Perry <tali.perry1@gmail.com> wrote:
> On Wed, Sep 30, 2020 at 12:31 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Wed, Sep 30, 2020 at 10:13:42AM +0300, Tali Perry wrote:
> > > Systems that can dinamically add and remove slave devices
> >
> > dynamically
> >
> > > often need to change the bus speed in runtime.
> >
> > > This patch exposes the bus frequency to the user.
> >
> > Expose the bus frequency to the user.
> >
> > > This feature can also be used for test automation.
> >
> > In general I think that DT overlays or so should be user rather than th=
is.
> > If we allow to change bus speed settings for debugging purposes it migh=
t make
> > sense to do this on framework level for all drivers which support that =
(via
> > additional callback or so).
>
> Do you mean adding something like this:

Nope. I meant to use DT description for that. I=C2=B2C core should cope
with DT already.
I do not understand why you need special nodes for that rather than DT
overlay which will change the speed for you.

--=20
With Best Regards,
Andy Shevchenko
