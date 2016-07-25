From: Kachalov Anton <mouse@mayc.ru>
Subject: Re: i2c: slave support framework improvements
Date: Mon, 25 Jul 2016 13:00:35 +0300
Message-ID: <1391831469440835@web19h.yandex.ru>
References: <137031469256709@web4j.yandex.ru>
	 <20160723195114.GA2104@katana>
	 <27421469430128@web19h.yandex.ru>
	 <20160725072151.GA1599@katana>
	 <354241469432837@web19h.yandex.ru>
	 <20160725082813.GA3376@katana>
	 <1025301469437877@web19h.yandex.ru> <20160725094117.GB3376@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from forward5m.cmail.yandex.net ([5.255.216.23]:42254 "EHLO
	forward5m.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751127AbcGYKIb (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 25 Jul 2016 06:08:31 -0400
In-Reply-To: <20160725094117.GB3376@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Peter Rosin <peda@axentia.se>

You are welcome.

In my implementation in PCA954x I did the following things that I would=
 like to highlight:

1. handle slave register and store i2c_client data to the internal arra=
y
(length equal to number of channels). First obstacle =E2=80=93=C2=A0get=
 the right offset in
the array (channel number). It's better to expose "chan_id" field from
i2c_mux_priv as a public function. I did a hack during init by writing =
down
first muxc->adapter's number ("nr" field store in private adap_off).

2. during handling of select_chan I'm trying to register new i2c dummy
device with newly selected slave addr corresponding to the channel
number (if it has a slave). This is the second problem =E2=80=93 after =
I've registered
dummy device with some slave address, I'm not able to register slave
devices for other mux'ed busses with the same slave addr. In other word=
s,
I have to populate all the slave devices (with the same slave addr)
right before I'm going to use the bus first time.

3. registering and/or unregister first (if applicable) slave device on =
the parent
bus adapter. This is the third obstacle. While the bus is already locke=
d,
calling generic i2c_slave_{register,unregister} lead to the deadlock.
I did it directly via the reg_slave/unreg_slave calls of appropriate da=
ta structure.

Notes:
Slave works only with keeping channel selected while generic i2c-mux lo=
gic
is to deselect channel after each i2c transfers.

25.07.2016, 12:41, "Wolfram Sang" <wsa@the-dreams.de>:
>> =C2=A0There is no way to switch mux and request to BMC #2. Logically=
, this shouldn't
>> =C2=A0happen too.
>
> I see. I think I have the big picture now, thanks for the heads up.
>
> However, I am not sure what recommendations I can give to you. I'd st=
art
> with adding reg_slave to the muxed adapters and then try to reconfigu=
re
> the real adapter when the mux switches (I assume you did that already=
).
> But I don't have the bandwidth to dive into that and see what gory
> details come up. Maybe Peter Rosin has something to add, though?
