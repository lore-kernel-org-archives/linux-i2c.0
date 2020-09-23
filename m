Return-Path: <SRS0=ieTw=DA=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD46C2D0A8
	for <linux-i2c@archiver.kernel.org>; Wed, 23 Sep 2020 11:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12C812193E
	for <linux-i2c@archiver.kernel.org>; Wed, 23 Sep 2020 11:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ATbpjY0G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgIWLoE (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 23 Sep 2020 07:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgIWLoE (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 23 Sep 2020 07:44:04 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CF7C0613D3
        for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2020 04:44:04 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id n22so19525060edt.4
        for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2020 04:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7QheX+bPrGcE7OBUWlDl5wldxiMyf1CPewuopM/hiBU=;
        b=ATbpjY0G+S3fr4WzOwwhqN5rBCGiLYdgISWCBGgSWgcyt2veb0AbhUt14LMydFc+BS
         JYnHG9PsGSia0Qud2yb2T90VcNu7vL4+WUIx8B3qwaPdJc5NgrYIdTdBAByeMfcdn6/Z
         YJdimn0ydYwGKZWCXUoHAsVFtFBqxK22OKP7kiJOdmrvLubreBwQz/NLHHpGk5YyTUmn
         Gao+kx/rGrMfAlMPbvAaD8/7xmrAcYQnU8LLL7UDqDU/6aSNAEeXO+kGSS5VTpq69wWC
         9LtImsq8Z8I8dNmhPFximoUL9g5e+LF3lRWj2XVRJMSxZpQZPg3T3C4eP18Tl5/x8mz5
         mXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7QheX+bPrGcE7OBUWlDl5wldxiMyf1CPewuopM/hiBU=;
        b=ApcvJG9qQJyRTvkZ/ATqBSnJig1M8idwC8wI4idmNnOLMaUa7dcDEgKvVoAJgXC8GT
         DciwMpP9daMZcuExMOz3Q5iX4b62aZVmHoLHhkAF+NG1SSTdlHhCg+U/64DFjtVbmJH+
         s/T9r7tURUFnXamDXRUm3TSH0LNOOhJzt7Vw/TEW9N+ybBzXShIn63k3wXb2rmec7R0q
         fapgMxS1wHmD8PbrSK1Hgl8RVrY6HgC/tpeVwm8XYgXyB4PEUHz0JIDg/tQe8z5TgxkS
         ghfAhJLig/GGEp0u/uKZ85BjkHhd7rFqlKqpBqciygC0RBSTV/j1uhQ/OKOnzGjDTpNr
         83fQ==
X-Gm-Message-State: AOAM531+SvvIi6V97vEYQ6Df3nfbAn/mWLjDmgSX3zrslF2O2JLGjZWb
        8NrV+JyvMxnQVgPONQiySWf7re09LVtXuVW4H0hE4A==
X-Google-Smtp-Source: ABdhPJxDXGWG56oy9xE+zXrcirgWdiVXFHBq+DDpXzyNIFVXs1KmmnvDLzwBVGwdJ6LiUyJ1hvEUXjbauHVZO4eVjVA=
X-Received: by 2002:a05:6402:1c1b:: with SMTP id ck27mr9080182edb.12.1600861442673;
 Wed, 23 Sep 2020 04:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200916094952.458003-1-jonathanh@nvidia.com> <CAMpxmJX6OxS-dxcK8whCm-Ups6Uts1iYE8bux_wAGeBPXihYBA@mail.gmail.com>
 <20200923113830.GA1846003@ulmo>
In-Reply-To: <20200923113830.GA1846003@ulmo>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 23 Sep 2020 13:43:51 +0200
Message-ID: <CAMpxmJUkS_VLa0A-izNngdSoyT36Y4PAEK1KTeXhQyo0XOCw4A@mail.gmail.com>
Subject: Re: [PATCH V2 0/5] Add support for custom names for AT24 EEPROMs
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Wed, Sep 23, 2020 at 1:38 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Wed, Sep 23, 2020 at 11:15:03AM +0200, Bartosz Golaszewski wrote:
> > On Wed, Sep 16, 2020 at 11:50 AM Jon Hunter <jonathanh@nvidia.com> wrote:
> > >
> > > For platforms that have multiple boards and hence have multiple EEPROMs
> > > for identifying the different boards, it is useful to label the EEPROMs
> > > in device-tree so that they can be easily identified. For example, MAC
> > > address information is stored in the EEPROM on the processor module for
> > > some Jetson platforms which is not only required by the kernel but the
> > > bootloader as well. So having a simple way to identify the EEPROM is
> > > needed.
> > >
> > > Changes since V1:
> > > - By default initialise the nvmem_config.id as NVMEM_DEVID_AUTO and not
> > >   NVMEM_DEVID_NONE
> > > - Dropped the 'maxItems' from the dt-binding doc.
> > >
> > > Jon Hunter (5):
> > >   misc: eeprom: at24: Initialise AT24 NVMEM ID field
> > >   dt-bindings: eeprom: at24: Add label property for AT24
> > >   misc: eeprom: at24: Support custom device names for AT24 EEPROMs
> > >   arm64: tegra: Add label properties for EEPROMs
> > >   arm64: tegra: Populate EEPROMs for Jetson Xavier NX
> > >
> > >  .../devicetree/bindings/eeprom/at24.yaml      |  3 +++
> > >  .../boot/dts/nvidia/tegra186-p2771-0000.dts   |  1 +
> > >  .../arm64/boot/dts/nvidia/tegra186-p3310.dtsi |  1 +
> > >  .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi |  1 +
> > >  .../boot/dts/nvidia/tegra194-p2972-0000.dts   |  1 +
> > >  .../nvidia/tegra194-p3509-0000+p3668-0000.dts | 14 ++++++++++++
> > >  .../boot/dts/nvidia/tegra194-p3668-0000.dtsi  | 16 ++++++++++++++
> > >  .../arm64/boot/dts/nvidia/tegra210-p2180.dtsi |  1 +
> > >  .../boot/dts/nvidia/tegra210-p2371-2180.dts   |  1 +
> > >  .../boot/dts/nvidia/tegra210-p3450-0000.dts   |  2 ++
> > >  drivers/misc/eeprom/at24.c                    | 22 ++++++++++++++++++-
> > >  11 files changed, 62 insertions(+), 1 deletion(-)
> > >
> > > --
> > > 2.25.1
> > >
> >
> > Just FYI: I'm fine with the at24 part. I can take them through my tree
> > for v5.10. Who is taking the DTS patches for tegra? Thierry? I can
> > provide you with an immutable branch if that's fine. I can't just ack
> > the at24 patches because they conflict with what I already have in my
> > tree for v5.10.
>
> I don't think I'll need an immutable branch since the device tree
> changes are not dependent on anything in the bindings, except maybe for
> validation, or the driver.
>
> Thierry

Ok sounds good then.

Bartosz
