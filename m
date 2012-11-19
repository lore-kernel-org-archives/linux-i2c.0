From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: mxs: Do not disable the I2C SMBus quick mode
Date: Mon, 19 Nov 2012 16:19:59 +0100
Message-ID: <201211191619.59877.marex@denx.de>
References: <1353216308-7338-1-git-send-email-marex@denx.de> <1353216308-7338-2-git-send-email-marex@denx.de> <CANqk_c-3t2Kn3cQjwzoSzMrKMD-W_0JByD4U=Bp_ZA3_seyuig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANqk_c-3t2Kn3cQjwzoSzMrKMD-W_0JByD4U=Bp_ZA3_seyuig-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Michals <tcmichals-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Tim Michals,

> Mr. Marek Vasut,

Ugh, I feel so old ;-D

[...]

> diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
> index 286ca19..0670da7 100644
> --- a/drivers/i2c/busses/i2c-mxs.c
> +++ b/drivers/i2c/busses/i2c-mxs.c
> @@ -287,12 +287,14 @@ read_init_dma_fail:
>  select_init_dma_fail:
>         dma_unmap_sg(i2c->dev, &i2c->sg_io[0], 1, DMA_TO_DEVICE);
>  select_init_pio_fail:
> +       dmaengine_terminate_all(i2c->dmach);
>         return -EINVAL;
> 
>  /* Write failpath. */
>  write_init_dma_fail:
>         dma_unmap_sg(i2c->dev, i2c->sg_io, 2, DMA_TO_DEVICE);
>  write_init_pio_fail:
> +       dmaengine_terminate_all(i2c->dmach);
>         return -EINVAL;
>  }
> 
> I tested both patches using Linux version 3.7.0-rc4 with the following
> command:

Did you test it on mx28 or on mx23? I tested it on mx28 with i2cdetect -y 0 and 
it worked.

> #  i2cdetect -r 0 20 30
[...]

Attaching my results on MX28 (and note, I also attach dmesg and I re-ran the 
test to proove it's replicable -- aka. the DMA engine doesn't stall).

~ # /i2cdetect.static -r 0 20 30
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0 using read byte commands.
I will probe address range 0x14-0x1e.
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:                                                 
10:             -- -- -- -- -- -- -- -- -- -- --    
20:                                                 
30:                                                 
40:                                                 
50:                                                 
60:                                                 
70:                                                 
~ # dmesg | tail -n 12
[    6.960000] Freeing init memory: 1348K
[   29.500000] mxs-dma 80024000.dma-apbx: mxs_dma_int_handler: error in channel 
6
[   29.500000] mxs-dma 80024000.dma-apbx: mxs_dma_int_handler: error in channel 
6
[   29.500000] mxs-dma 80024000.dma-apbx: mxs_dma_int_handler: error in channel 
6
[   29.500000] mxs-dma 80024000.dma-apbx: mxs_dma_int_handler: error in channel 
6
[   29.500000] mxs-dma 80024000.dma-apbx: mxs_dma_int_handler: error in channel 
6
[   29.500000] mxs-dma 80024000.dma-apbx: mxs_dma_int_handler: error in channel 
6
[   29.500000] mxs-dma 80024000.dma-apbx: mxs_dma_int_handler: error in channel 
6
[   29.500000] mxs-dma 80024000.dma-apbx: mxs_dma_int_handler: error in channel 
6
[   29.500000] mxs-dma 80024000.dma-apbx: mxs_dma_int_handler: error in channel 
6
[   29.500000] mxs-dma 80024000.dma-apbx: mxs_dma_int_handler: error in channel 
6
[   29.500000] mxs-dma 80024000.dma-apbx: mxs_dma_int_handler: error in channel 
6
~ # /i2cdetect.static -r 0 20 30
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0 using read byte commands.
I will probe address range 0x14-0x1e.
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:                                                 
10:             -- -- -- -- -- -- -- -- -- -- --    
20:                                                 
30:                                                 
40:                                                 
50:                                                 
60:                                                 
70:

Best regards,
Marek Vasut
