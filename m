From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 00/21] eeprom: at24: driver refactoring
Date: Fri, 23 Mar 2018 17:13:33 +0100
Message-ID: <CAMRc=MfbU=GLyxx0V1yeNNiD_ZQ8Ga+oS14tYWUcV9SGTSz4KA@mail.gmail.com>
References: <20180319091721.18193-1-brgl@bgdev.pl> <CAHp75VevXq6NwpmvTU_2GzSdLjUQ47RLM__M3jNLBjZ1YoeQHw@mail.gmail.com>
 <CAMRc=MdKor4Hb-VWqczVgiatLU+HKW-u6D-1=b_xnvz_QJhO9g@mail.gmail.com>
 <CAHp75VfLzE===+4LpjyP5Zjzg7TCDiwf5udQEq-TtxjCbYXFpw@mail.gmail.com> <20180323152603.GA17081@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180323152603.GA17081@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

2018-03-23 16:26 GMT+01:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> On Wed, Mar 21, 2018 at 04:52:19PM +0200, Andy Shevchenko wrote:
>> On Mon, Mar 19, 2018 at 5:21 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> > 2018-03-19 15:43 GMT+01:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
>> >> On Mon, Mar 19, 2018 at 11:17 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> >>> This series contains what I hope to be a non-controversial refactoring
>> >>> of the at24 eeprom driver.
>> >>>
>> >>> Most changes revolve around at24_probe() which became quite complicated
>> >>> and hard to read.
>> >>>
>> >>> The only functional changes are: disabling the internal locking
>> >>> mechanisms of regmap (since we already take care of that in the driver)
>> >>> and removing an if checking if byte_len is a power of 2 (as we do
>> >>> support models for which it's not true).
>> >>>
>> >>> All other patches affect readability and code structure.
>> >>>
>> >>> Tested with a couple models and different both for device tree and
>> >>> platform data modes.
>> >>
>> >> Is there any available tree with that series applied?
>> >> I would test it on Intel Galileo Gen 2 which has ACPI enumerated AT24
>> >> EEPROM attached.
>> >>
>> >
>> > Yes, it's in my github tree:
>> >
>> >     https://github.com/brgl/linux    topic/at24/refactoring
>> >
>> > Thanks in advance for testing it!
>>
>> At least this didn't break AT24 on Intel Galileo Gen 2 board in ACPI mode.
>>
>> Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> All applied except for patch 4.
>
> thanks,
>
> greg k-h

Hi Greg,

I maintain this driver now and my pull requests usually go through
Wolfram's i2c tree (Cc'ed). I initially intended for this series to be
applied for 4.18. For 4.17 luckily the only other changes for at24 are
device tree bindings, so I guess we can keep it in misc-char, since
there are no conflicts.

Let me resend the corrected patch 4.

Best regards,
Bartosz Golaszewski
