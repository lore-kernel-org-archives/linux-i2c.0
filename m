From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v2 0/4] i2c: pca-platform: additional improvements
Date: Wed, 5 Jul 2017 20:44:50 +0000
Message-ID: <6ff4113ecb49476081826306d7e7d9c9@svr-chch-ex1.atlnz.lc>
References: <20170705101358.17458-1-chris.packham@alliedtelesis.co.nz>
 <CAHp75VfKhTkBZfuDdp=hkZMkXyBmMdYwrSNLmO-PyBz==NtrRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-sh-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-i2c <linux-i2c@vger.kernel.org>, Linux-SH <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 05/07/17 23:49, Andy Shevchenko wrote:=0A=
> On Wed, Jul 5, 2017 at 1:13 PM, Chris Packham=0A=
> <chris.packham@alliedtelesis.co.nz> wrote:=0A=
>> This series addresses some of the points identified by Andy. The series =
is=0A=
>> based on top of i2c/for-next. 2 of the patches from v1 have already been=
=0A=
>> applied so I've dropped them from this version.=0A=
>>=0A=
>> I have compile tested patch 1/1 but I don't have access to sh hardware=
=0A=
>> to actually test the changes on.=0A=
> =0A=
> =0A=
> Entire series looks good to me:=0A=
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>=0A=
> =0A=
> Further improvement is to get timeout value via device properties API=0A=
> and get rid of legacy platform data completely. This can be done in=0A=
> further series.=0A=
=0A=
Actually the timeout can probably go now. The two in-tree platforms that =
=0A=
set it via platform_data set it to HZ which is (now) the default.=0A=
=0A=
> =0A=
>>=0A=
>> Chris Packham (4):=0A=
>>    sh: sh7785lcr: add GPIO lookup table for i2c controller reset=0A=
>>    i2c: pca-platform: unconditionally use devm_gpiod_get_optional=0A=
>>    i2c: pca-platform: use device_property_read_u32=0A=
>>    i2c: pca-platform: drop gpio from platform data=0A=
>>=0A=
>>   arch/blackfin/mach-bf561/boards/acvilon.c |  1 -=0A=
>>   arch/sh/boards/board-sh7785lcr.c          | 11 +++++++++-=0A=
>>   drivers/i2c/busses/i2c-pca-platform.c     | 34 +++++++++--------------=
--------=0A=
>>   include/linux/i2c-pca-platform.h          |  3 ---=0A=
>>   4 files changed, 20 insertions(+), 29 deletions(-)=0A=
>>=0A=
>> --=0A=
>> 2.13.0=0A=
>>=0A=
> =0A=
> =0A=
> =0A=
=0A=
