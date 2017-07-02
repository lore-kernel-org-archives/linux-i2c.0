From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Subject: Re: [PATCH 3/6] i2c: pca-platform: propagate error from
 i2c_pca_add_numbered_bus
Date: Sun, 2 Jul 2017 21:30:30 +0000
Message-ID: <785fd906ff2b47d9a6fa6899f9cabe6d@svr-chch-ex1.atlnz.lc>
References: <20170630005408.23968-1-chris.packham@alliedtelesis.co.nz>
 <20170630005408.23968-4-chris.packham@alliedtelesis.co.nz>
 <CAHp75VejpMcgsyncpbFnDXbwYcwdD1BPqy53s98xcNmfAnJTFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-sh-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-SH <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 30/06/17 20:40, Andy Shevchenko wrote:=0A=
> On Fri, Jun 30, 2017 at 3:54 AM, Chris Packham=0A=
> <chris.packham@alliedtelesis.co.nz> wrote:=0A=
>> Rather than returning -ENODEV if i2c_pca_add_numbered_bus() fails,=0A=
>> propagate the error to aid debugging.=0A=
>>=0A=
> =0A=
> + Suggested-by ?=0A=
> =0A=
> You or Wolfram can use below if you agree on it (I'm fine either way):=0A=
> =0A=
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>=0A=
> =0A=
=0A=
I'll include it (and the Reviewed-by) in v2 if there is one.=0A=
=0A=
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
> =0A=
>> ---=0A=
>>   drivers/i2c/busses/i2c-pca-platform.c | 6 +++---=0A=
>>   1 file changed, 3 insertions(+), 3 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/=
i2c-pca-platform.c=0A=
>> index daccef6865e8..853a2abedb05 100644=0A=
>> --- a/drivers/i2c/busses/i2c-pca-platform.c=0A=
>> +++ b/drivers/i2c/busses/i2c-pca-platform.c=0A=
>> @@ -232,9 +232,9 @@ static int i2c_pca_pf_probe(struct platform_device *=
pdev)=0A=
>>                          return ret;=0A=
>>          }=0A=
>>=0A=
>> -       if (i2c_pca_add_numbered_bus(&i2c->adap) < 0) {=0A=
>> -               return -ENODEV;=0A=
>> -       }=0A=
>> +       ret =3D i2c_pca_add_numbered_bus(&i2c->adap);=0A=
>> +       if (ret)=0A=
>> +               return ret;=0A=
>>=0A=
>>          platform_set_drvdata(pdev, i2c);=0A=
>>=0A=
>> --=0A=
>> 2.13.0=0A=
>>=0A=
> =0A=
> =0A=
> =0A=
=0A=
