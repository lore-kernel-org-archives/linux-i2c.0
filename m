From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v3 0/2] add support for Socionext SynQuacer I2C controller
Date: Tue, 27 Feb 2018 17:01:53 +0000
Message-ID: <CAKv+Gu_YJSnk0=5-yS03KSunCr-EusfMs2PNFNB0chqpL9sQQg@mail.gmail.com>
References: <20180227110107.30259-1-ard.biesheuvel@linaro.org> <CAHp75Vc_AUD2b5m-6CzKhAWJDudyObGs_oUUiFRk_BQv2QT7Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vc_AUD2b5m-6CzKhAWJDudyObGs_oUUiFRk_BQv2QT7Xg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c <linux-i2c@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Jassi Brar <jassisinghbrar@gmail.com>
List-Id: linux-i2c@vger.kernel.org

On 27 February 2018 at 15:59, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Tue, Feb 27, 2018 at 1:01 PM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> Add a binding and a driver for the I2C IP found in the Socionext SynQuacer
>> SoC, which is essentially a rebranded version of the Fujitsu F_I2C controller.
>>
>
> Thanks for an update!
> FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>

Thanks Andy


>> v3:
>> - incorporate more of Andy's review comments (#2), especially regarding the
>>   bus speed and clock source handling for ACPI
>> - patch #1 unchanged.
>>
>> v2:
>> - incorporate Andy's review comments (#2)
>> - patch #1 unchanged.
>>
>> Ard Biesheuvel (2):
>>   dt-bindings: i2c: add binding for Socionext SynQuacer I2C
>>   i2c: add support for Socionext SynQuacer I2C controller
>>
>>  Documentation/devicetree/bindings/i2c/i2c-synquacer.txt |  29 +
>>  drivers/i2c/busses/Kconfig                              |  10 +
>>  drivers/i2c/busses/Makefile                             |   1 +
>>  drivers/i2c/busses/i2c-synquacer.c                      | 787 ++++++++++++++++++++
>>  4 files changed, 827 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-synquacer.txt
>>  create mode 100644 drivers/i2c/busses/i2c-synquacer.c
>>
>> --
>> 2.11.0
>>
>
>
>
> --
> With Best Regards,
> Andy Shevchenko
