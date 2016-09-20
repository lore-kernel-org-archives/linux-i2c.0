From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v2 2/2] i2c: aspeed: added documentation for Aspeed I2C driver
Date: Tue, 20 Sep 2016 11:08:29 -0700
Message-ID: <CAFd5g46F1reb-d47YBtxOywPObsLWy+L4KEGuXVJPGvL29O+ng@mail.gmail.com>
References: <201609100847.j1qUadzy%fengguang.wu@intel.com> <1473472551-11149-1-git-send-email-brendanhiggins@google.com>
 <1473472551-11149-2-git-send-email-brendanhiggins@google.com>
 <20160919213536.GA19274@rob-hp-laptop> <CAFd5g46WR34A1FLNvuRck84EX1F3gbPDnDuBo2j-SVUEJPvXfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:36404 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755089AbcITSIo (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 20 Sep 2016 14:08:44 -0400
Received: by mail-vk0-f48.google.com with SMTP id b133so35464661vka.3
        for <linux-i2c@vger.kernel.org>; Tue, 20 Sep 2016 11:08:43 -0700 (PDT)
In-Reply-To: <CAFd5g46WR34A1FLNvuRck84EX1F3gbPDnDuBo2j-SVUEJPvXfg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, mark.rutland@arm.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>, Joel Stanley <joel@jms.id.au>, Jeremy Kerr <jk@ozlabs.org>

(sorry if you get a duplicate, I forgot to send plain text)

First off, someone pointed out to me that the mapping that I used
between addresses and bus numbers is not actually valid for busses
8-14.

This could be fixed by checking the offset, but I am wondering if that
is the right way to do it. It seems like this is not completely
trivial so maybe this should be specified in the device tree? If that
is the case, should I do this as another reg entry or go back to the
way I was doing it before?

On Mon, Sep 19, 2016 at 4:26 PM, Brendan Higgins
<brendanhiggins@google.com> wrote:
> Addressed in v3.
>
> Thanks!
>
> On Mon, Sep 19, 2016 at 2:35 PM, Rob Herring <robh@kernel.org> wrote:
>> On Fri, Sep 09, 2016 at 06:55:51PM -0700, Brendan Higgins wrote:
>>> Added device tree binding documentation for Aspeed I2C controller and
>>> busses.
>>>
>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>>> ---
>>> Changes for v2:
>>>   - None
>>> ---
>>>  .../devicetree/bindings/i2c/i2c-aspeed.txt         | 63 ++++++++++++++++++++++
>>>  1 file changed, 63 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
>>> new file mode 100644
>>> index 0000000..df68f2a
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
>>> @@ -0,0 +1,63 @@
>>> +Device tree configuration for the I2C controller and busses on the AST24XX
>>> +and AST25XX SoCs.
>>> +
>>> +Controller:
>>> +
>>> +     Required Properties:
>>> +     - #address-cells        : should be 1
>>> +     - #size-cells           : should be 1
>>> +     - #interrupt-cells      : should be 1
>>> +     - compatible            : should be "aspeed,ast2400-i2c-controller"
>>> +                               or "aspeed,ast2500-i2c-controller"
>>> +     - reg                   : address start and range of controller
>>> +     - ranges                : defines address offset and range for busses
>>> +     - interrupts            : interrupt number
>>> +     - clocks                : root clock of bus, should reference the APB
>>> +                               clock
>>> +     - clock-ranges          : specifies that child busses can inherit clocks
>>> +     - interrupt-controller  : denotes that the controller receives and fires
>>> +                               new interrupts for child busses
>>> +
>>> +Bus:
>>> +
>>> +     Required Properties:
>>> +     - #address-cells        : should be 1
>>> +     - #size-cells           : should be 0
>>> +     - reg                   : address offset and range of bus
>>> +     - compatible            : should be "aspeed,ast2400-i2c-bus"
>>> +                               or "aspeed,ast2500-i2c-bus"
>>> +     - bus                   : the bus's number
>>
>> Don't use indexes. The reg property is enough to id which bus is which.
