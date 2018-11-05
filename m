From: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH v2] i2c: rk3x: fix some typo
Date: Mon, 5 Nov 2018 23:59:58 +0800
Message-ID: <CAEExFWtQrPD8hUn15Add-EuueCL5=Crb+yvDckWejG75BExGug@mail.gmail.com>
References: <20181102124535.24331-1-tiny.windzz@gmail.com> <19a28033-9241-1f4e-97cd-7c6648a73c6d@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <19a28033-9241-1f4e-97cd-7c6648a73c6d@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: peda@axentia.se
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

I am sorry.
-- Yangtao
On Fri, Nov 2, 2018 at 8:58 PM Peter Rosin <peda@axentia.se> wrote:
>
> On 2018-11-02 13:45, Yangtao Li wrote:
> > Fix multiple instances of a misspelled "Calculates".
>
> Yes, it sure is hard to spell "Calcluated," it's almost impossible to
> get it completely right and not introduce another typo somewhere... :-)
>
> Cheers,
> Peter
>
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > Changes in v2:
> > -add commit message
> > ---
> >  drivers/i2c/busses/i2c-rk3x.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> > index b8a2728dd4b6..fe347e8e2a23 100644
> > --- a/drivers/i2c/busses/i2c-rk3x.c
> > +++ b/drivers/i2c/busses/i2c-rk3x.c
> > @@ -555,7 +555,7 @@ static const struct i2c_spec_values *rk3x_i2c_get_spec(unsigned int speed)
> >   *
> >   * @clk_rate: I2C input clock rate
> >   * @t: Known I2C timing information
> > - * @t_calc: Caculated rk3x private timings that would be written into regs
> > + * @t_calc: Calculated rk3x private timings that would be written into regs
> >   *
> >   * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In that case
> >   * a best-effort divider value is returned in divs. If the target rate is
> > @@ -716,7 +716,7 @@ static int rk3x_i2c_v0_calc_timings(unsigned long clk_rate,
> >   *
> >   * @clk_rate: I2C input clock rate
> >   * @t: Known I2C timing information
> > - * @t_calc: Caculated rk3x private timings that would be written into regs
> > + * @t_calc: Calculated rk3x private timings that would be written into regs
> >   *
> >   * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In that case
> >   * a best-effort divider value is returned in divs. If the target rate is
> >
>
