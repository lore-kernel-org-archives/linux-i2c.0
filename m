From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 4/4] eeprom: at24: Add OF device ID table
Date: Wed, 15 Mar 2017 00:59:58 +0200
Message-ID: <CAHp75Vf5=E37Ccrc2zMo8xOWmA-A_FZL7d57q7Rxk07M-V5mhg@mail.gmail.com>
References: <20170314151638.23132-1-javier@osg.samsung.com> <20170314151638.23132-5-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33964 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752450AbdCNXAA (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 14 Mar 2017 19:00:00 -0400
In-Reply-To: <20170314151638.23132-5-javier@osg.samsung.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On Tue, Mar 14, 2017 at 5:16 PM, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> The driver doesn't have a struct of_device_id table but supported devices
> are registered via Device Trees. This is working on the assumption that a
> I2C device registered via OF will always match a legacy I2C device ID and
> that the MODALIAS reported will always be of the form i2c:<device>.
>
> But this could change in the future so the correct approach is to have an
> OF device ID table if the devices are registered via OF.

I'm bot sure this patch does something useful right now. Can we
survive without it? I think we may.

>  drivers/misc/eeprom/at24.c | 189 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 188 insertions(+), 1 deletion(-)

It's a huge! It will increase not only driver code base but memory
footprint for almost no benefit.

-- 
With Best Regards,
Andy Shevchenko
