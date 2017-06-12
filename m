From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] i2c: ismt: fix wrong device address when unmap the data buffer
Date: Mon, 12 Jun 2017 12:42:35 +0300
Message-ID: <CAHp75VdTrQdg=mKzfYin815Rp=+5-Huj+jyU4foPpJCPsQL81Q@mail.gmail.com>
References: <1497238928-41066-1-git-send-email-liwei.song@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35223 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752158AbdFLJmg (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 12 Jun 2017 05:42:36 -0400
In-Reply-To: <1497238928-41066-1-git-send-email-liwei.song@windriver.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Song liwei <liwei.song@windriver.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>, linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Mon, Jun 12, 2017 at 6:42 AM, Song liwei <liwei.song@windriver.com> wrote:
> From: Liwei Song <liwei.song@windriver.com>

Btw, it seems it has to include Fixes tag.

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
