From: Peter Rosin <peda@axentia.se>
Subject: Re: i2c: slave support framework improvements
Date: Thu, 28 Jul 2016 10:25:12 +0200
Message-ID: <6b370b54-50fe-3b79-ef26-49f1c4559507@axentia.se>
References: <137031469256709@web4j.yandex.ru> <20160723195114.GA2104@katana>
 <27421469430128@web19h.yandex.ru> <20160725072151.GA1599@katana>
 <354241469432837@web19h.yandex.ru> <20160725082813.GA3376@katana>
 <1025301469437877@web19h.yandex.ru> <20160725094117.GB3376@katana>
 <1391831469440835@web19h.yandex.ru>
 <499754e2-f60a-5170-21f3-d756f768dd0d@axentia.se>
 <168841469551868@web14h.yandex.ru>
 <173323d0-32c0-3093-1f12-718a5d7e4c9e@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0098.outbound.protection.outlook.com ([104.47.1.98]:30059
	"EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750707AbcG1SAt (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 28 Jul 2016 14:00:49 -0400
In-Reply-To: <173323d0-32c0-3093-1f12-718a5d7e4c9e@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kachalov Anton <mouse@mayc.ru>, Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On 2016-07-28 08:55, Peter Rosin wrote:
> On 2016-07-26 18:51, Kachalov Anton wrote:
>> I'm able to register individual slave clients on each muxed bus like the following:
>>
>> echo slave-24c02 0x1011 > /sys/bus/i2c/devices/i2c-9/new_device
>> echo slave-24c02 0x1011 > /sys/bus/i2c/devices/i2c-10/new_device
>> echo slave-24c02 0x1013 > /sys/bus/i2c/devices/i2c-11/new_device
>> echo slave-24c02 0x1011 > /sys/bus/i2c/devices/i2c-12/new_device
>>
>> only if I do not access i2c muxed bus somewhere between adding devices, like:
>>
>> echo aspeed,i2c-ipmb 0x11 > /sys/bus/i2c/devices/i2c-9/new_device
>> i2cdetect -y 10
>> # next command will return (-16)
>> # [...] i2c i2c-10: Failed to register i2c client slave-24c02 at 0x11 (-16)
>> echo slave-24c02 0x1011 > /sys/bus/i2c/devices/i2c-10/new_device
>> # [...] i2c i2c-11: Failed to register i2c client slave-24c02 at 0x11 (-16)
>> echo slave-24c02 0x1011 > /sys/bus/i2c/devices/i2c-11/new_device
> 
> Is this with your patch? If so, then that makes perfect sense since
> your dummy device sits on the root adapter, and you are not allowed
> to create address conflicts between clients on the root adapter and
> clients on downstream muxes.
> 
> I think the problem is that when you call i2c_new_dummy, it calls
> i2c_new_device without the I2C_CLIENT_SLAVE flag (which you try to
> add too late). If you open code i2c_new_dummy and add this flag
> before calling i2c_new_device, it might work better?

No, it might not. See my reply to Wolfram...

Cheers,
Peter
