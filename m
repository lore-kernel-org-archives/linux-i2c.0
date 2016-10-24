From: Hoan Tran <hotran@apm.com>
Subject: Re: [PATCH] i2c: xgene: Avoid dma_buffer overrun
Date: Mon, 24 Oct 2016 15:30:12 -0700
Message-ID: <CAFHUOYwShBTVdpH8pMvGr9c8u-Fv+Hd081+XsW-wej94YwiB+g@mail.gmail.com>
References: <1476119590-21489-1-git-send-email-hotran@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:39127 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753002AbcJXWaO (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 24 Oct 2016 18:30:14 -0400
Received: by mail-vk0-f42.google.com with SMTP id h85so4224927vkc.6
        for <linux-i2c@vger.kernel.org>; Mon, 24 Oct 2016 15:30:14 -0700 (PDT)
In-Reply-To: <1476119590-21489-1-git-send-email-hotran@apm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: lkml <linux-kernel@vger.kernel.org>, Phil Endecott <phil_gjouf_endecott@chezphil.org>, Loc Ho <lho@apm.com>, Tin Huynh <tnhuynh@apm.com>, patches <patches@apm.com>, Hoan Tran <hotran@apm.com>

On Mon, Oct 10, 2016 at 10:13 AM, Hoan Tran <hotran@apm.com> wrote:
> SMBus block command uses the first byte of buffer for the data length.
> The dma_buffer should be increased by 1 to avoid the overrun issue.
>
> Reported-by: Phil Endecott <phil_gjouf_endecott@chezphil.org>
> Signed-off-by: Hoan Tran <hotran@apm.com>
> ---
>  drivers/i2c/busses/i2c-xgene-slimpro.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-xgene-slimpro.c b/drivers/i2c/busses/i2c-xgene-slimpro.c
> index 4233f56..3c38029 100644
> --- a/drivers/i2c/busses/i2c-xgene-slimpro.c
> +++ b/drivers/i2c/busses/i2c-xgene-slimpro.c
> @@ -105,7 +105,7 @@ struct slimpro_i2c_dev {
>         struct mbox_chan *mbox_chan;
>         struct mbox_client mbox_client;
>         struct completion rd_complete;
> -       u8 dma_buffer[I2C_SMBUS_BLOCK_MAX];
> +       u8 dma_buffer[I2C_SMBUS_BLOCK_MAX + 1]; /* dma_buffer[0] is used for length */
>         u32 *resp_msg;
>  };
>
> --
> 1.9.1
>

Any comments on this patch.

Thanks
Hoan
