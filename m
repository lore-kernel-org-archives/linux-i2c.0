From: "Huang, Tao" <huangtao@rock-chips.com>
Subject: Re: [PATCH] i2c: rk3x: init module as subsys call
Date: Tue, 5 Jan 2016 16:48:59 +0800
Message-ID: <568B837B.50607@rock-chips.com>
References: <1451962938-17398-1-git-send-email-jay.xu@rock-chips.com>
 <2513923.8oltbpbAin@phil> <568B73E8.3010901@rock-chips.com>
 <7893052.zgDX0r4i77@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.134]:46670 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbcAEItS (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 5 Jan 2016 03:49:18 -0500
In-Reply-To: <7893052.zgDX0r4i77@phil>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: "jianqun.xu" <jay.xu@rock-chips.com>, wsa@the-dreams.de, wdc@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hi, Heiko:

On 2016=E5=B9=B401=E6=9C=8805=E6=97=A5 16:00, Heiko Stuebner wrote:
> Hi Tao,
>=20
> Am Dienstag, 5. Januar 2016, 15:42:32 schrieb Huang, Tao:

>> I don't think this is a good idea. This will trigger a lots of init =
call
>> failed. Before pmic init, all i2c device driver transmit will failed=
,
>> and because i2c is slow bus, and i2c transmit may failed by other
>> reasons, so the i2c driver and i2c device driver will try many times=
 to
>> make sure the transmit completion. These unnecessary transmission wi=
ll
>> make Linux boot very slow.
>=20
> In general, the slowdown won't be _this_ much if touchscreen drivers =
need=20
> one deferral-round before i2c is available. I'm also only pointing ou=
t=20
> things I remember from the last time this came up.=20
>=20
> rk3x-i2c even was here already:
> http://www.spinics.net/lists/linux-i2c/msg16680.html

OK. I don't agree with the rule, but we will follow it.

>=20
>=20
>> I2C bus should be subsys, and we can easy resolve this problem, why =
we
>> depends on a complicated and slow implementation?
>=20
> because it's the only safe way to do that. Because now you need i2c-i=
nit at=20
> subsys-init time, some months later some other soc may need some othe=
r=20
> ordering, especially needing i2c-init later/earlier.
>=20
> Going through the deferral mechanism is the only way currently availa=
ble to=20
> actually make this work on all socs.
>=20
> Tomeu from Collabora is working on some better scheme to optimize dev=
ice=20
> probing order but it looks like this may be a bit off still.
>=20
>=20
>>> Your touchscreen will have a "xyz-supply" property and I think the
>>> regulator-framework should already emit a -EPROBE_DEFER at
>>> regulator_get,
>>> when the regulator is specified but not available yet.
>>
>> Unfortunately, mostly driver do not support regulator api. They are
>> suppose power is on.
>=20
> Having touchscreen drivers support its proper supply-regulators is no=
t=20
> rocket science ;-) [0] , so I would consider this a bug in the touchs=
creen=20
> driver itself.

I don't just talk about touch screen driver, most i2c device driver suc=
h
as input sensor/camera/rtc/battery will suffer. So people will see thei=
r
drivers do not work or slow down on rk3368 platform :(

Thanks!
Huang, Tao
