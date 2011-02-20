From: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] i2c: tegra: Add i2c support
Date: Sun, 20 Feb 2011 11:51:46 -0800
Message-ID: <AANLkTik6nbM55_tC3Z5_9LcM1DZuu_=EFLX6178AMO2e@mail.gmail.com>
References: <1297169061-17689-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4D5B10E3.5030208@fluff.org>
	<74CDBE0F657A3D45AFBB94109FB122FF03112A5345@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF03112A5345-C7FfzLzN0UxDw2glCA4ptUEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Feb 16, 2011 at 9:37 AM, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wr=
ote:
> On 08/02/11 12:44, Mark Brown wrote:
>> ...
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_iounmap;
>> + =A0 =A0 }
>> + =A0 =A0 irq =3D res->start;
>> +
>> + =A0 =A0 clk =3D clk_get(&pdev->dev, NULL);
>> + =A0 =A0 if (!clk) {
>
> This should be:
>
> if (!IS_ERR(clk)) {
Just if (IS_ERR(clk))

>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>
> This should probably be:
>
> ret =3D PTR_ERR(clk);
Yes

> although Ben made some comments in his review re: certain error codes=
 being
> ignored by the higher layers; I'm not sure if that applies here or no=
t.
The clkdev clk_get implementation returns -ENOENT, so it should be OK.

>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_release_region;
>> + =A0 =A0 }
>> +
>
> --
> nvpublic
>
>
