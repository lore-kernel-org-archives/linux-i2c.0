From: Peter Rosin <peda@axentia.se>
Subject: Re: i2c: slave support framework improvements
Date: Mon, 15 Aug 2016 10:58:01 +0200
Message-ID: <b2070d79-ab76-a2f5-658f-d24ad0229b04@axentia.se>
References: <20160725082813.GA3376@katana> <1025301469437877@web19h.yandex.ru>
 <20160725094117.GB3376@katana> <1391831469440835@web19h.yandex.ru>
 <499754e2-f60a-5170-21f3-d756f768dd0d@axentia.se>
 <168841469551868@web14h.yandex.ru> <20160728074157.GA2693@katana>
 <9bf9e528-de4a-df4d-fed4-ee1afbfb609a@axentia.se>
 <20160728083914.GC2693@katana>
 <c72d3c73-30e4-1ee0-f763-99027e35051f@axentia.se>
 <20160728091514.GA17499@katana>
 <abd15f46-48d3-f8cc-c2bc-3cb861c2ca3c@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0113.outbound.protection.outlook.com ([104.47.2.113]:57580
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752421AbcHOI6K (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 15 Aug 2016 04:58:10 -0400
In-Reply-To: <abd15f46-48d3-f8cc-c2bc-3cb861c2ca3c@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Kachalov Anton <mouse@mayc.ru>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On 2016-07-28 11:39, Peter Rosin wrote:
> On 2016-07-28 11:15, Wolfram Sang wrote:
>>
>>> What I mean is that it is possible to have an i2c bus with some random
>>> i2c device at e.g. address 0x48, say some eeprom, and then register to
>>> be a slave device also at address 0x48, e.g. slave-24c02. If there is
>>> another master on the bus, it cannot sanely use any of these two devices
>>> at i2c address 0x48 since there is an address conflict.
>>
>> That is an address conflict, yes. Even for a single-master system. You
>> need to make sure your slave address is unique on the bus. The kernel
>> can't really help you with that, because it could only detect address
>> conflicts if a driver would be attached to a device. If there is no
>> driver and all communication is done via i2c-dev, for example, then
>> I can't see a way to detect this.
> 
> Why do you talk about i2c-dev and other random i2c accesses?
> 
> I don't see where the conflict is prevented even if everything is
> registered properly with in-kernel drivers, and it looks trivial to
> prevent. Just stop accounting for the I2C_CLIENT_SLAVE flag when
> comparing addresses would fix it, I think. I also don't see how the
> tegra loopback has anything to do with this. Or rather, it has
> everything to do with this. Because that actually makes this a
> problem even without another master on the bus (but then registering
> as a slave makes no sense, but that's beside the point).

Ok, I see what they are doing. They register a slave device AND a driver
and then they are able to communicate with themselves since the adapter
supports loopback. But that seems like the odd case which is not really
useful for anything but debugging (or maybe for cases where other code
expects an i2c device that is then emulated this way).

If you really have a separate device on the bus with the same address
that you want to add slave support for, then there really is a conflict,
and the kernel knows it. I think it would be nice if such mistakes were
prevented. Agreed? After all, the kernel prevents other obvious i2c
address conflicts and consistency is nice.

Cheers,
Peter
