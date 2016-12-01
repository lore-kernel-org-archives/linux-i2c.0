From: "Frkuska, Joshua" <joshua_frkuska@mentor.com>
Subject: Re: [PATCH] i2c: imx: add slave support. v2 status
Date: Thu, 1 Dec 2016 17:11:04 +0900
Message-ID: <31603684-e75a-a245-03d6-5447e9ba7f6b@mentor.com>
References: <1e9f10a4-6ea2-3dd9-159e-fd70f7c40224@mentor.com>
 <2404b260-4bd6-8ff6-3898-c9c63aaf6855@dev.rtsoft.ru>
 <0f7d5f1c-5889-27f3-f4e0-fc79960b8bf2@mentor.com>
 <4553f82f-d5aa-8c31-5a6a-108582810b14@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4553f82f-d5aa-8c31-5a6a-108582810b14@dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxim Syrchin <syrchin@dev.rtsoft.ru>, linux-i2c@vger.kernel.org
Cc: wsa@the-dreams.de, peda@axentia.se, Jiada_Wang@mentor.com, linux-kernel@vger.kernel.org, "Zapolskiy, Vladimir" <vladimir_zapolskiy@mentor.com>, "Baxter, Jim" <Jim_Baxter@mentor.com>
List-Id: linux-i2c@vger.kernel.org

Hello Maxim,

I have a few questions for you. Please see my comments inline below.

In addition, I have modified your patch-set slightly and I would like to 
progress it to merger if you do not have any issues with this. I would 
like to sync with you here before moving forward and submitting a new patch.

Thank you and best regards,

Joshua

On 11/01/2016 03:21 AM, Maxim Syrchin wrote:
> Hello,
>
> Please find some comments below.
>
>
> 31.10.2016 5:14, Frkuska, Joshua пишет:
>> Hello Maxim,
>>
>> Thank you very much for the intermediate patch. I am in the process 
>> of reviewing it. Please let me clarify a few questions I have.
>>
>> 1. What alternative to "bus busy/bus free/IBB" polling do you have in 
>> mind? This seems like a reasonable approach to me.
> We didn't find any suitable alternatives. The only one we're 
> considered was using timeout on receive (which is kind of polling of 
> course)
>> 2. What are the major points you consider in need of refactoring?
> As you can see we have implemented FSM in slave thread.
> - Due to lack of time all master functionality had not been included 
> in State Machine.
Currently there seems to not be a problem of entirely handling master 
functionality in the slave state machine as it is handled outside of it. 
Do you feel everything should be handled in the slave state machine? I 
dont see any holes in the logic currently.
> - wait_event_timeout() calls are used in every event handler (obviosly 
> it is better to have only one wait function)
It is possible to have a single wait_event_timeout call at the expense 
of a bit of conditional logic in i2c_imx_slave_threadfn but this brings 
me to my next comment
> - Need to review state switching code
I have reviewed all states in a state transition table and all of them 
seem well defined. My only question here is in regards to the STATE_SP 
state. I would like to understand your motivation for it. To me it seems 
like this can also be handled in STATE_IDLE but I would like to get your 
reasoning behind it
>> 3. You mention race conditions being fixed in this version relating 
>> to bus-locking by the slave and breaking slave transactions by the 
>> master. Does this mean mixed slave/master mode works to your 
>> satisfaction? If not, what work still needs to be done here?
> Yes mixed slave/master mode works ok. It had passed long-lasting 
> stress tests (async message exchange of two imx6 boards connected 
> together by i2c bus )
>> 4. You mention the need for a slave locking test and a work-around 
>> (checking IMX_I2C_I2DR and IBB) being in-place. Why is this 
>> work-around not sufficient?
> By the time we discovered I2DR workaround we went far from version 2 
> of driver and it wasn't tested. I'm sure that I2DR workaround will 
> improve stability, but I do not know if it will fix all issues (i.e. 
> passing of stress tests )
>
>
> Best Regards,
> Maxim Syrchin
>> Thanks again,
>>
>> Joshua
>>
>>
>> On 10/28/2016 04:38 AM, Maxim Syrchin wrote:
>>> Hi,
>>> Sorry for huge delay in answering. Unfortunately we don't have 
>>> enough resources now to prepare clean enough patch to be accepted by 
>>> community.
>>> Please find the latest version attached.  Driver has passed stress 
>>> tests, but looks like it need seriuos refactoring (it is 
>>> unnecessarily complicated).
>>> We still have polling in slave code. Since imx doesn't generate 
>>> interrupt on "bus busy"/"bus free" events we have to test IBB bit in 
>>> polling loop.
>>> Comparing to v2 version several race conditions were fixed (bus 
>>> locking by slave, breaking slave transaction by starting master 
>>> xfer). v2 is working pretty good in slave-only or master-only mode. 
>>> It is reasonable to add  slave locking test - sometimes imx6 hw 
>>> doesn't release data line. As workaround we use dummy reading of 
>>> IMX_I2C_I2DR if driver is in  slave mode and IBB bit is set for a 
>>> long time.
>>>
>>> Thanks,
>>> Maxim Syrchin
>>>
>>>
>>> 27.10.2016 10:31, Frkuska, Joshua пишет:
>>>> Hi Maxim, Dmitriy, Wolfram,
>>>>
>>>> If there is no immediate plan for a third release of the below 
>>>> patch set, would it be possible to continue with merging v2 after 
>>>> addressing the remaining concerns?
>>>>
>>>>
>>>> Thank you and regards,
>>>>
>>>> Joshua
>>>>> Hi Maxim,
>>>>>
>>>>> On 2016-03-04 11:06:10 in the thread "Re: [PATCH] i2c: imx: add 
>>>>> slave support. v2"
>>>>> referenced here: https://patchwork.ozlabs.org/patch/573353/ you said:
>>>>>> Hi Wolfram,
>>>>>> I'm now working on creating new driver version. I think I'll be 
>>>>>> able to
>>>>>> sent it soon.
>>>>> Do you still plan to release a driver update for an i2c imx driver 
>>>>> slave support?
>>>>>
>>>>> Best regards,
>>>>> Jim Baxter
>>>>>
>>>
>>
>
