From: "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>
Subject: Re: [PATCH v7 2/5] i2c: Add STM32F4 I2C driver
Date: Mon, 2 Jan 2017 14:31:31 +0100
Message-ID: <CAOAejn3cxJdXd4i2OQk_fUiZwzUd7-U7Fi-haHUsvWg4xu_uzw@mail.gmail.com>
References: <1482413704-17531-1-git-send-email-cedric.madianga@gmail.com>
 <1482413704-17531-3-git-send-email-cedric.madianga@gmail.com>
 <20161223090019.a3jkhpb3abgjqi55@pengutronix.de> <CAOAejn3sc1F8T_rbSTr6-wBNncNwObeK+c6=_Q0BMahDdHXxQA@mail.gmail.com>
 <20161228212139.adkixdgvmtj2ukjs@pengutronix.de> <CAOAejn1ocTSvdPWnZ-+DwMfJj45cXXEDc1+=B5d3zCy2Pw+0-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34882 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755410AbdABNbd (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 2 Jan 2017 08:31:33 -0500
In-Reply-To: <CAOAejn1ocTSvdPWnZ-+DwMfJj45cXXEDc1+=B5d3zCy2Pw+0-A@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linus Walleij <linus.walleij@linaro.org>, Patrice Chotard <patrice.chotard@st.com>, Russell King <linux@armlinux.org.uk>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello Uwe,

>> Is it possible to make it more obvious by doing:
>>
>>         status = read_from_status_register() & read_from_interrupt_enable_register();
>>
>> at a single place?
Contrary to what I said previously I have to keep possible_status
variable as for one irq enabled we allow several events.
For example, ITBUFEN allows to generate an irq for RXNE and for TXE events.
So, using status = read_from_status_register() &
read_from_interrupt_enable_register(); is not possible.

Best regards,

Cedric
