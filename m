From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/3] i2c: Revert "i2c: xiic: Do not reset controller before
 every transfer"
Date: Wed, 18 Nov 2015 11:01:56 +0100
Message-ID: <564C4C94.6020406@metafoo.de>
References: <1447681325-30914-1-git-send-email-lars@metafoo.de>	<CAKfKVtGqPPP=bnWH4dPLT1=gjrvZe=0zmix58SKBT79MsR+CXg@mail.gmail.com>	<564AD886.3060108@metafoo.de> <CAKfKVtGFfKw8nJO5RobMtBrtS7dX-m4i+tuYHkNJd0+j2w80Lg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp-out-064.synserver.de ([212.40.185.64]:1252 "EHLO
	smtp-out-188.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932087AbbKRKCE (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 18 Nov 2015 05:02:04 -0500
In-Reply-To: <CAKfKVtGFfKw8nJO5RobMtBrtS7dX-m4i+tuYHkNJd0+j2w80Lg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Shubhrajyoti Datta <shubhraj@xilinx.com>, linux-i2c@vger.kernel.org

On 11/17/2015 03:28 PM, Shubhrajyoti Datta wrote:
> On Tue, Nov 17, 2015 at 1:04 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 11/17/2015 06:17 AM, Shubhrajyoti Datta wrote:
>>> On Mon, Nov 16, 2015 at 7:12 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>>> Commit d701667bb331 ("i2c: xiic: Do not reset controller before every
>>>> transfer") removed the reinitialization of the controller before the start
>>>> of each transfer. Apparently this change is not safe to make and the commit
>>>> results in random I2C bus failures.
>>>
>>> Which is the platform and the ip version that you  saw the issue.
>>> Did you see the issue with read and write as  well?
>>
>> The IP version is the axi-iic v2.0 Revision 8. I've tested this on a few
>> platforms, custom ones and standard ones and I could reproduce it on most.
>> One of them was on the ZED board. The one where I couldn't reproduce it was
>> the ZC706. But that doesn't necessarily mean it doesn't happen there, just
>> that it is not triggered by the testcase.
> All the boards having the same version of the ip is what I have understood.
> 
> Thanks for the info I will try to  reproduce the issue.
> 
>>
>> The problem is that it is random corruption,
> Of registers?

To be honest I don't know if there is corruption during I2C write transfers,
but there is definitely corruption during read transactions.

- Lars
