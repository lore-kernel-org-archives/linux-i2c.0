Return-Path: <SRS0=WXR7=54=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FC4C2BA2B
	for <linux-i2c@archiver.kernel.org>; Sun, 12 Apr 2020 09:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5F820709
	for <linux-i2c@archiver.kernel.org>; Sun, 12 Apr 2020 09:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVXiVuUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgDLJeX (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sun, 12 Apr 2020 05:34:23 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54143 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgDLJeX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 12 Apr 2020 05:34:23 -0400
Received: by mail-pj1-f67.google.com with SMTP id cl8so1479788pjb.3
        for <linux-i2c@vger.kernel.org>; Sun, 12 Apr 2020 02:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=B5NV/1cGE65VgrIJL5pL9fWcgqwNBj4B4/CGY144dBc=;
        b=MVXiVuUg23gQZifkPDgzy/EZGR1eILUgX0me5MksUuW6ij96h8cneH4wkjBXATmwBk
         FlhlGZ+kLlTp908vlzqHI7cX3nrsyBxHUyNq1swMb19+RKaILas957dp5vbAQopnXYR6
         fWqF9zPeomHb4TD98ppIHwoLio1NPl1PcGoLRv31vTW8xSvKn28TMjkEtMB3SqerH75h
         m1cbVPOlyQB8P3rFpFVCUpoUXAKJAO74VE8z1K3yWsrpjkD2NCDGsZD/EIZEz7aJjs9t
         qyrbXqUPs8EJwodVuahIpYT37Ho2Q/a5Yh3Ua2a6Fikj9KAaVVDb3gQhAPIjCw9mVm7z
         riag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=B5NV/1cGE65VgrIJL5pL9fWcgqwNBj4B4/CGY144dBc=;
        b=LQDVnx+uw3fnAvYbuA2q6iAx4pzwUVC8BXy8cpKLYwMq+Ea+M785pwdPbFc5VvjxmF
         U4GMIbdVpn+yryg2lBH8rXbDJ9AgZ82Lm2uQMhXlG9AO7dVWFk7WkY12hmMWd5A0c5/2
         FwREhviRBwDVwHHD7eqald6aq9LmPDVEHQl76oF/+NfM+lGYskFTjpZ3he9fuNmWbxfd
         8Xy2rv96pm7rjYsn75r3/mTIOcoeTHKWLaXCQ/1BJRaLtEOg6kkRZAZwxay/rUb6JAN+
         wAAcqFg7dsZIE+i7kAFsqXJslg0F+O6V33fnuIlqmXUWSsK6Sa8reuzVZffNo9UdyyJF
         2CEQ==
X-Gm-Message-State: AGi0PuatKFdu7UStTG4e6XolaAJTxX7Bg06CO8I3zAHmaiylXLYULfq4
        SS6gYiW/xD2RAO9mucwfP7FwcLPFG4erEIsydCx1qnzgFiYgSQ==
X-Google-Smtp-Source: APiQypLKNd8+f9HoFMfVKQ7chpEzc1cahYCb7YJFdsOyD6k/1kOBPcellkUqzBx0VwWHzJnQZGkt+mZOOu7RBxVo/rk=
X-Received: by 2002:a17:90b:1b05:: with SMTP id nu5mr15252799pjb.110.1586684063094;
 Sun, 12 Apr 2020 02:34:23 -0700 (PDT)
MIME-Version: 1.0
From:   19 90 <nineteenalreadytaken@gmail.com>
Date:   Sun, 12 Apr 2020 15:34:12 +0600
Message-ID: <CALDvbXkDBG1C2orB2PDrE5ox4A+kEf07XKCQoBrhjG+UnJniyg@mail.gmail.com>
Subject: [v6] i2c: imx: support slave mode for imx I2C driver
To:     biwen.li@nxp.com
Cc:     linux-i2c@vger.kernel.org, erbolsyn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi, Biwen

Looking forward for your patch -
http://patchwork.ozlabs.org/patch/1203640/, though would like to know
following:

- Do you plan anything else on this PATCH? There is no update since
March beginning. I might help with it if you give me instructions
what's left on your plate.

- What is the git commit hash your patch's based on?
   I tried to apply patch to the latest mainline (see below), but got
1 part of patch failed, but fixed it manually.

commit c0cc271173b2e1c2d8d0ceaef14e4dfa79eefc0d

- Would be helpful if anyone share which kernel builder (Yocto or
NXP's flex-builder) you use for this driver.

Thanks
