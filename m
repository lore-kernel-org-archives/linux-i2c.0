From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] eeprom: at24: Add support for large EEPROMs connected
 to SMBus adapters
Date: Wed, 18 Mar 2015 20:24:18 -0700
Message-ID: <550A4162.8000009@roeck-us.net>
References: <1423067017-27607-1-git-send-email-linux@roeck-us.net> <20150204174723.GB30930@katana> <20150204190819.GA15467@roeck-us.net> <20150204233516.GA1677@katana> <20150205002630.GA396@roeck-us.net> <20150205144028.GA4865@katana> <20150205175326.GA26691@roeck-us.net> <20150212040126.GA1691@roeck-us.net> <20150216120951.GA2840@katana> <20150317042049.GA6765@roeck-us.net> <20150318132707.GD3580@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150318132707.GD3580@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 03/18/2015 06:27 AM, Wolfram Sang wrote:
> On Mon, Mar 16, 2015 at 09:20:49PM -0700, Guenter Roeck wrote:
>> On Mon, Feb 16, 2015 at 01:09:51PM +0100, Wolfram Sang wrote:
>>> Hi Guenter,
>>>
>>>> I wonder where we are with thisp patch; I don't recall a reply to my previous
>>>> e-mail.
>>>
>>> Sorry for the late reply. I needed to recover from a HDD headcrash :(
>>>
>>>> Do you need some more time to think about it ? Otherwise I'll publish an
>>>> out-of-tree version of the at24 driver with the patch applied on github,
>>>> for those who might need the functionality provided by this patch.
>>>
>>> Your last mail made me aware of why we were missing each other before. I
>>> see your point now, but yes, still need to think about it. My plan is to
>>> have a decision until the 3.21 merge window.
>>>
>> Hi Wolfram,
>>
>> any news ?
>
> Yes :)
>
> The main misunderstanding we had before was: You were talking about
> multi-master safety between transfers, while I was thinking about
> multi-master safety between messages. While we need to guarantee this
> for the latter, you are right about the former, sadly. True multi-master
> safety between transfers is probably like a can of worms currently.
>
> Still, I think we have a race with your patch when having two read
> processes. If b) kicks in after a) has just set the eeprom pointer, a)
> will not read the data it wants. For that to prevent, we should take the
> adapter_lock during those two transfers needed for the read you
> implemented. My preferred solution would be to have __smbus_transfer
> like we have __i2c_transfer and then using that. Some mux code could
> also make use out of that. But if you are going to use
> adapter->algo->smbus_xfer() directly, well, then be it.
>

You are right, that is a problem. Not for eeprom access itself - that already
has a mutex - but for parallel access to the chip through the eeprom file
and, say, by i2cdump.

I don't call that multi-master, though, so I guess we may have a bit of a
terminology problem.

I'll see what I can come up with, but I am not sure if I'll find the time
before the 4.1 commit window opens. Company has a working solution (kind of),
so now I'll have to do this on my own time ;-).

Thanks,
Guenter
