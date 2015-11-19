From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Subject: Re: [PATCH 1/3] i2c: Revert "i2c: xiic: Do not reset controller
 before every transfer"
Date: Thu, 19 Nov 2015 12:50:21 +0530
Message-ID: <CAKfKVtEYaKxC7P=MW7Dh=dOQOwEjmJLQLH_fKy9NGq0OQSktKA@mail.gmail.com>
References: <1447681325-30914-1-git-send-email-lars@metafoo.de>
	<CAKfKVtGqPPP=bnWH4dPLT1=gjrvZe=0zmix58SKBT79MsR+CXg@mail.gmail.com>
	<564AD886.3060108@metafoo.de>
	<CAKfKVtGFfKw8nJO5RobMtBrtS7dX-m4i+tuYHkNJd0+j2w80Lg@mail.gmail.com>
	<564C4C94.6020406@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33907 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbbKSHUW (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 19 Nov 2015 02:20:22 -0500
Received: by qkfo3 with SMTP id o3so22826896qkf.1
        for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2015 23:20:21 -0800 (PST)
In-Reply-To: <564C4C94.6020406@metafoo.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Shubhrajyoti Datta <shubhraj@xilinx.com>, linux-i2c@vger.kernel.org

On Wed, Nov 18, 2015 at 3:31 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 11/17/2015 03:28 PM, Shubhrajyoti Datta wrote:
>> On Tue, Nov 17, 2015 at 1:04 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>> On 11/17/2015 06:17 AM, Shubhrajyoti Datta wrote:
>>>> On Mon, Nov 16, 2015 at 7:12 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>>>> Commit d701667bb331 ("i2c: xiic: Do not reset controller before every
>>>>> transfer") removed the reinitialization of the controller before the start
>>>>> of each transfer. Apparently this change is not safe to make and the commit
>>>>> results in random I2C bus failures.
>>>>
>>>> Which is the platform and the ip version that you  saw the issue.
>>>> Did you see the issue with read and write as  well?
>>>
>>> The IP version is the axi-iic v2.0 Revision 8. I've tested this on a few
>>> platforms, custom ones and standard ones and I could reproduce it on most.
>>> One of them was on the ZED board. The one where I couldn't reproduce it was
>>> the ZC706. But that doesn't necessarily mean it doesn't happen there, just
>>> that it is not triggered by the testcase.
>> All the boards having the same version of the ip is what I have understood.
>>
>> Thanks for the info I will try to  reproduce the issue.
>>
>>>
>>> The problem is that it is random corruption,
>> Of registers?
>
> To be honest I don't know if there is corruption during I2C write transfers,
> but there is definitely corruption during read transactions.
Ok

Actually  I was thinking it is only an issue with


<quote>
/* dynamic mode seem to suffer from problems if we just flushes
* fifos and the next message is a TX with len 0 (only addr)
* reset the IP instead of just flush fifos
*/
xiic_reinit(i2c);
<\quote>

I think as of now since read is also impacted we can revert it.


> - Lars
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
