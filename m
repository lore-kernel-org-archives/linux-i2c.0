From: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH] i2c: rk3x: fix some typo
Date: Fri, 2 Nov 2018 00:18:46 +0800
Message-ID: <CAEExFWsO=piLg_JCCKTH6p49f+RT8qDzii6iwjHuTcwd8j0Okw@mail.gmail.com>
References: <20181101153749.22935-1-tiny.windzz@gmail.com> <5544442.bXqbKBZQMR@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5544442.bXqbKBZQMR@diego>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

>Hi,
>
>Am Donnerstag, 1. November 2018, 16:37:49 CET schrieb Yangtao Li:
>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>
>while the changes really are pretty self-explanatory, it is always
>nice to describe changes in a real commit message, like
>
>Fix multiple instances of a misspelled "Calculates".
>
>Change itself looks good, so
>Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>
>
>Thanks

Yeah,this is my fault.

--Yangtao Li
On Thu, Nov 1, 2018 at 11:56 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi,
>
> Am Donnerstag, 1. November 2018, 16:37:49 CET schrieb Yangtao Li:
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>
> while the changes really are pretty self-explanatory, it is always
> nice to describe changes in a real commit message, like
>
> Fix multiple instances of a misspelled "Calculates".
>
> Change itself looks good, so
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>
>
> Thanks
> Heiko
>
> > ---
> >  drivers/i2c/busses/i2c-rk3x.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3=
x.c
> > index b8a2728dd4b6..fe347e8e2a23 100644
> > --- a/drivers/i2c/busses/i2c-rk3x.c
> > +++ b/drivers/i2c/busses/i2c-rk3x.c
> > @@ -555,7 +555,7 @@ static const struct i2c_spec_values
> > *rk3x_i2c_get_spec(unsigned int speed) *
> >   * @clk_rate: I2C input clock rate
> >   * @t: Known I2C timing information
> > - * @t_calc: Caculated rk3x private timings that would be written into =
regs
> > + * @t_calc: Calculated rk3x private timings that would be written into=
 regs
> > *
> >   * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In=
 that
> > case * a best-effort divider value is returned in divs. If the target r=
ate
> > is @@ -716,7 +716,7 @@ static int rk3x_i2c_v0_calc_timings(unsigned lon=
g
> > clk_rate, *
> >   * @clk_rate: I2C input clock rate
> >   * @t: Known I2C timing information
> > - * @t_calc: Caculated rk3x private timings that would be written into =
regs
> > + * @t_calc: Calculated rk3x private timings that would be written into=
 regs
> > *
> >   * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In=
 that
> > case * a best-effort divider value is returned in divs. If the target r=
ate
> > is
>
>
>
>
