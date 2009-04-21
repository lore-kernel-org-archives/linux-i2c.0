From: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Subject: Re: [PATCH] i2c-cpm: Pass dev ptr to dma_*_coherent rather than NULL
Date: Tue, 21 Apr 2009 15:32:52 +0200
Message-ID: <49EDCB04.9030800@scram.de>
References: <49EDC0BE.7040505@elphinstone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49EDC0BE.7040505-kb99s61Wg94xnpGSZB1jBA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Ware <mware-kb99s61Wg94xnpGSZB1jBA@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Mark Ware schrieb:
> Recent DMA changes result in a BUG() when NULL is passed to
> dma_alloc_coherent in place of a device.

This seems to have happened in 4ae0ff606e848fa4957ebf8f97e5db5fdeec27be.

> Signed-off-by: Mark Ware <mware-kb99s61Wg94xnpGSZB1jBA@public.gmane.org>
Acked-by: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>

Thanks,
Jochen
