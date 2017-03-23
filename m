From: "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>
Subject: Re: [PATCH 3/5] i2c: i2c-stm32f7: add driver
Date: Thu, 23 Mar 2017 21:40:50 +0100
Message-ID: <CAOAejn383=Zk42nnJoG=qP=uEHpzEwf=5dePx_atyzWGDGBiyA@mail.gmail.com>
References: <1489744738-21632-1-git-send-email-cedric.madianga@gmail.com>
 <1489744738-21632-4-git-send-email-cedric.madianga@gmail.com> <20170323201719.i5bqrbxr2bejopky@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33208 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbdCWUkw (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 23 Mar 2017 16:40:52 -0400
In-Reply-To: <20170323201719.i5bqrbxr2bejopky@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linus Walleij <linus.walleij@linaro.org>, Pierre-Yves MORDRET <pierre-yves.mordret@st.com>, Russell King <linux@armlinux.org.uk>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hi Wolfram,

Yes the STM32F7 has a new I2C IP core compared to STM32F4.
The engine, the machine state are very different.
I tried few months ago to write a common driver but it was very very
difficilcut as the 2 IP are not so much things in common.

BR,
Cedric

2017-03-23 21:17 GMT+01:00 Wolfram Sang <wsa@the-dreams.de>:
> On Fri, Mar 17, 2017 at 10:58:56AM +0100, M'boumba Cedric Madianga wrote:
>> This patch adds initial support for the STM32F7 I2C controller.
>>
>> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
>
> So, the STM32F7 has a new I2C IP core compared to STM32F4?
>
