From: Federico Fuga <fuga@studiofuga.com>
Subject: Re: [PATCH] i2c: mv64xxx: Implement I2C_M_RECV_LEN and
 I2C_FUNC_SMBUS_READ_BLOCK_DATA
Date: Fri, 13 Mar 2020 21:58:03 +0100
Message-ID: <D320E497-D240-4821-99F7-D0BE8744D3EF@studiofuga.com>
References: <20200118115820.9080-1-fuga@studiofuga.com>
 <20200222124805.GJ1716@kunai> <87k13ox9q1.fsf@FE-laptop>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87k13ox9q1.fsf@FE-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hello all,



> Il giorno 13 mar 2020, alle ore 21:48, Gregory CLEMENT =
<gregory.clement@bootlin.com> ha scritto:
>=20
> Hello Wolfram,
>=20
>> On Sat, Jan 18, 2020 at 12:58:20PM +0100, Federico Fuga wrote:
>>> The i2c_mv64xxx driver doesn't implement the I2C_M_REC_LEN function
>>> essential to allow blocks with variable length to be read from an =
i2c
>>> slave.
>>> This is needed to implement the SMBus Read Block Data function.
>>>=20
>>> This patch implements the function by changing the bytes_left and
>>> msg len on the fly if the flag is specified.
>>>=20
>>> It has been successfully tested on Allwinner A33 with a special
>>> i2c chip that returns variable length blocks on reading.
>>>=20
>>> Signed-off-by: Federico Fuga <fuga@studiofuga.com>
>>> ---
>>=20
>> Gregory, any comment? I can't say much about the implementation. In
>> general, this is a nice feature to have...
>=20
> I thought I was already sent a reviewed by, as I reviewed this patch
> before Frederico actually sent it.
>=20
> So you can even add a
>=20
> Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>=20
> Thanks,


For what it worth, I can confirm that after many weeks of use the patch =
works as expected without any issue.


Federico
