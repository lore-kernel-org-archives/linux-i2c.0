From: Kachalov Anton <mouse@mayc.ru>
Subject: Re: i2c: slave support framework improvements
Date: Tue, 16 Aug 2016 16:53:18 +0300
Message-ID: <30371471355598@web10h.yandex.ru>
References: <1391831469440835@web19h.yandex.ru>
	 <499754e2-f60a-5170-21f3-d756f768dd0d@axentia.se>
	 <168841469551868@web14h.yandex.ru> <20160728074157.GA2693@katana>
	 <9bf9e528-de4a-df4d-fed4-ee1afbfb609a@axentia.se>
	 <20160728083914.GC2693@katana>
	 <c72d3c73-30e4-1ee0-f763-99027e35051f@axentia.se>
	 <20160728091514.GA17499@katana>
	 <abd15f46-48d3-f8cc-c2bc-3cb861c2ca3c@axentia.se>
	 <b2070d79-ab76-a2f5-658f-d24ad0229b04@axentia.se>
	 <20160816121205.GA2846@tetsubishi> <35e3622b-cc82-6b8b-2a2e-c62300080d89@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from forward4p.cmail.yandex.net ([77.88.31.19]:59574 "EHLO
	forward4p.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753677AbcHPNxy (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 16 Aug 2016 09:53:54 -0400
In-Reply-To: <35e3622b-cc82-6b8b-2a2e-c62300080d89@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Hello,

just want to remind my usage scenario where I have control board connected via i2c-mux switch to a number of Node. Control board and Nodes implements IPMB proto: each device acts as Slave (receive requests) and Master (send answers). Logically, there is one Master and many Slaves. Only Control board may switch i2c channel and talk to Nodes. CB's slave is constant (usually 0x20). To achieve this in our setup we instantiate a number of i2c-clients (dummy) and slaves with the same address. E.g. 0x11 for client write (Node) and 0x20 for slave read (ourselves, to receive answers from nodes).

Therefore, we should treat i2c-switch as one-way gate with multi-master.

Thanks.

16.08.2016, 16:33, "Peter Rosin" <peda@axentia.se>:
> On 2016-08-16 14:12, Wolfram Sang wrote:
>>  Hi Peter,
>>
>>>  If you really have a separate device on the bus with the same address
>>>  that you want to add slave support for, then there really is a conflict,
>>>  and the kernel knows it.
>>
>>  We still have a disagreement about "the kernel knows it". The kernel
>>  knows it only in one case, i.e. when you are able to describe all
>>  devices on the bus.
>>
>>  What about this compromise: We keep the current scheme, but print a
>>  warning when the kernel notices a slave device has the same address
>>  which is already claimed by a client driver. This will let most users
>>  know about the conflict but it will not hurt the debugging-via-loopback
>>  case, since people know what they are doing and will happily ignore it.
>>
>>  If you can agree to that, I'll cook up a patch later this week.
>
> Hmm, maybe add a "slave loopback quirk" to adapters that allows this,
> and forbid it if the quirk isn't present?
>
> (or use whatever flag is appropriate, if quirks do not fit)
>
> And/or require some kind of loopback flag when adding a client driver
> that is supported via loopback to a slave driver.
>
> Note, I do not feel strongly about this at all, I'm mainly trying to
> understand what's going on. Now I do understand, and do not desperately
> seek changes. It just looked fishy, that's all...
>
> Cheers,
> Peter
