From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v8 1/5] irqchip/aspeed-i2c-ic: binding docs for Aspeed I2C
 Interrupt Controller
Date: Tue, 30 May 2017 14:46:35 -0700
Message-ID: <CAFd5g45AXT0rJydYykh011JRm6cw=Tnz5EGfkQX1bddWW+SdNA@mail.gmail.com>
References: <20170525064925.16867-1-brendanhiggins@google.com>
 <20170525064925.16867-2-brendanhiggins@google.com> <20170530213430.vlxioxzzuzbjojhj@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:33331 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751188AbdE3Vqh (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 30 May 2017 17:46:37 -0400
Received: by mail-qt0-f180.google.com with SMTP id t26so81167620qtg.0
        for <linux-i2c@vger.kernel.org>; Tue, 30 May 2017 14:46:37 -0700 (PDT)
In-Reply-To: <20170530213430.vlxioxzzuzbjojhj@rob-hp-laptop>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Joel Stanley <joel@jms.id.au>, Vladimir Zapolskiy <vz@mleia.com>, Kachalov Anton <mouse@mayc.ru>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, OpenBMC Maillist <openbmc@lists.ozlabs.org>

Sorry, I wasn't sure. Will do in the future.

On Tue, May 30, 2017 at 2:34 PM, Rob Herring <robh@kernel.org> wrote:
> On Wed, May 24, 2017 at 11:49:21PM -0700, Brendan Higgins wrote:
>> Added device tree binding documentation for Aspeed I2C Interrupt
>> Controller.
>>
>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>> ---
>> Added in v6:
>>   - Pulled "aspeed_i2c_controller" out into a interrupt controller since that is
>>     what it actually does.
>> Changes for v7:
>>   - None
>> Changes for v8:
>>   - None
>
> I already acked this. Please add acks when posting new versions.
>
> Rob
