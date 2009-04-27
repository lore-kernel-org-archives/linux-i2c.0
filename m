From: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: Re: pxa i2c unit busy caused unrecoverable phone hang problem
Date: Mon, 27 Apr 2009 13:33:37 +0300
Message-ID: <49F58A01.6060401@compulab.co.il>
References: <fd6b62c10904270057w610239dflfd228f949c0649b2@mail.gmail.com> <20090427120810.20af38b8@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090427120810.20af38b8-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?5LyK5rO9?= <wxc200-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



Jean Delvare wrote:
> On Mon, 27 Apr 2009 15:57:45 +0800, =E4=BC=8A=E6=B3=BD wrote:
>> We use Marvell's pxaXXX chip,and the i2c unit often become BUSY stat=
us .As
>> normal operation,the Unit-Busy will become free quickly,but sometime=
s
>> UNIT-BUSY forever.For there are very frequent i2c operations,the cel=
l-phone
>> become hang soon,nothing could be done but remove the battery and re=
boot.
>>
>> So could you give a suggestion?  Is there any useful way to protect =
from
>> entering this abnormal UNIT-BUSY i2c status or recover from that?

PXA I2C controller often reports BUSY when one of the I2C lines are hel=
d low.
Verify you have proper pull-ups and that devices connected to I2C bus b=
ehave in
a sane way.

> I don't know anything about PXA platforms, there's nothing I can do f=
or
> you, sorry.
>=20

--=20
Sincerely yours,
Mike.
