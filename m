From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH] i2c: jz4780: really prevent potential division by zero
Date: Sat, 9 Apr 2016 07:42:07 +0800
Message-ID: <CAFRkauABTjkaYd0N7_P6ZdL6vhhvXh7E=se00h7e3uV1G7cm9w@mail.gmail.com>
References: <1460109827-3608-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:33113 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933034AbcDHXmO (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 8 Apr 2016 19:42:14 -0400
Received: by mail-lf0-f51.google.com with SMTP id e190so92964786lfe.0
        for <linux-i2c@vger.kernel.org>; Fri, 08 Apr 2016 16:42:08 -0700 (PDT)
In-Reply-To: <1460109827-3608-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

2016-04-08 18:03 GMT+08:00 Wolfram Sang <wsa@the-dreams.de>:
> Make sure that 'ret' is populated before we leave and check the variable
> which is actually used as a divisor. Add missing '\n' while we are here.
>
> Reported-by: Axel Lin <axel.lin@ingics.com>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Fixes: 34cf2acdafaa ("i2c: jz4780: prevent potential division by zero")

Looks good to me.
Thanks
