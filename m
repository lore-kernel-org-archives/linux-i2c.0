From: Daniel Versick <danls@versick.de>
Subject: Re: i2c-ismt timeout
Date: Fri, 29 Sep 2017 11:42:53 +1000
Message-ID: <32955283-6B43-4F69-A8A0-5001FAD0219E@versick.de>
References: <0564ED57-D2B8-4192-8747-283F8DCCDEC5@versick.de>
 <20170927125757.GA15682@hmswarspite.think-freely.org>
 <499D67D9-2705-4006-9CBC-C2319C7CFE1C@versick.de>
 <20170928114028.GA14560@hmswarspite.think-freely.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from versick.de ([54.229.28.156]:36264 "EHLO www.versick.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750832AbdI2BnC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 28 Sep 2017 21:43:02 -0400
In-Reply-To: <20170928114028.GA14560@hmswarspite.think-freely.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Neil Horman <nhorman@tuxdriver.com>
Cc: Seth Heasley <seth.heasley@intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

Thanks for your pointers.
Some more information might help to isolate the issue:
* I tried the delay patch without success
* Yes, I used a distribution kernel - I will try the recent upstream version
* The DMA commit is not in the driver that I tested - I’ll test it but I am pretty sure that it won’t resolve the issue as the problem also occurred when only transmitting QUICK requests (which shouldn’t call dma_unmap_single); but I’ll double-check that

About the occurrences:
I tried to transmit quick and byte data transfers to different I2C clients on the bus. My current findings are that it does not matter which client I send to nor which type of transfer I do. It will happen with certain probability (I got the impression that a heavily loaded bus does not increase probability of occurrence; it just happens earlier as there are more transfers — but I actually cannot prove that probabilistically, it is just my feeling).
On my device I can get the bus into a bad state within minutes when doing lots of I2C transfers.

I’ll do some more tests and will post my findings,
Daniel

> On 28 Sep 2017, at 9:40 pm, Neil Horman <nhorman@tuxdriver.com> wrote:
> 
> On Thu, Sep 28, 2017 at 06:46:20AM +1000, Daniel Versick wrote:
>> 
>>> On 27 Sep 2017, at 10:57 pm, Neil Horman <nhorman@tuxdriver.com> wrote:
>>> 
>>> On Tue, Sep 26, 2017 at 09:50:40AM +1000, Daniel Versick wrote:
>>>> Hi,
>>>> 
>>>> I am trying to resolve the known issue of ‘completion timed out’ in the i2c-ismt driver which has been reported a couple of times. I’ve seen few requests referring to it but no working solution yet.
>>>> 
>>>> I can reliably reproduce that problem on an Intel Atom C2xxx-based device and I found out that the driver does not receive interrupts anymore after getting into the timeout state. Even changing the driver to a polling version shows the same behaviour. It just does not receive a status bit change after transaction. So there is no problem with the MSI interrupt system which has been my first guess.
>>>> 
>>>> When being in the timeout state, the SMbus controller seems to be in such a bad condition that I cannot revive it at all. I tried different resets (such as ISMT_GCTRL_SRST and reseting the driver data structures). Only rebooting the device resolves the problem until next occurrence. A scope shows that data and clock lines are high.
>>>> 
>>>> I found a patch on the Internet which slows down the I2C communication by adding a delay to ismt_access. This patch probably refers to a known errata of the Atom S1200 and might work there but is no solution for the problem I am currently facing.
>>>> 
>>>> Are there any ideas or further information which might help? I tend to believe that this might be a silicon issue. Is there anything known?
>>>> 
>>> Lets start with the easy question - What kernel version are you using?
>> 
>> 4.9.36
>> 
> I'm not exactly sure what 4.9.36 is?  4.9 is an upstream released kernel, so I'm
> assuming that this is a distribution kernel of some sort?  I would suggest
> trying with a recent upstream kernel.  Theres not to much that has changed,
> though there is one dma unmap error that might result in putting the hardware in
> an odd state which may have some relevance here (not overly hopeful on that, but
> its worth trying, its commit 17e83549e199d89aace7788a9f11c108671eecf5 if you are
> curious). I presume you've also tried the delay patch, just to be through?
> 
> Beyond that, looking at the mail archives, no one has been able to
> say much about this issue beyond "it happens sometimes".  Can you tell me
> anything about the conditions under which the error might happen, or how
> frequently it occurs?
> 
> Neil
> 
>> Daniel
>>> 
>>> Neil
>>> 
>>>> Thanks and regards,
>>>> Daniel
