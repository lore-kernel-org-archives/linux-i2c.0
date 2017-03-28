From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v5 1/2] i2c: aspeed: added driver for Aspeed I2C
Date: Mon, 27 Mar 2017 22:23:29 -0700
Message-ID: <CAFd5g47aOuss=Mg6rvDqYBYHkQw_Bez8F0yNFhD6=e8q6gFoEA@mail.gmail.com>
References: <1480467618-7497-1-git-send-email-brendanhiggins@google.com>
 <1480467618-7497-2-git-send-email-brendanhiggins@google.com>
 <20161211222622.GK2552@katana> <825541481540788@web11j.yandex.ru> <20161212111005.GA1450@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33164 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbdC1FXx (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 28 Mar 2017 01:23:53 -0400
Received: by mail-qk0-f172.google.com with SMTP id f11so56720908qkb.0
        for <linux-i2c@vger.kernel.org>; Mon, 27 Mar 2017 22:23:30 -0700 (PDT)
In-Reply-To: <20161212111005.GA1450@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Kachalov Anton <mouse@mayc.ru>, "vz@mleia.com" <vz@mleia.com>, "clg@kaod.org" <clg@kaod.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "joel@jms.id.au" <joel@jms.id.au>, "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>

>> >>  + /* Switch from master mode to slave mode. */
>> >>  + func_ctrl_reg_val = aspeed_i2c_read(bus, ASPEED_I2C_FUN_CTRL_REG);
>> >>  + func_ctrl_reg_val &= ~ASPEED_I2CD_MASTER_EN;
>> >>  + func_ctrl_reg_val |= ASPEED_I2CD_SLAVE_EN;
>> >>  + aspeed_i2c_write(bus, func_ctrl_reg_val, ASPEED_I2C_FUN_CTRL_REG);
>> >
>> > Can't the hardware work both as master and slave on the same bus?
>>
>> The hardware can work as master and slave on the same bus. This is how IPMB over i2c works on Aspeed.

I no longer disable master when a slave is registered. I was concerned
about adding multimaster support because I don't think it will play
nicely with bus recovery; should we maybe provide a device tree option
to turn multimaster support on which will disable bus recovery, since
someone else might be using it?

>
> Thanks! Then the driver should support this. Maybe it is an idea to
> first upstream the master support and add the slave support
> incrementally?

Yeah, probably a good idea. Slave support is now added in
https://lkml.org/lkml/2017/3/28/22.

>
> Regards,
>
>    Wolfram
>
