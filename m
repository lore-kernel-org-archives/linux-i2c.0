From: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Subject: Re: Fwd: [PATCH 1/7] I2c-nomadik: Fix the usage of
 wait_for_completion_timeout
Date: Thu, 15 Nov 2012 14:19:00 +0530
Message-ID: <20121115084858.GA29668@bnru10>
References: <1352222317.15558.1584.camel@cliu38-desktop-build>
 <CACRpkdYekQF5111NSNSPeaHdxgS_gpXkCjqT1n-n1_iAdDXbSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYekQF5111NSNSPeaHdxgS_gpXkCjqT1n-n1_iAdDXbSg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: chuansheng.liu@intel.com, w.sang@pengutronix.de
Cc: linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

[...]

> From: Chuansheng Liu <chuansheng.liu@intel.com>
> Date: Tue, Nov 6, 2012 at 6:18 PM
> Subject: [PATCH 1/7] I2c-nomadik: Fix the usage of wait_for_completion_timeout
> To: linus.walleij@linaro.org, w.sang@pengutronix.de
> Cc: linux-arm-kernel@lists.infradead.org,
> linux-kernel@vger.kernel.org, chuansheng.liu@intel.com
> 
> 
> 
> The return value of wait_for_completion_timeout() is always
> >= 0 with unsigned int type.
> 
> So the condition "ret < 0" or "ret >= 0" is pointless.
> 
> Signed-off-by: liu chuansheng <chuansheng.liu@intel.com>
> ---
>  drivers/i2c/busses/i2c-nomadik.c |   14 --------------
>  1 files changed, 0 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
> index 02c3115..8b2ffcf 100644
> --- a/drivers/i2c/busses/i2c-nomadik.c
> +++ b/drivers/i2c/busses/i2c-nomadik.c
> @@ -435,13 +435,6 @@ static int read_i2c(struct nmk_i2c_dev *dev, u16 flags)
>         timeout = wait_for_completion_timeout(
>                 &dev->xfer_complete, dev->adap.timeout);
> 
> -       if (timeout < 0) {
> -               dev_err(&dev->adev->dev,
> -                       "wait_for_completion_timeout "
> -                       "returned %d waiting for event\n", timeout);
> -               status = timeout;
> -       }
> -
No, it is wrong. You need to update the status variable in the case of timeout.
It is used further in nmk_i2c_xfer_one. You could perhaps use

if (timeout == 0) {
 ...and the rest of the code as is
}

regards/srinidhi
