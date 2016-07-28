From: Peter Rosin <peda@axentia.se>
Subject: Re: i2c: slave support framework improvements
Date: Thu, 28 Jul 2016 10:54:34 +0200
Message-ID: <c72d3c73-30e4-1ee0-f763-99027e35051f@axentia.se>
References: <20160725072151.GA1599@katana> <354241469432837@web19h.yandex.ru>
 <20160725082813.GA3376@katana> <1025301469437877@web19h.yandex.ru>
 <20160725094117.GB3376@katana> <1391831469440835@web19h.yandex.ru>
 <499754e2-f60a-5170-21f3-d756f768dd0d@axentia.se>
 <168841469551868@web14h.yandex.ru> <20160728074157.GA2693@katana>
 <9bf9e528-de4a-df4d-fed4-ee1afbfb609a@axentia.se>
 <20160728083914.GC2693@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr30094.outbound.protection.outlook.com ([40.107.3.94]:60352
	"EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750834AbcG1Iyo (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 28 Jul 2016 04:54:44 -0400
In-Reply-To: <20160728083914.GC2693@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Kachalov Anton <mouse@mayc.ru>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On 2016-07-28 10:39, Wolfram Sang wrote:
> 
>> In proximity to this, I find it odd that you are allowed to register
>> a slave device with the same address as a client device on an adapter
>> (one has I2C_CLIENT_FLAG set, which sets I2C_ADDR_OFFSET_SLAVE before
>> the address comparisons). Why is that possible? Yes, the two devices
>> can probably talk each other, both being aware of who is master at
>> the moment, but what about other masters on the bus?
> 
> Just a quick answer to this first: The Tegra community wanted to have
> loopback support. According to documentation, their hardware can indeed
> read from their own slave device. So, we needed this distinction to
> instantiate the slave backend driver and the regular driver.
> 
> I don't understand the multi-master question: The I2C slave device
> should react to any bus master anyhow. And for competing bus masters,
> there is the arbitration mechanism.

What I mean is that it is possible to have an i2c bus with some random
i2c device at e.g. address 0x48, say some eeprom, and then register to
be a slave device also at address 0x48, e.g. slave-24c02. If there is
another master on the bus, it cannot sanely use any of these two devices
at i2c address 0x48 since there is an address conflict.

Or am I misunderstanding something? In my mind i2c slave support is
the equivalent of usb gadget support, is it something else?

Cheers,
Peter
