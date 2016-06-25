From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH 2/2] i2c: versatile: Convert to use resource managed
 devm_* APIs
Date: Sat, 25 Jun 2016 09:41:12 +0800
Message-ID: <CAFRkauAarcYw6tCvM0_1VL-Wpf_OeLY=LEiR33DnQ1Q+2_C_KQ@mail.gmail.com>
References: <1460644236.6039.2.camel@ingics.com> <1460644306.6039.3.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33490 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbcFYBlP (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 24 Jun 2016 21:41:15 -0400
Received: by mail-lf0-f67.google.com with SMTP id l188so23467065lfe.0
        for <linux-i2c@vger.kernel.org>; Fri, 24 Jun 2016 18:41:14 -0700 (PDT)
In-Reply-To: <1460644306.6039.3.camel@ingics.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Pawel Moll <pawel.moll@arm.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-i2c@vger.kernel.org

2016-04-14 22:31 GMT+08:00 Axel Lin <axel.lin@ingics.com>:
> Use devm_* APIs to simplify the code a bit.
> This patch also fixes the memory leak when unload the module.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> Hi,
> I don't have this h/w, I'd appreciate if someone can test this patch.

Obviously the module unload path has memory leak.
Just wondering if anyone can review/test this patch.
