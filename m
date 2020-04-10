Return-Path: <SRS0=Hle0=52=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4C2C2BA2B
	for <linux-i2c@archiver.kernel.org>; Fri, 10 Apr 2020 07:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36103206F7
	for <linux-i2c@archiver.kernel.org>; Fri, 10 Apr 2020 07:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgDJHzb (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 10 Apr 2020 03:55:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:38882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbgDJHzb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 10 Apr 2020 03:55:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 09F94AD07;
        Fri, 10 Apr 2020 07:55:28 +0000 (UTC)
Date:   Fri, 10 Apr 2020 09:55:28 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Adam Honse <calcprogrammer1@gmail.com>
Cc:     linux-i2c@vger.kernel.org
Subject: Re: [PATCH] i2c: Detect secondary SMBus controller on AMD AM4
 chipsets
Message-ID: <20200410095528.1a6d3d99@endymion>
In-Reply-To: <CAD_xsFPMx5zPuqEcaCq3urdFzrpvrY1NuoH-WqTWvNPNXn+sVA@mail.gmail.com>
References: <20200329174440.19342-1-calcprogrammer1@gmail.com>
        <20200330183108.58c63736@endymion>
        <CAD_xsFPMx5zPuqEcaCq3urdFzrpvrY1NuoH-WqTWvNPNXn+sVA@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi Adam,

On Sat, 4 Apr 2020 13:20:58 -0500, Adam Honse wrote:
> I'm not sure what all chipsets are covered by the KERNCZ ID.  We have found
> that the secondary bus exists on all AM4 chipsets and on X399 as well.
> Considering the older Hudson 2 has the same secondary bus (which is
> correctly detected without a patch on my old FM1 home server, also at
> 0x0B20) I would believe the secondary bus exists on all chipsets.  I could
> add a revision check though.  My X370 reports (rev 59) in lspci.

Fair enough, let's assume it's present on all chipsets and we can
refine later if needed.

If so, can you please merge the kerncz check with the hudson2 check
right before as we do the same for both?

Then please submit with your Signed-off-by statement and I'll review
and ack the patch for Wolfram to commit.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
