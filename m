From: "Adamski, Krzysztof (Nokia - PL/Wroclaw)"
        <krzysztof.adamski@nokia.com>
Subject: Re: [PATCH] i2c-axxia: properly handle master timeout
Date: Mon, 3 Dec 2018 10:20:51 +0000
Message-ID: <d80cca69-26e7-8af7-bf42-8ccb0d44a374@nokia.com>
References: <20181116132334.GA3951@localhost.localdomain>
 <20181127122649.GL1107@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181127122649.GL1107@kunai>
Content-Language: en-US
Content-ID: <CB29AFA95D10254F87D8B785D9540C11@eurprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Guenter Roeck <linux@roeck-us.net>, "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>, Tobias Jordan <Tobias.Jordan@elektrobit.com>, Peter Rosin <peda@axentia.se>, Anders Berg <anders.berg@lsi.com>
List-Id: linux-i2c@vger.kernel.org

Hi

W dniu 27.11.2018 o=A013:26, Wolfram Sang pisze:
> On Fri, Nov 16, 2018 at 01:24:41PM +0000, Adamski, Krzysztof (Nokia - PL/=
Wroclaw) wrote:
>> According to Intel (R) Axxia TM Lionfish Communication Processor
>> Peripheral Subsystem Hardware Reference Manual, the AXXIA I2C module
>> have a programmable Master Wait Timer, which among others, checks the
>> time between commands send in manual mode. When a timeout (25ms) passes,
>> TSS bit is set in Master Interrupt Status register and a Stop command is
>> issued by the hardware.
>>
>> The axxia_i2c_xfer(), does not properly handle this situation, however.
>> For each message a separate axxia_i2c_xfer_msg() is called and this
>> function incorrectly assumes that any interrupt might happen only when
>> waiting for completion. This is mostly correct but there is one
>> exception - a master timeout can trigger if enough time has passed
>> between individual transfers. It will, by definition, happen between
>> transfers when the interrupts are disabled by the code. If that happens,
>> the hardware issues Stop command.
>>
>> The interrupt indicating timeout will not be triggered as soon as we
>> enable them since the Master Interrupt Status is cleared when master
>> mode is entered again (which happens before enabling irqs) meaning this
>> error is lost and the transfer is continued even though the Stop was
>> issued on the bus. The subsequent operations completes without error but
>> a bogus value (0xFF in case of read) is read as the client device is
>> confused because aborted transfer. No error is returned from
>> master_xfer() making caller believe that a valid value was read.
>>
>> To fix the problem, the TSS bit (indicating timeout) in Master Interrupt
>> Status register is checked before each transfer. If it is set, there was
>> a timeout before this transfer and (as described above) the hardware
>> already issued Stop command so the transaction should be aborted thus
>> -ETIMEOUT is returned from the master_xfer() callback. In order to be
>> sure no timeout was issued we can't just read the status just before
>> starting new transaction as there will always be a small window of time
>> (few CPU cycles at best) where this might still happen. For this reason
>> we have to temporally disable the timer before checking for TSS bit.
>> Disabling it will, however, clear the TSS bit so in order to preserve
>> that information, we have to read it in ISR so we have to ensure that
>> the TSS interrupt is not masked between transfers of one transaction.
>> There is no need to call bus recovery or controller reinitialization if
>> that happens so it's skipped.
>>
>> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
>> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> Applied to for-current, thanks!
>
> Since you and/or Alexander are the ones doing functional changes to this
> driver, would you be interested in maintaining it? This would ensure you
> get notified when someone else has patches for it.

Thanks for the offer. Since I think I became quite familiar with
his code and the hardware itself and we do have an interest real
interest in this driver, I think it is a good idea. I will send
a patch to MAINTAINERS soon.

Krzysztof
