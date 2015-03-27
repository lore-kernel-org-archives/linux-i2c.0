From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] eeprom: at24: Add support for large EEPROMs connected
 to SMBus adapters
Date: Fri, 27 Mar 2015 06:14:28 -0700
Message-ID: <551557B4.5000504@roeck-us.net>
References: <20150216120951.GA2840@katana> <20150317042049.GA6765@roeck-us.net> <20150318132707.GD3580@katana> <550A4162.8000009@roeck-us.net> <20150319081612.GA900@katana> <20150319174314.GA17329@roeck-us.net> <20150319213937.GA899@katana> <5512C213.7030705@roeck-us.net> <20150327080947.GA900@katana> <5515523F.9010609@roeck-us.net> <20150327130108.GA19151@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150327130108.GA19151@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 03/27/2015 06:01 AM, Wolfram Sang wrote:
> On Fri, Mar 27, 2015 at 05:51:11AM -0700, Guenter Roeck wrote:
>> On 03/27/2015 01:09 AM, Wolfram Sang wrote:
>>>
>>>> just to give you an update: I do have some code, but it is a bit messy,
>>>> and it doesn't work well for ds2482 (the chip behind it still hangs up
>>>> if I access it in parallel through i2c-dev). On top of that, it causes
>>>> pretty significant slow-downs when accessing other devices on the same
>>>> bus at the same time. Not surprising, I guess, since it expands the scope
>>>> of the bus lock significantly.
>>>
>>> Just to get a better idea: Did you try taking the adapter_lock before
>>> the two SMBus command which needed to be concatenated (and use
>>> smbus_xfer directly)?
>>>
>> I did. I didn't use smbus_xfer directly, though, but introduced lockless
>> versions of the various smbus commands, and kept using those.
>
> And then the chip still hangs? Or was that the performance penalty here?
>
Parallel access to a second eeprom chip on the same bus was much slower
than before.

Also, the new code did not solve the problem for ds2482 (completely unrelated
to the at24 driver of course). Even with proper locking, the chip ended up
hanging after some parallel accesses through i2c-dev. Granted, ds2482 is
a difficult beast, but it is still annoying how access through i2c-dev
can mess it up.

The latter is what bothered me more: What is the point of all this if we
still can not ensure correct operation ?

Guenter
