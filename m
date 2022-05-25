Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9C8C433FE
	for <linux-i2c@archiver.kernel.org>; Wed, 25 May 2022 13:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbiEYNmf (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 25 May 2022 09:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244495AbiEYNmd (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 25 May 2022 09:42:33 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0406E6CF4B
        for <linux-i2c@vger.kernel.org>; Wed, 25 May 2022 06:42:31 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 45FCF40003;
        Wed, 25 May 2022 13:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653486150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GiRyknvJ8CjdhZKVhHk8iWItE9scQO33fBzMfsE2OtQ=;
        b=hkxumdB055Z1noJuNsr/JiNAtlqfNblnwOO0UChW5Yb50nqjSjr1lWoLglUHDfRgKS33MU
        R5VzwEP+iAskTCqkVJGThPdJWLnqcBzyVX9t2oBvORoTbGhsKhTJMFRIrf4JbDXQx0Jx6x
        CGabko3aCMeQJUeK7muLzURidEE3cQF+u4eZma4hXWYZJJ3ldyUMSB8ePp8rVqbUFs6mUh
        nv60fZIHwv43fgzQajWytEqtii6AAUiGk5BEhUqtLQfDXZrzRZ80fqat37qoEqrQuRauGr
        hDO0Q2kYr4Mo/Ynzy/VcboLnbvoEZ0K3dm7sFOSiTUYp0f/PcAKmYOchZQRMSw==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Wolfram Sang <wsa@kernel.org>,
        Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-i2c@vger.kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH] i2c: mv64xxx: Remove shutdown method from driver
In-Reply-To: <YoiGLxhfgYxLURyt@shikoro>
References: <20220325180625.31414-1-macroalpha82@gmail.com>
 <YoiGLxhfgYxLURyt@shikoro>
Date:   Wed, 25 May 2022 15:42:30 +0200
Message-ID: <87pmk1ybi1.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Wolfram Sang <wsa@kernel.org> writes:

> On Fri, Mar 25, 2022 at 01:06:25PM -0500, Chris Morgan wrote:
>> From: Chris Morgan <macromorgan@hotmail.com>
>> 
>> When I attempt to shut down (or reboot) my R8 based NTC CHIP with this
>> i2c driver I get the following error: "i2c i2c-0: mv64xxx: I2C bus
>> locked, block: 1, time_left: 0". Reboots are successful but shutdowns
>> freeze. If I comment out the shutdown routine the device both reboots
>> and shuts down successfully without receiving this error (however it
>> does receive a warning of missing atomic_xfer).
>> 
>> It appears that very few i2c drivers have a shutdown method, I assume
>> because these devices are often used to communicate with PMICs (such
>> as in my case with the R8 based NTC CHIP). I'm proposing we simply
>> remove this method so long as it doesn't cause trouble for others
>> downstream. I'll work on an atomic_xfer method and submit that in
>> a different patch.
>> 
>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
>
> Gregory? Looks reasonable to me.

Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory


-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
