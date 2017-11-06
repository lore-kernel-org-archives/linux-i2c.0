From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4] i2c: aspeed: Deassert reset in probe
Date: Mon, 6 Nov 2017 08:19:58 -0600
Message-ID: <CAL_Jsq++8gpeJch-tTTvfKu9sFbNi1fjG5+Uxg27TPcb0Zd2Kw@mail.gmail.com>
References: <20171101002330.24981-1-joel@jms.id.au> <20171105124949.ct4ity6htxqgvvfp@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171105124949.ct4ity6htxqgvvfp@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Joel Stanley <joel@jms.id.au>, Brendan Higgins <brendanhiggins@google.com>, Philipp Zabel <philipp.zabel@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Jeffery <andrew@aj.id.au>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Nov 5, 2017 at 6:49 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Wed, Nov 01, 2017 at 10:53:30AM +1030, Joel Stanley wrote:
>> In order to use i2c from a cold boot, the i2c peripheral must be taken
>> out of reset. We request a shared reset controller each time a bus
>> driver is loaded, as the reset is shared between the 14 i2c buses.
>>
>> On remove the reset is asserted, which only touches the hardware once
>> the last i2c bus is removed.
>>
>> The reset is required as the I2C buses will not work without releasing
>> the reset. Previously the driver only worked with out of tree hacks
>> that released this reset before the driver was loaded. Update the
>> device tree bindings to reflect this.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>> v4:
>>   - Make reset required and update device tree bindings
>
> For that change, I'd like to have an ack from Rob first. Won't that
> cause problems when you update only the kernel and keep the "old"
> devicetree?

Given it didn't really work as explained above, I'm okay with the change.

Acked-by: Rob Herring <robh@kernel.org>
