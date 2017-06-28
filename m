From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v3 4/5] i2c: pca-platform: use device managed allocations
Date: Wed, 28 Jun 2017 21:03:56 +0000
Message-ID: <451f994f23fc4ca195f577d1be302e8e@svr-chch-ex1.atlnz.lc>
References: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-5-chris.packham@alliedtelesis.co.nz>
 <CAHp75VfE=gCO3EDvadxar=qdnqMHKAZg2TSvXBtYebx+Y_agEw@mail.gmail.com>
 <20170628093844.vmstyotgjaotbsnh@ninjato>
 <CAHp75VdykSnkyOpaAkaubnS+s32XW10ZHOYk2SRr6ORsYV7y_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:42323 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbdF1VEB (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 28 Jun 2017 17:04:01 -0400
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Rob Herring <robh+dt@kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 28/06/17 22:54, Andy Shevchenko wrote:=0A=
> On Wed, Jun 28, 2017 at 12:38 PM, Wolfram Sang <wsa@the-dreams.de> wrote:=
=0A=
>>=0A=
>>>>          if (i2c_pca_add_numbered_bus(&i2c->adap) < 0) {=0A=
>>>> -               ret =3D -ENODEV;=0A=
>>>> -               goto e_adapt;=0A=
>>>> +               return -ENODEV;=0A=
>>>=0A=
>>> This is still shadows the actual error code.=0A=
>>=0A=
>> Nice catch. But since it fixes a seperate issue, I'd prefer an=0A=
>> incremental change here.=0A=
> =0A=
> Agreed.=0A=
> =0A=
=0A=
OK I can send another patch for that.=0A=
