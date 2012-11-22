From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: Add PIO and mixed-DMA support
Date: Thu, 22 Nov 2012 01:50:37 +0100
Message-ID: <201211220150.37462.marex@denx.de>
References: <1353477088-9660-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1353477088-9660-1-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Marek Vasut,

> Add support for the PIO mode and mixed PIO/DMA mode support. The mixed
> PIO/DMA is the default mode of operation. This shall leverage overhead
> that the driver creates due to setting up DMA descriptors even for very
> short transfers.
> 
> The current boundary between PIO/DMA 8 bytes, transfers shorter than 8
> bytes are transfered by PIO, longer transfers use DMA. The performance
> of write transfers remains unchanged, while there is a minor improvement
> of read performance. Reading 16KB EEPROM with DMA-only operations gives
> a read speed of 39.5KB/s, while with then new mixed-mode the speed is
> blazing 40.6KB/s.
> 
> Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
[...]

btw. Wolfram, you might want to drop me some credit into the MX28 i2c driver, I 
suspect most of the code in there is mine now anyway :-D

Best regards,
Marek Vasut
