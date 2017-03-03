From: Kamal Dasu <kdasu.kdev@gmail.com>
Subject: Re: [v2] i2c: brcmstb: Fix START and STOP conditions
Date: Thu, 2 Mar 2017 23:32:28 -0500
Message-ID: <CAC=U0a3NqXcMsE7p1xn2H1_-KQkbvgs0401hZ70v8P25SSkYUg@mail.gmail.com>
References: <20170303015503.1653-1-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36676 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbdCCH1o (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 3 Mar 2017 02:27:44 -0500
Received: by mail-qk0-f196.google.com with SMTP id n141so1347485qke.3
        for <linux-i2c@vger.kernel.org>; Thu, 02 Mar 2017 23:27:17 -0800 (PST)
In-Reply-To: <20170303015503.1653-1-jaedon.shin@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Florian Fainelli <f.fainelli@gmail.com>, bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org

On Thu, Mar 2, 2017 at 8:55 PM, Jaedon Shin <jaedon.shin@gmail.com> wrote:
> The BSC data buffers to send and receive data are each of size 32 bytes
> or 8 bytes 'xfersz' depending on SoC. The problem observed for all the
> combined message transfer was if length of data transfer was a multiple
> of 'xfersz' a repeated START was being transmitted by BSC driver. Fixed
> this by appropriately setting START/STOP conditions for such transfers.
>
> Fixes: dd1aa2524bc5 ("i2c: brcmstb: Add Broadcom settop SoC i2c controller driver")
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Acked-by: Kamal Dasu <kdasu.kdev@gmail.com>

> ---
>  drivers/i2c/busses/i2c-brcmstb.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
> index 0652281662a8..78792b4d6437 100644
> --- a/drivers/i2c/busses/i2c-brcmstb.c
> +++ b/drivers/i2c/busses/i2c-brcmstb.c
> @@ -465,6 +465,7 @@ static int brcmstb_i2c_xfer(struct i2c_adapter *adapter,
>         u8 *tmp_buf;
>         int len = 0;
>         int xfersz = brcmstb_i2c_get_xfersz(dev);
> +       u32 cond, cond_per_msg;
>
>         if (dev->is_suspended)
>                 return -EBUSY;
> @@ -481,10 +482,11 @@ static int brcmstb_i2c_xfer(struct i2c_adapter *adapter,
>                         pmsg->buf ? pmsg->buf[0] : '0', pmsg->len);
>
>                 if (i < (num - 1) && (msgs[i + 1].flags & I2C_M_NOSTART))
> -                       brcmstb_set_i2c_start_stop(dev, ~(COND_START_STOP));
> +                       cond = ~COND_START_STOP;
>                 else
> -                       brcmstb_set_i2c_start_stop(dev,
> -                                                  COND_RESTART | COND_NOSTOP);
> +                       cond = COND_RESTART | COND_NOSTOP;
> +
> +               brcmstb_set_i2c_start_stop(dev, cond);
>
>                 /* Send slave address */
>                 if (!(pmsg->flags & I2C_M_NOSTART)) {
> @@ -497,13 +499,24 @@ static int brcmstb_i2c_xfer(struct i2c_adapter *adapter,
>                         }
>                 }
>
> +               cond_per_msg = cond;
> +
>                 /* Perform data transfer */
>                 while (len) {
>                         bytes_to_xfer = min(len, xfersz);
>
> -                       if (len <= xfersz && i == (num - 1))
> -                               brcmstb_set_i2c_start_stop(dev,
> -                                                          ~(COND_START_STOP));
> +                       if (len <= xfersz) {
> +                               if (i == (num - 1))
> +                                       cond_per_msg = cond_per_msg &
> +                                               ~(COND_RESTART | COND_NOSTOP);
> +                               else
> +                                       cond_per_msg = cond;
> +                       } else {
> +                               cond_per_msg = (cond_per_msg & ~COND_RESTART) |
> +                                       COND_NOSTOP;
> +                       }
> +
> +                       brcmstb_set_i2c_start_stop(dev, cond_per_msg);
>
>                         rc = brcmstb_i2c_xfer_bsc_data(dev, tmp_buf,
>                                                        bytes_to_xfer, pmsg);
> @@ -512,6 +525,8 @@ static int brcmstb_i2c_xfer(struct i2c_adapter *adapter,
>
>                         len -=  bytes_to_xfer;
>                         tmp_buf += bytes_to_xfer;
> +
> +                       cond_per_msg = COND_NOSTART | COND_NOSTOP;
>                 }
>         }
>
> --
> 2.12.0
>
