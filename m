From: Peter Rosin <peda@axentia.se>
Subject: Re: i2c: slave support framework improvements
Date: Tue, 16 Aug 2016 15:33:50 +0200
Message-ID: <35e3622b-cc82-6b8b-2a2e-c62300080d89@axentia.se>
References: <1391831469440835@web19h.yandex.ru>
 <499754e2-f60a-5170-21f3-d756f768dd0d@axentia.se>
 <168841469551868@web14h.yandex.ru> <20160728074157.GA2693@katana>
 <9bf9e528-de4a-df4d-fed4-ee1afbfb609a@axentia.se>
 <20160728083914.GC2693@katana>
 <c72d3c73-30e4-1ee0-f763-99027e35051f@axentia.se>
 <20160728091514.GA17499@katana>
 <abd15f46-48d3-f8cc-c2bc-3cb861c2ca3c@axentia.se>
 <b2070d79-ab76-a2f5-658f-d24ad0229b04@axentia.se>
 <20160816121205.GA2846@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0096.outbound.protection.outlook.com ([104.47.2.96]:27872
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752367AbcHPUJY (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 16 Aug 2016 16:09:24 -0400
In-Reply-To: <20160816121205.GA2846@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Kachalov Anton <mouse@mayc.ru>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On 2016-08-16 14:12, Wolfram Sang wrote:
> Hi Peter,
> 
>> If you really have a separate device on the bus with the same address
>> that you want to add slave support for, then there really is a conflict,
>> and the kernel knows it.
> 
> We still have a disagreement about "the kernel knows it". The kernel
> knows it only in one case, i.e. when you are able to describe all
> devices on the bus.
> 
> What about this compromise: We keep the current scheme, but print a
> warning when the kernel notices a slave device has the same address
> which is already claimed by a client driver. This will let most users
> know about the conflict but it will not hurt the debugging-via-loopback
> case, since people know what they are doing and will happily ignore it.
> 
> If you can agree to that, I'll cook up a patch later this week.

Hmm, maybe add a "slave loopback quirk" to adapters that allows this,
and forbid it if the quirk isn't present?

(or use whatever flag is appropriate, if quirks do not fit)

And/or require some kind of loopback flag when adding a client driver
that is supported via loopback to a slave driver.

Note, I do not feel strongly about this at all, I'm mainly trying to
understand what's going on. Now I do understand, and do not desperately
seek changes. It just looked fishy, that's all...

Cheers,
Peter
