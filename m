From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ARM: sa1100: simpad: Correct I2C GPIO offsets
Date: Wed, 8 Nov 2017 13:48:39 +0100
Message-ID: <CACRpkdY4ei8_BQG7yVKCH3ZsQisSJxdMMi=VJ9kdKULuAwEsJg@mail.gmail.com>
References: <20171107151703.3847-1-linus.walleij@linaro.org> <24888cd2-e3ef-2f34-4c0c-c7e620f5e3e0@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:56034 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752355AbdKHMsl (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 8 Nov 2017 07:48:41 -0500
Received: by mail-it0-f66.google.com with SMTP id l196so6308456itl.4
        for <linux-i2c@vger.kernel.org>; Wed, 08 Nov 2017 04:48:41 -0800 (PST)
In-Reply-To: <24888cd2-e3ef-2f34-4c0c-c7e620f5e3e0@scram.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jochen Friedrich <jochen@scram.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Wolfram Sang <w.sang@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>

On Wed, Nov 8, 2017 at 9:40 AM, Jochen Friedrich <jochen@scram.de> wrote:

>> Jochen: did this ever work? I suspect the patch was simply developed on
>> top of a different kernel.
>
> This really was developed on top of a much older kernel. I didn't test this
> for a while now as on my Simpad, the touch screen died a while ago (mainly
> returning random position data), so the device is useless...

I wonder if anyone is booting simpad on the recent kernels. Maybe it
should simply be decomissioned if there are no users.

Oh well, that is for later.

Yours,
Linus Walleij
