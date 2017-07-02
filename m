From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Subject: Re: [PATCH 5/6] i2c: pca-platform: use device_property_read_u32
Date: Sun, 2 Jul 2017 21:51:44 +0000
Message-ID: <942893991cc34410bf1515a6a970c5c2@svr-chch-ex1.atlnz.lc>
References: <20170630005408.23968-1-chris.packham@alliedtelesis.co.nz>
 <20170630005408.23968-6-chris.packham@alliedtelesis.co.nz>
 <CAHp75Vc+6WGFiJifEExjv3jSFsy+ORGtRoDPmv31sSFN=zkHMg@mail.gmail.com>
 <20170630090354.6s6ahpjhis7ptbfg@ninjato>
 <CAHp75Ve1daNFe4PLAMpqMudE9d+Ss2JpeZ=Sy5x5ij99gAVs_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-SH <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 30/06/17 22:56, Andy Shevchenko wrote:=0A=
> On Fri, Jun 30, 2017 at 12:03 PM, Wolfram Sang <wsa@the-dreams.de> wrote:=
=0A=
>>=0A=
>>>> -               i2c->algo_data.i2c_clock =3D 59000;=0A=
>>>> +               ret =3D device_property_read_u32(&pdev->dev, "clock-fr=
equency",=0A=
>>>> +                                              &i2c->algo_data.i2c_clo=
ck);=0A=
>>>> +               if (ret)=0A=
>>>> +                       i2c->algo_data.i2c_clock =3D 59000;=0A=
>>>=0A=
>>> My idea is to get rid of legacy platform data completely.=0A=
>>> That's why I suggested device_* in the first place.=0A=
>>>=0A=
>>> In similar way like you did with GPIO lookup table, you may use=0A=
>>> PROPERTY_ENTRY*() macros in the board files.=0A=
>>>=0A=
>>> Does it make sense?=0A=
>>=0A=
>> Frankly, I am not a big fan of converting board files if we cannot test=
=0A=
>> the changes.=0A=
> =0A=
> So, if no one is using that old boards, should we really take care=0A=
> more than just compile test?=0A=
> =0A=
> P.S. Legacy platform data makes a burden of development nowadays.=0A=
> Built-in device properties API (as a part of Unified Device=0A=
> Properties) is exactly for getting rid of legacy stuff and make things=0A=
> much cleaner.=0A=
=0A=
We could probably go with an approach of making the device properties =0A=
the default which would suit the new style and leave the platform_data =0A=
to override things if it is present.=0A=
=0A=
If/when the older platforms go away we can drop struct =0A=
i2c_pca9564_pf_platform_data.=0A=
=0A=
