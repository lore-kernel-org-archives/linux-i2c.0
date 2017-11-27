From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v4 5/7] eeprom: at24: add regmap-based read function
Date: Mon, 27 Nov 2017 10:09:10 +0100
Message-ID: <CAMRc=Me4n3PDG4jQa1Jfr=skdMJ=BmqKF6irqFEbDXFCMBS6rA@mail.gmail.com>
References: <0448eec2-7dfb-ca79-d03a-d5b7fcb5d76c@gmail.com>
 <011081f7-f2af-0e78-f21b-c40493d63a70@gmail.com> <CAMRc=McNp=NWeGxZZfz1Xq+sxx+-X1OAFsyoEPrFTn3vaH77mQ@mail.gmail.com>
 <245157a7-bd46-9788-86e9-7058cc4c667b@gmail.com> <CAMRc=MetCoJBUnbTxnjjrxewoDZuKuLzosq5EVnjys2S=0J5Wg@mail.gmail.com>
 <3b01676a-bc35-28ee-b406-bea45e606fa5@microchip.com> <d3bba0a5-966d-b567-a233-3aec51a97ac3@gmail.com>
 <7d882bf9-8132-beb4-7a07-7544b421af02@gmail.com> <CAMRc=McqRg9e9WySKBfBu9DR4Bif9vkOByhHVwj8yrPt0vJKtQ@mail.gmail.com>
 <f9bb6ddd-0fa4-7051-898f-921ee9f34bc7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f180.google.com ([74.125.82.180]:35895 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbdK0JJL (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 27 Nov 2017 04:09:11 -0500
Received: by mail-ot0-f180.google.com with SMTP id t79so23572436ota.3
        for <linux-i2c@vger.kernel.org>; Mon, 27 Nov 2017 01:09:11 -0800 (PST)
In-Reply-To: <f9bb6ddd-0fa4-7051-898f-921ee9f34bc7@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Claudiu Beznea <Claudiu.Beznea@microchip.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

2017-11-27 7:24 GMT+01:00 Heiner Kallweit <hkallweit1@gmail.com>:
> Am 26.11.2017 um 21:27 schrieb Bartosz Golaszewski:
>> 2017-11-24 23:13 GMT+01:00 Heiner Kallweit <hkallweit1@gmail.com>:
>>> Am 24.11.2017 um 22:17 schrieb Heiner Kallweit:
>>>> Am 24.11.2017 um 18:35 schrieb Claudiu Beznea:
>>>>>
>>>>>
>>>>> On 24.11.2017 13:00, Bartosz Golaszewski wrote:
>>>>>> 2017-11-23 22:31 GMT+01:00 Heiner Kallweit <hkallweit1@gmail.com>:
>>>>>>> Am 23.11.2017 um 17:40 schrieb Bartosz Golaszewski:
>>>>>>>> Let's use '|=' here as it's safer (doesn't shift the bit if it's set
>>>>>>>> in both sides).
>>>>>>>>
>>>>>>> To build an opinion on |= vs. += I checked the code in more detail plus
>>>>>>> some datasheets, what lead to quite some question marks ..
>>>>>>>
>>>>>>> Major issue is that offset and size in at24_read/write are not checked
>>>>>>> currently. So we completely rely on the calling subsystem (nvmem).
>>>>>>> The nvmem sysfs interface does such checking. However nvmem_device_read
>>>>>>> does not. So maybe the nvmem core should be changed to do checking in
>>>>>>> all cases. I add Srinivas as nvmem maintainer to the conversation
>>>>>>> to hear his opinion.
>>>>>>>
>>>>>>> If we have such checks then in general |= and += deliver the same result,
>>>>>>> it's just a question of taste.
>>>>>>>
>>>>>>> According to the at24mac602/at24mac402 datasheet the MAC is provided at:
>>>>>>> 24mac402 / EUI-48 -> position 0x9a - 0x9f
>>>>>>> 24mac602 / EUI-64 -> position 0x98 - 0x9f
>>>>>>>
>>>>>>> Size of the 24mac402 is defined as 48 bit = 6 byte and the effective
>>>>>>> offset in at24_eeprom_read_mac is 0x90 + offset provided by caller.
>>>>> Moreover, if I remember good, in the initialization of the 24mac402 the
>>>>> size is truncated at something which is power of 2. I don't if this is
>>>>> for some historical reasons or not so that you can only read 4 bytes
>>>>> instead of 6 for the EUI-48.
>>>>>
>>>> Very good point! Actually I don't see any real need for this check.
>>>> I thin we lose nothing if we simply remove it.
>>>>
>>> Just see that this check only prints a warning, the actual issue comes
>>> from the ilog2 in AT24_DEVICE_MAGIC.
>>> When we need one more config parameter anyway (for the MAC start address),
>>> then IMO it would make sense to convert the magic to a proper struct.
>>> I'll spend a few thoughts on that.
>>>
>>
>> One thing that bothers me is that we now have a feature in the kernel
>> (reading the MAC address from at24mac402/at24mac604) which doesn't
>> work and any patch fixing it, that at the same time significantly
>> changes the code would likely not make its way into the stable
>> branches.
>>
>> I see it like this: I would like to merge commit ("eeprom: at24: fix
>> reading from 24MAC402/24MAC602") first: that would at least fix the
>> at24mac402 case. For at24mac602 it would be ok to create the MAGIC
>> manually without the call to ilog2(). Such changes would then be
>> submitted for linux-stable.
>>
> I think it's opposite, 24MAC402 causes the trouble due to byte_len = 6.

Indeed.

> Approach is fine with me, are you going to prepare the fix for
> replacing the magic for 24MAC402 ?
>

Yes, I'll post it later today.

>> After these two patches, I will merge the regmap conversion patches
>> and we would base any subsequent development (e.g. magic -> struct
>> conversion) on top of that. How about that?
>>
> Also fine with me, then I will send the (hopefully) final series
> tonight incl. the last small requested change.
>

Ok, I'll give it a last testing spin on top of 4.15-rc1 and hopefully
we can have it in by Wednesday.

Thanks,
Bartosz

>> Best regards,
>> Bartosz Golaszewski
>>
>>>>>>> So the caller has to provide offset 0x08 to read the mac what is
>>>>>>> greater than the chip size of 6 bytes.
>>>>>>> So reading the mac via nvmem sysfs interface shouldn't be possible.
>>>>>>>
>>>>>>> I saw that you submitted the 24macx02 code, did you test the driver
>>>>>>> with one of these chips and I miss something?
>>>>>>>
>>>>>>
>>>>>> At the time when I submitted the support for at24cs (which I had
>>>>>> tested both for 8- and 16-bit addresses), Wolfram suggested that I
>>>>>> include support for at24mac too, but since I don't have such a chip, I
>>>>>> could not really test it. Looking at the note on page 21 of the
>>>>>> relevant datasheet, it's obvious it can't work. I must have missed
>>>>>> that at the time of writing the code.
>>>>>>
>>>>>> Also: there's this patch[1] which looks like a workaround for this
>>>>>> problem. I'm Cc'ing the author.
>>>>> I tried to make this driver work for chip at [3] which EUI-48 is located at 0xfa
>>>>> and providing this offset via device tree was my first option in order
>>>>> to not broke the initial functionality. Anyway, the device tree approach
>>>>> as not accepted at that time, the usage of another DT binding was proposed
>>>>> to me at that time but I didn't found that feasible, said about it on
>>>>> mailing list but I didn't received any other inputs.
>>>>>
>>>>
>>>> My patch works for the two MAC EEPROM's currently supported by the driver,
>>>> but not for others like the one mentioned by you (Microchip 24AA02E48 and
>>>> friends) because they have other start addresses for the MAC.
>>>>
>>>> To deal with this situation we would have to add the MAC start address to
>>>> the chip config data. In addition the proposed DT parameter would helpful
>>>> in case chips are used which are not yet supported by the driver
>>>> (similar to the recently introduced "size" parameter).
>>>>
>>>>
>>>> Bartosz, can we first go with the additional sanity checking in
>>>> at24_read/write (if fine with you) and my i2c refactoring
>>>> (will resubmit with the last small change)?
>>>> Then the driver is somewhat smaller and simpler what makes further
>>>> improvements easier.
>>>>
>>>> Kind regards,
>>>> Heiner
>>>>
>>>>>>
>>>>>> @Claudiu: is that the case or do you actually have an EEPROM chip with
>>>>>> the MAC at a different offset? Could you by any chance test the
>>>>>> patch[2] from Heiner?
>>>>> I have chip at [3] with MAC at 0xfa.
>>>>>
>>>>> Regarding the testing of patch [2], at this moment I haven't a board
>>>>> with at24mac602 EEPROM. I will come back later to this thread as soon as
>>>>> I will have one. Regarding the changes, if I remember good, the
>>>>> at24->chip.byte_len is truncated at something which is power of 2,
>>>>> in case of 24mac402 will be 4 not 6 as expected, so it should return
>>>>> only 4 LSB bytes of MAC. Other than this it looks OK from my point
>>>>> of view.
>>>>>
>>>>> Thanks,
>>>>> Claudiu
>>>>>
>>>>> [3] http://ww1.microchip.com/downloads/en/DeviceDoc/20002124G.pdf
>>>>>>
>>>>>>> Most likely we would have to change the driver so that the caller can
>>>>>>> read the mac from offset 0.
>>>>>>>
>>>>>>> Rgds, Heiner
>>>>>>>
>>>>>>
>>>>>> Best regards,
>>>>>> Bartosz Golaszewski
>>>>>>
>>>>>> [1] http://patchwork.ozlabs.org/patch/785106/
>>>>>> [2] http://patchwork.ozlabs.org/patch/840958/
>>>>>>
>>>>>
>>>>
>>>
>>
>
