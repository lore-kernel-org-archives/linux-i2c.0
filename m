From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v9 5/5] i2c: aspeed: added slave support for Aspeed I2C driver
Date: Fri, 2 Jun 2017 11:37:23 -0700
Message-ID: <CAFd5g448cSQnGnhNegQ4+u5tZ_n1ndZQVpZexMYS1RBO2bzyZw@mail.gmail.com>
References: <20170602084603.30811-1-brendanhiggins@google.com>
 <20170602084603.30811-6-brendanhiggins@google.com> <1496405090.2842.5.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:33212 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbdFBShY (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 2 Jun 2017 14:37:24 -0400
Received: by mail-qt0-f170.google.com with SMTP id u12so14622110qth.0
        for <linux-i2c@vger.kernel.org>; Fri, 02 Jun 2017 11:37:24 -0700 (PDT)
In-Reply-To: <1496405090.2842.5.camel@kernel.crashing.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Joel Stanley <joel@jms.id.au>, Vladimir Zapolskiy <vz@mleia.com>, Kachalov Anton <mouse@mayc.ru>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Ryan Chen <ryan_chen@aspeedtech.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, OpenBMC Maillist <openbmc@lists.ozlabs.org>

On Fri, Jun 2, 2017 at 5:04 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2017-06-02 at 01:46 -0700, Brendan Higgins wrote:
>> Added slave support for Aspeed I2C controller. Supports fourteen busses
>> present in AST24XX and AST25XX BMC SoCs by Aspeed.
>
> (Not an issue for merging)
>
> Have you looked at a "mode" by which you implement just enough of the
> slave support to decode smbus notifications ?
>
> This looks like it could be useful when using pmbus devices, as some of
> them use smbus notifications fairly often.
>
> Today only one driver calls i2c_handle_smbus_host_notify() (the Intel
> one of course).
>

Although I have not thought about the exact thing you are mentioning, I
want to implement a number of other features for the slave. The thing I am
most interested in is adding support for smbus alert from the slave side.
Nevertheless, I wanted to actually get the driver in before I start trying to do
interesting things. As it is, the slave code satisfies our current purposes and
I do not know of anyone else who wants this feature at this time.

Cheers
