From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v3 3/5] i2c: pca-platform: add devicetree awareness
Date: Wed, 28 Jun 2017 21:15:15 +0000
Message-ID: <c6c326442a1347d7b45d4b1bcb325fca@svr-chch-ex1.atlnz.lc>
References: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-4-chris.packham@alliedtelesis.co.nz>
 <CAHp75VeFUZzj00i9oSSanudPVzd61XFRkQ9Uz72r05EqdHNdxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:42399 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751690AbdF1VPa (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 28 Jun 2017 17:15:30 -0400
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 28/06/17 21:20, Andy Shevchenko wrote:=0A=
>> +       i2c->adap.dev.of_node =3D np;=0A=
>> +       } else if (np) {=0A=
>> +               i2c->adap.timeout =3D HZ;=0A=
>> +               i2c->gpio =3D devm_gpiod_get_optional(&pdev->dev, "reset=
-gpios", GPIOD_OUT_LOW);=0A=
>> +               if (IS_ERR(i2c->gpio))=0A=
>> +                       return PTR_ERR(i2c->gpio);=0A=
>> +               of_property_read_u32_index(np, "clock-frequency", 0,=0A=
>> +                                          &i2c->algo_data.i2c_clock);=
=0A=
> And what prevents you to use device_property_read_*() here and get rid=0A=
> of OFstuff?=0A=
> =0A=
=0A=
Nothing particular. I think I just found more instances of parsing a =0A=
"clock-frequency" this way. Happy to change this.=0A=
=0A=
>> +#ifdef CONFIG_OF=0A=
> Better not to put it...=0A=
> =0A=
>> +               .of_match_table =3D of_match_ptr(i2c_pca_of_match_table)=
,=0A=
> ...and get rid of of_match_ptr().=0A=
=0A=
So what's the current best practice with this? I gather the intent is to =
=0A=
keep the kernel size down by only including the of_match tables on =0A=
platforms that actually use a device tree. There are just shy of 1000 =0A=
instances of of_match_ptr in the current tree (a handful of which are in =
=0A=
drivers/i2c). Have we now reached a point where there are more dt-aware =0A=
platforms than unaware ones?=0A=
=0A=
