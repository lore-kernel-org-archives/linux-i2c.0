From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v3 2/5] i2c: pca-platform: switch to struct gpio_desc
Date: Wed, 28 Jun 2017 21:25:11 +0000
Message-ID: <0e28afa250a0440d9e84e38fdf547876@svr-chch-ex1.atlnz.lc>
References: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-3-chris.packham@alliedtelesis.co.nz>
 <CAHp75VeoJeq0Xjsu76gfZcpgULMO0krnETMwydx9C_4LbWdNXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:42460 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751655AbdF1VZQ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 28 Jun 2017 17:25:16 -0400
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 28/06/17 21:25, Andy Shevchenko wrote:=0A=
> On Mon, Jun 26, 2017 at 3:44 AM, Chris Packham=0A=
> <chris.packham@alliedtelesis.co.nz> wrote:=0A=
>> Make use of struct gpio_desc which allows us to specify the active state=
=0A=
>> of the reset pin.=0A=
> =0A=
>> +               if (gpio_is_valid(platform_data->gpio)) {=0A=
> =0A=
> No way, it should be provided by GPIO lookup table.=0A=
> =0A=
=0A=
Can do. The only platform that would be affected is =0A=
arch/sh/boards/board-sh7785lcr.c and the fact that it sets gpio =3D 0 =0A=
makes me think that this might be an error.=0A=
=0A=
>> +                       ret =3D devm_gpio_request_one(&pdev->dev,=0A=
>> +                                                   platform_data->gpio,=
=0A=
>> +                                                   GPIOF_ACTIVE_LOW,=0A=
>> +                                                   i2c->adap.name);=0A=
>> +                       if (ret =3D=3D 0) {=0A=
>> +                               i2c->gpio =3D gpio_to_desc(platform_data=
->gpio);=0A=
> =0A=
> This has to be devm_gpiod_get() instead.=0A=
=0A=
I can just make the devm_gpiod_get_optional() call I add in 3/5 =0A=
unconditional.=0A=
=0A=
> =0A=
> Wolfram, I suggested to drop the series for now and wait for improvements=
.=0A=
> =0A=
=0A=
Wolframs call. I don't mind either way. I can send a v4 or send a new =0A=
series on top of i2c.git#for-next.=0A=
