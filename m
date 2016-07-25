From: Kachalov Anton <mouse@mayc.ru>
Subject: Re: i2c: slave support framework improvements
Date: Mon, 25 Jul 2016 10:47:17 +0300
Message-ID: <354241469432837@web19h.yandex.ru>
References: <137031469256709@web4j.yandex.ru>
	 <20160723195114.GA2104@katana>
	 <27421469430128@web19h.yandex.ru> <20160725072151.GA1599@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from forward4h.cmail.yandex.net ([87.250.230.19]:49701 "EHLO
	forward4h.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751127AbcGYHrU (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 25 Jul 2016 03:47:20 -0400
In-Reply-To: <20160725072151.GA1599@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>



25.07.2016, 10:22, "Wolfram Sang" <wsa@the-dreams.de>:
>> =C2=A0> How do the other masters know that their channel is currentl=
y muxed
>> =C2=A0> then? And what if two of them want to access two of your sla=
ves at
>> =C2=A0> the same time?
>>
>> =C2=A0In current implementation this I2C switch might be only switch=
ed from
>> =C2=A0one side (via i2c command). From the MUX point of view, there =
is only
>> =C2=A0one master (which may mux) and a number of slaves behind each =
channel.
>> =C2=A0But on proto level IPMB requires to act as multi-master to rec=
eive
>> =C2=A0answers from other intelligent nodes. To receive answer reques=
ting
>> =C2=A0node have to switch to slave mode after master write request.
>
> And how is guaranteed that one of the intelligent nodes behind the MU=
X
> do no send requests on their own while their channel is not muxed?

The MUX has been driven by high-level (logically) Master. RMC (Rack man=
agement controller) switches MUX to talk to slaves (BMC) of each node. =
There is guaranteed that BMC wouldn't act as Master (logically), but th=
e line is muxed until timeout or answer received by RMC. BMCs are passi=
ve and only responds to requests. But regarding to the IPMB proto spec,=
 every response have to be made as Master.
