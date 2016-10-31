From: "Frkuska, Joshua" <joshua_frkuska@mentor.com>
Subject: Re: [PATCH] i2c: imx: add slave support. v2 status
Date: Mon, 31 Oct 2016 11:14:08 +0900
Message-ID: <0f7d5f1c-5889-27f3-f4e0-fc79960b8bf2@mentor.com>
References: <1e9f10a4-6ea2-3dd9-159e-fd70f7c40224@mentor.com>
 <2404b260-4bd6-8ff6-3898-c9c63aaf6855@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:57622 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757846AbcJaCOW (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 30 Oct 2016 22:14:22 -0400
In-Reply-To: <2404b260-4bd6-8ff6-3898-c9c63aaf6855@dev.rtsoft.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Maxim Syrchin <syrchin@dev.rtsoft.ru>, linux-i2c@vger.kernel.org
Cc: wsa@the-dreams.de, peda@axentia.se, Jiada_Wang@mentor.com, linux-kernel@vger.kernel.org, "Zapolskiy, Vladimir" <vladimir_zapolskiy@mentor.com>, "Baxter, Jim" <Jim_Baxter@mentor.com>

Hello Maxim,

Thank you very much for the intermediate patch. I am in the process of 
reviewing it. Please let me clarify a few questions I have.

1. What alternative to "bus busy/bus free/IBB" polling do you have in 
mind? This seems like a reasonable approach to me.
2. What are the major points you consider in need of refactoring?
3. You mention race conditions being fixed in this version relating to 
bus-locking by the slave and breaking slave transactions by the master. 
Does this mean mixed slave/master mode works to your satisfaction? If 
not, what work still needs to be done here?
4. You mention the need for a slave locking test and a work-around 
(checking IMX_I2C_I2DR and IBB) being in-place. Why is this work-around 
not sufficient?

Thanks again,

Joshua


On 10/28/2016 04:38 AM, Maxim Syrchin wrote:
> Hi,
> Sorry for huge delay in answering. Unfortunately we don't have enough 
> resources now to prepare clean enough patch to be accepted by community.
> Please find the latest version attached.  Driver has passed stress 
> tests, but looks like it need seriuos refactoring (it is unnecessarily 
> complicated).
> We still have polling in slave code. Since imx doesn't generate 
> interrupt on "bus busy"/"bus free" events we have to test IBB bit in 
> polling loop.
> Comparing to v2 version several race conditions were fixed (bus 
> locking by slave, breaking slave transaction by starting master xfer). 
> v2 is working pretty good in slave-only or master-only mode. It is 
> reasonable to add  slave locking test  - sometimes imx6 hw doesn't 
> release data line. As workaround we use dummy reading of IMX_I2C_I2DR 
> if driver is in  slave mode and IBB bit is set for a long time.
>
> Thanks,
> Maxim Syrchin
>
>
> 27.10.2016 10:31, Frkuska, Joshua пишет:
>> Hi Maxim, Dmitriy, Wolfram,
>>
>> If there is no immediate plan for a third release of the below patch 
>> set, would it be possible to continue with merging v2 after 
>> addressing the remaining concerns?
>>
>>
>> Thank you and regards,
>>
>> Joshua
>>> Hi Maxim,
>>>
>>> On 2016-03-04 11:06:10 in the thread "Re: [PATCH] i2c: imx: add 
>>> slave support. v2"
>>> referenced here:   https://patchwork.ozlabs.org/patch/573353/ you said:
>>>> Hi Wolfram,
>>>> I'm now working on creating new driver version. I think I'll be 
>>>> able to
>>>> sent it soon.
>>> Do you still plan to release a driver update for an i2c imx driver 
>>> slave support?
>>>
>>> Best regards,
>>> Jim Baxter
>>>
>

-- 
_______________________________________________
Joshua Frkuska | Embedded Software Engineer
Mentor Graphics Japan Co., ltd. | +81-3-6866-7611

PRIVACY AND CONFIDENTIALITY NOTICE
This email and any attachments may contain confidential or privileged information for the sole use of the intended recipient.  Any review, reliance or distribution by others or forwarding without express permission is strictly prohibited.  If you are not the intended recipient, please contact the sender and delete all copies.
