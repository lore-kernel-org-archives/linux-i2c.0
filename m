From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Double commits in i2c/for-next branch?
Date: Mon, 2 Nov 2015 11:44:41 +0900
Message-ID: <CAK7LNATkMPJOBABg9TH69Z2gEfudvk_jQHkE-j5QZLevdzBW9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from conssluserg002.nifty.com ([202.248.44.40]:28777 "EHLO
	conssluserg002-v.nifty.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750884AbbKBCoq (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 1 Nov 2015 21:44:46 -0500
Received: from mail-yk0-f182.google.com (mail-yk0-f182.google.com [209.85.160.182]) (authenticated)
	by conssluserg002-v.nifty.com with ESMTP id tA22ifGR001910
	for <linux-i2c@vger.kernel.org>; Mon, 2 Nov 2015 11:44:42 +0900
Received: by ykft191 with SMTP id t191so126857967ykf.0
        for <linux-i2c@vger.kernel.org>; Sun, 01 Nov 2015 18:44:41 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

Hi Wolfram,

I noticed my patch was applied twice in the next branch
with different commit IDs.



[1] commit 6a62974b667f3976ec44e255bed31746cca1ff51
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri Oct 23 19:52:00 2015 +0900

    i2c: uniphier_f: add UniPhier FIFO-builtin I2C driver


[2] commit f496cf367b613c94e40893e07e1b20470deb9363
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri Oct 23 19:52:00 2015 +0900

    i2c: uniphier_f: add UniPhier FIFO-builtin I2C driver



Please let me confirm if I correctly understood
the branch strategy of this subsystem.



[1] was applied to i2c/for-4.4 and then merged
into i2c/for-next.   It is supposed to be pulled
into the mainline in this merge window.


[2] was directly applied to i2c/for-next and
won't be pulled into the mainline.  It will only
remain in linux-next.



Is this correct?





-- 
Best Regards
Masahiro Yamada
