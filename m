From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] eeprom: at24: Add support for large EEPROMs connected
 to SMBus adapters
Date: Fri, 27 Mar 2015 08:42:02 -0700
Message-ID: <55157A4A.1090305@roeck-us.net>
References: <20150318132707.GD3580@katana> <550A4162.8000009@roeck-us.net> <20150319081612.GA900@katana> <20150319174314.GA17329@roeck-us.net> <20150319213937.GA899@katana> <5512C213.7030705@roeck-us.net> <20150327080947.GA900@katana> <5515523F.9010609@roeck-us.net> <20150327130108.GA19151@katana> <551557B4.5000504@roeck-us.net> <20150327152727.GA27238@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150327152727.GA27238@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 03/27/2015 08:27 AM, Wolfram Sang wrote:
> On Fri, Mar 27, 2015 at 06:14:28AM -0700, Guenter Roeck wrote:
>> On 03/27/2015 06:01 AM, Wolfram Sang wrote:
>>> On Fri, Mar 27, 2015 at 05:51:11AM -0700, Guenter Roeck wrote:
>>>> On 03/27/2015 01:09 AM, Wolfram Sang wrote:
>>>>>
>>>>>> just to give you an update: I do have some code, but it is a bit messy,
>>>>>> and it doesn't work well for ds2482 (the chip behind it still hangs up
>>>>>> if I access it in parallel through i2c-dev). On top of that, it causes
>>>>>> pretty significant slow-downs when accessing other devices on the same
>>>>>> bus at the same time. Not surprising, I guess, since it expands the scope
>>>>>> of the bus lock significantly.
>>>>>
>>>>> Just to get a better idea: Did you try taking the adapter_lock before
>>>>> the two SMBus command which needed to be concatenated (and use
>>>>> smbus_xfer directly)?
>>>>>
>>>> I did. I didn't use smbus_xfer directly, though, but introduced lockless
>>>> versions of the various smbus commands, and kept using those.
>>>
>>> And then the chip still hangs? Or was that the performance penalty here?
>>>
>> Parallel access to a second eeprom chip on the same bus was much slower
>> than before.
>
> Interesting. I wonder what is the reason, I would have expected just a
> small delay. Would you mind sending the patches for the non-locked smbus
> routines? Would be nice to have that around in case I or someone else
> find some time to try as well.
>
I pushed it into my linux repository at github (https://github.com/groeck/linux,
branch at24).

>> Also, the new code did not solve the problem for ds2482 (completely unrelated
>> to the at24 driver of course). Even with proper locking, the chip ended up
>> hanging after some parallel accesses through i2c-dev. Granted, ds2482 is
>> a difficult beast, but it is still annoying how access through i2c-dev
>> can mess it up.
>
> I assume you basically replaced the access_lock with the adapter_lock
> with this one?
>
yes.

>>
>> The latter is what bothered me more: What is the point of all this if we
>> still can not ensure correct operation ?
>
> Yeah, this is not good at all.
>
> How do you use i2c-dev BTW? i2c_rdwr_msgs? What about iterating over all
> msgs in that and check for busy addresses?
>
In this case, I just used i2cdump from one session while accessing
the chip from another session using the driver.

Guenter
