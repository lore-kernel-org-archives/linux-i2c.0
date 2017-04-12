From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v5 2/2] i2c: mux: ltc4306: LTC4306 and LTC4305 I2C
 multiplexer/switch
Date: Wed, 12 Apr 2017 18:53:20 +0200
Message-ID: <ef75918a-3e5d-91d2-bc05-546e1e0f0bb4@axentia.se>
References: <1491912976-8396-1-git-send-email-michael.hennerich@analog.com>
 <1491912976-8396-2-git-send-email-michael.hennerich@analog.com>
 <CACRpkdbOQtJvwtNRuPWh9VQyupH3kXK9-3Vu7qMemngg6O5j1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbOQtJvwtNRuPWh9VQyupH3kXK9-3Vu7qMemngg6O5j1w@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Michael Hennerich <michael.hennerich@analog.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 2017-04-12 10:26, Linus Walleij wrote:
> On Tue, Apr 11, 2017 at 2:16 PM,  <michael.hennerich@analog.com> wrote:
> 
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>> This patch adds support for the Analog Devices / Linear Technology
>> LTC4306 and LTC4305 4/2 Channel I2C Bus Multiplexer/Switches.
>> The LTC4306 optionally provides two general purpose input/output pins
>> (GPIOs) that can be configured as logic inputs, opendrain outputs or
>> push-pull outputs via the generic GPIOLIB framework.

Great, thanks for your contribution Michael! Both patches pushed to the
for-next branch of the i2c-mux tree.

>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> (...)
>> Changes since v4:
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Please go ahead and merge to the i2c tree if you like.

Yup, thanks for the review! (But not merged directly to the i2c tree,
although they will get there eventually...)

Cheers,
peda

