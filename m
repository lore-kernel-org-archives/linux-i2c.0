From: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v2] i2c: aspeed: Deassert reset in probe
Date: Mon, 30 Oct 2017 13:48:01 +1030
Message-ID: <CACPK8XfYeviC5hrqM2Q33sExduBkKQiK_LVg=pg1q2Nbh_fecw@mail.gmail.com>
References: <20171018142930.13052-1-joel@jms.id.au> <CA+gwMccb45zXESWJBa528jUa2n_LQdqJD8UFBnfZBkA+q5+mQg@mail.gmail.com>
 <20171026205348.zh2gicql4pyyeoaa@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171026205348.zh2gicql4pyyeoaa@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Philipp Zabel <philipp.zabel@gmail.com>, Brendan Higgins <brendanhiggins@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 27, 2017 at 7:23 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> > +       bus->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
>>
>> This could return error values in case of broken device trees, so you
>> may want to check IS_ERR(bus->rst) and handle the error here.

>From my understanding the optional variant of the API will set
silently fail. That was my intention - an outdated device tree would
result in the same behaviour as the old driver.

>>
>> > +       reset_control_deassert(bus->rst);
>>
>> Otherwise this will dump a warning.
>>
>> > +
>> >         ret = of_property_read_u32(pdev->dev.of_node,
>> >                                    "bus-frequency", &bus->bus_frequency);
>> >         if (ret < 0) {
>> > @@ -919,6 +925,8 @@ static int aspeed_i2c_remove_bus(struct platform_device *pdev)
>> >
>> >         i2c_del_adapter(&bus->adap);
>> >
>> > +       reset_control_assert(bus->rst);
>>
>> As will this.
>>
>> Reviewed-by: Philipp Zabel <philipp.zabel@gmail.com>
>
> Joel, do you want to fix it? I'd think it makes sense...

Sorry, I've been on vacation. I thought the _optional variant of the
API would do the right thing for my use case (silently fail on old
device trees), but I'll add a check.

v3 incoming.

Cheers,

Joel
