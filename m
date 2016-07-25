From: Kachalov Anton <mouse@mayc.ru>
Subject: Re: i2c: slave support framework improvements
Date: Mon, 25 Jul 2016 12:11:17 +0300
Message-ID: <1025301469437877@web19h.yandex.ru>
References: <137031469256709@web4j.yandex.ru>
	 <20160723195114.GA2104@katana>
	 <27421469430128@web19h.yandex.ru>
	 <20160725072151.GA1599@katana>
	 <354241469432837@web19h.yandex.ru> <20160725082813.GA3376@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from forward2h.cmail.yandex.net ([87.250.230.17]:49007 "EHLO
	forward2h.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752252AbcGYJLV (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 25 Jul 2016 05:11:21 -0400
In-Reply-To: <20160725082813.GA3376@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>



25.07.2016, 11:28, "Wolfram Sang" <wsa@the-dreams.de>:
> Please word wrap your messages.
>
>> =C2=A0but the line is muxed until timeout or answer received by RMC.=
 BMCs
>> =C2=A0are passive and only responds to requests.
>
> OK, I see.
>
> What about serialization? Can it happen that you send a request to BM=
C
> #1 and before the answer, you need to send an urgent request to BMC #=
2?

Timeout for answer is quite short. Please refer to table at page 24 in =
the
IPMB proto spec. I2C slave support implemented in AMI/Emerson firmware
doesn't work in such way =E2=80=93=C2=A0slave read after master write i=
mplemented right in
the kernel module as an ioctl (it is atomic operation from the software=
 perspective).
It's like a usual read/write, but read implemented as slave read.
There is no way to switch mux and request to BMC #2. Logically, this sh=
ouldn't
happen too.

Search for I2C_SLAVE_RDWR in

   https://raw.githubusercontent.com/facebook/openbmc/master/meta-aspee=
d/recipes-kernel/linux/files/patch-2.6.28.9/0000-linux-aspeed-064.patch

for slave implementation details. Attn! it's a 1.4MB file.

>
> Is it common in IPMI world to use muxes for this case?

It's not a common, but not restricted while MUX master (RMC side) is lo=
gically
Master while BMC is usually passive (logically Slaves) and do not initi=
ate IPMB
requests on their own behalf. Only requests for I2C slave devices on ot=
her busses
such as sensors. One exception is a communication with Intel ME.
Intel ME acts as a Master on I2C, but there is no muxes between in any =
kind of
HW design. Thus this bus is in Multi-Master mode permanently.
