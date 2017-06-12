From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] i2c: ismt: fix wrong device address when unmap the data buffer
Date: Mon, 12 Jun 2017 12:11:37 +0300
Message-ID: <CAHp75VewOMddhFDYim1kBF1XpxZGbVA557wTpBg10LYewf2Otg@mail.gmail.com>
References: <1497238928-41066-1-git-send-email-liwei.song@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497238928-41066-1-git-send-email-liwei.song@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Song liwei <liwei.song@windriver.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>, linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 12, 2017 at 6:42 AM, Song liwei <liwei.song@windriver.com> wrote:
> From: Liwei Song <liwei.song@windriver.com>
>

> Fix the following calltrace:

No, you don't fix a call trace, you are fixing a bug.

> This happen When run "i2cdetect -y 0" detect SMBus iSMT adapter.
>
> After finished I2C block read/write, when unmap the data buffer,
> a wrong device address was pass to dma_unmap_single(),


> the right
> device address should be "dev" not "&adap->dev", the relation is
> *(&adap->dev) == dev.

This is confusing. You are telling that there are two copies of struct
device here?
Otherwise if one is a pointer to the real struct device, there
shouldn't be a problem.

>  When come into Intel IOMMU routine, the wrong
> devices address was operated.

This basically duplicates what you have said previously.

> To fix this, give dma_unmap_single() the "dev" parameter, just like
> what dma_map_single() does, then unmap can find the right devices.

Fix per se looks good, explanation is confusing.

>
> Signed-off-by: Liwei Song <liwei.song@windriver.com>
> ---
>  drivers/i2c/busses/i2c-ismt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
> index 1db3e0d..605d44e 100644
> --- a/drivers/i2c/busses/i2c-ismt.c
> +++ b/drivers/i2c/busses/i2c-ismt.c
> @@ -585,7 +585,7 @@ static int ismt_access(struct i2c_adapter *adap, u16 addr,
>
>         /* unmap the data buffer */
>         if (dma_size != 0)
> -               dma_unmap_single(&adap->dev, dma_addr, dma_size, dma_direction);
> +               dma_unmap_single(dev, dma_addr, dma_size, dma_direction);
>
>         if (unlikely(!time_left)) {
>                 dev_err(dev, "completion wait timed out\n");
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
