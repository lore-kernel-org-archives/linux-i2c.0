From: addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: About RK3288 i2c scl duty cycle
Date: Thu, 18 Sep 2014 09:26:27 +0800
Message-ID: <541A34C3.6000400@rock-chips.com>
References: <2014091709302172205233@rock-chips.com> <CAD=FV=VEUVxxZ8ZP89qhSOmvX_LgMvnczNx17qdMTGCapZj3uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAD=FV=VEUVxxZ8ZP89qhSOmvX_LgMvnczNx17qdMTGCapZj3uw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
Cc: max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.orglinux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Add public list

On 2014/9/17 23:17, Doug Anderson wrote:
> Addy,
>=20
> On Tue, Sep 16, 2014 at 6:30 PM, addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org
> <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
>> hi, all
>=20
> Any reason why you didn't add some public lists?  It seems like this
> is a perfect discussion for linux-i2c.
>=20
>=20
>> According to i2c-bus specification(version2.1, page 32, Table5, FAST=
-MODE):
>> The minimum LOW period of the scl clock is <1.3us>, and the minimum =
HIGH
>> period of the scl clock is <0.6us>.
>> T(min_low) : T(min_high)  ~=3D 2 : 1
>>
>> If <DIVH =3D DIVL> in fast mode(scl rate =3D 400Khz)
>> 1=EF=BC=89Under ideal conditions, T(scl_low) =3D T(scl_high) =3D <1.=
25us>
>> 2=EF=BC=89Our measurement, T(scl_low) =3D <1.3us>, T(scl_high) =3D <=
1.25us>
>>
>> The low period of the scl clock is critical.
>>
>> Do we need set <DIVL:DIVH =3D 1 : 2>  to increase T(scl_low)?   // T=
(scl_low )
>> : T(scl_High) =3D 2 : 1
>=20
> I can't say I've ever looked at that pat of the i2c spec before, but
> what you say seems reasonable to me.  ...well for 400kHz, at least.
> At 100kHz you shouldn't use the same 2:1 ratio.

Yes, in normal-mode(100K) we can be only used 1:1 ratio.
But in FAST-MODE maybe we must use 2:1 ratio.
----
In Table 5(Characteristics of the SDA and SCL bus lines for F/S-mode I2=
C-bus devices)

1)FAST-MODE(400K):
  The minimum LOW period of the scl clock                1.3us
  the minimum HIGH period of the scl clock               0.6us
  T(min_low) : T(min_high)  ~=3D 2 : 1

  But I can't see any ratio about In FAST-mode(400k) and Normal-mode(10=
0k).
2)Normal-MODE(100K):
  The minimum LOW period of the scl clock                4.7us
  the minimum HIGH period of the scl clock               4.0us
  T(min_low) : T(min_high)  ~=3D 1 : 1

3) HS-mode(3.4M)
  ratio of 1 to 2 is required, decribed as follows:
  Hs-mode master devices generate a serial clock signal with a HIGH to =
LOW ratio of 1 to 2
>=20
> I'm sure other drivers have solved this problem too, so maybe you can
> copy some code.  In i2c-designware-core.c you can see them doing all
> the calculations you need, I think.
>=20
>=20
> -Doug
>=20
>=20
>=20
