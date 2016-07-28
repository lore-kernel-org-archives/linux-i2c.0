From: Kachalov Anton <mouse@mayc.ru>
Subject: Re: i2c: slave support framework improvements
Date: Thu, 28 Jul 2016 17:44:02 +0300
Message-ID: <356461469717042@web3h.yandex.ru>
References: <20160723195114.GA2104@katana>
	 <27421469430128@web19h.yandex.ru>
	 <20160725072151.GA1599@katana>
	 <354241469432837@web19h.yandex.ru>
	 <20160725082813.GA3376@katana>
	 <1025301469437877@web19h.yandex.ru>
	 <20160725094117.GB3376@katana>
	 <1391831469440835@web19h.yandex.ru>
	 <499754e2-f60a-5170-21f3-d756f768dd0d@axentia.se>
	 <168841469551868@web14h.yandex.ru> <20160728074157.GA2693@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from forward3p.cmail.yandex.net ([77.88.31.18]:40534 "EHLO
	forward3p.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755370AbcG1OzE (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 28 Jul 2016 10:55:04 -0400
In-Reply-To: <20160728074157.GA2693@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Peter Rosin <peda@axentia.se>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>



28.07.2016, 10:42, "Wolfram Sang" <wsa@the-dreams.de>:
> I didn't read all, just found my name in this paragraph.
>
>> =C2=A0> I'm also a bit surprised that you are allowed to create a ne=
w (dummy) device
>> =C2=A0> with an address that is already taken on a downstream mux cl=
ient adapter.
>> =C2=A0> Is that a feature in the i2c core, or is it a bug? Wolfram?
>>
>> =C2=A0This is what I mean under the "populate all the slave devices =
beforehand".
>> =C2=A0From the i2c bus point of view, I just adding one device per b=
us. It's allowed.
>> =C2=A0From the adapter point of view, I duplicates clients with the =
same addr.
>
> The slave device must be attached to the muxed adapter. There, the
> address should be free. The parent adapter should be reconfigured
> depending on the mux setting.
>
> At least, that's the theory, dunno if this really works. I thought yo=
u
> would be doing this already?

Correct. Here is the instantiation of the proxy client on the root bus:

https://github.com/ya-mouse/openbmc-target/blob/master/aspeed/patches-4=
=2E4/0065-i2c-slave-mux-pca954x.patch#L46

and here is reconfiguration:

https://github.com/ya-mouse/openbmc-target/blob/master/aspeed/patches-4=
=2E4/0065-i2c-slave-mux-pca954x.patch#L57
https://github.com/ya-mouse/openbmc-target/blob/master/aspeed/patches-4=
=2E4/0065-i2c-slave-mux-pca954x.patch#L60
