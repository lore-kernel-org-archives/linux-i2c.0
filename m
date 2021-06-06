Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDD7C47096
	for <linux-i2c@archiver.kernel.org>; Sun,  6 Jun 2021 13:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84CEE61426
	for <linux-i2c@archiver.kernel.org>; Sun,  6 Jun 2021 13:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhFFNuN (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sun, 6 Jun 2021 09:50:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230133AbhFFNuJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 6 Jun 2021 09:50:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5B14613EF;
        Sun,  6 Jun 2021 13:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622987299;
        bh=IFPoTf4JD/1sbfPv4xFNeCXumKWp/y0Ky5X63u4JATw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2JjKaXRWWKXbd8PKw+b+oYOATNmiBZyrEZ7ROVT6hV/PwzA745E7fWgW4kZlEA/Jd
         NCOhEmJZfFW5UqAdCfhAFgdDjuWuxt5sus4Ww4R7/hCuzQXvsu3Nc6G70FLxC5Yhdh
         o0BXIQ7qgqMm3H/CnRvYJI2c1k0aQvvmmCYZ20Vw=
Date:   Sun, 6 Jun 2021 15:48:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.de>, Hector Martin <marcan@marcan.st>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] i2c: i801: Ensure that SMBHSTSTS_INUSE_STS is cleared
 when leaving i801_access
Message-ID: <YLzSH6bOOdwF9ooa@kroah.com>
References: <d012221b-9a44-eb77-f7c2-4e498ef5f933@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d012221b-9a44-eb77-f7c2-4e498ef5f933@gmail.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Sun, Jun 06, 2021 at 03:41:03PM +0200, Heiner Kallweit wrote:
> As explained in [0] currently we may leave SMBHSTSTS_INUSE_STS set,
> thus potentially breaking ACPI/BIOS usage of the SMBUS device.
> 
> Seems patch [0] needs a little bit more of review effort, therefore
> I'd suggest to apply a part of it as quick win. Just clearing
> SMBHSTSTS_INUSE_STS when leaving i801_access() should fix the
> referenced issue and leaves more time for discussing a more
> sophisticated locking handling.
> 
> [0] https://www.spinics.net/lists/linux-i2c/msg51558.html
> 
> Fixes: 01590f361e94 ("i2c: i801: Instantiate SPD EEPROMs automatically")
> Suggested-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/i2c/busses/i2c-i801.c | 3 +++
>  1 file changed, 3 insertions(+)
> 


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
