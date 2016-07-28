From: Peter Rosin <peda@axentia.se>
Subject: Re: i2c: slave support framework improvements
Date: Thu, 28 Jul 2016 10:20:23 +0200
Message-ID: <9bf9e528-de4a-df4d-fed4-ee1afbfb609a@axentia.se>
References: <20160723195114.GA2104@katana> <27421469430128@web19h.yandex.ru>
 <20160725072151.GA1599@katana> <354241469432837@web19h.yandex.ru>
 <20160725082813.GA3376@katana> <1025301469437877@web19h.yandex.ru>
 <20160725094117.GB3376@katana> <1391831469440835@web19h.yandex.ru>
 <499754e2-f60a-5170-21f3-d756f768dd0d@axentia.se>
 <168841469551868@web14h.yandex.ru> <20160728074157.GA2693@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0104.outbound.protection.outlook.com ([104.47.2.104]:11359
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757669AbcG1Mzq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 28 Jul 2016 08:55:46 -0400
In-Reply-To: <20160728074157.GA2693@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Kachalov Anton <mouse@mayc.ru>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On 2016-07-28 09:41, Wolfram Sang wrote:
> 
> I didn't read all, just found my name in this paragraph.
> 
>>> I'm also a bit surprised that you are allowed to create a new (dummy) device
>>> with an address that is already taken on a downstream mux client adapter.
>>> Is that a feature in the i2c core, or is it a bug? Wolfram?
>>
>> This is what I mean under the "populate all the slave devices beforehand".
>> From the i2c bus point of view, I just adding one device per bus. It's allowed.
>> From the adapter point of view, I duplicates clients with the same addr.
> 
> The slave device must be attached to the muxed adapter. There, the
> address should be free. The parent adapter should be reconfigured
> depending on the mux setting.
> 
> At least, that's the theory, dunno if this really works. I thought you
> would be doing this already?

Hi Wolfram,

Thinking about this a bit more, this is what happens.

In order to call i2c_slave_register, you need to have a slave device
on the adapter in question. So, Anton creates a proxy slave device on the
adapter the mux is connect to. This leads to an address conflict since
the proxy needs the same address that the real slave device has already
registered on the mux client adapter.

But that conflict does not happen! This is because the proxy slave device
is created using i2c_new_dummy, and the I2C_CLIENT_SLAVE flag is added
after the address conflict check in i2c_new_dummy.

The proxy slave device is created when the mux is first selected
on a channel that has a slave device on the client side of the mux, so
the whole scheme fails if there is a mux client side access before
the last real slave device has been registered. This access causes the
above address conflict to happen for subsequent additions of slave
devices on the client side, because then the proxy slave device now
has the I2C_CLIENT_FLAG, which the real slave devices also have. This
needs to be fixed somehow, but is not a bug in the i2c core. But the
i2c core might still need to be involved in fixing the problem of
course, for example by somehow not including the proxy slave device in
the normal list of client devices. Or something.

In proximity to this, I find it odd that you are allowed to register
a slave device with the same address as a client device on an adapter
(one has I2C_CLIENT_FLAG set, which sets I2C_ADDR_OFFSET_SLAVE before
the address comparisons). Why is that possible? Yes, the two devices
can probably talk each other, both being aware of who is master at
the moment, but what about other masters on the bus?

Cheers,
Peter
