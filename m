From: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] i2c-cpm: Pass dev ptr to dma_*_coherent rather than NULL
Date: Tue, 21 Apr 2009 10:11:51 -0500
Message-ID: <E2205842-8019-4CE4-812B-64ABD76F36F4@kernel.crashing.org>
References: <49EDC0BE.7040505@elphinstone.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49EDC0BE.7040505-kb99s61Wg94xnpGSZB1jBA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Linuxppc-dev Development <linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Ware <mware-kb99s61Wg94xnpGSZB1jBA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


On Apr 21, 2009, at 7:49 AM, Mark Ware wrote:

> Recent DMA changes result in a BUG() when NULL is passed to
> dma_alloc_coherent in place of a device.
>
> Signed-off-by: Mark Ware <mware-kb99s61Wg94xnpGSZB1jBA@public.gmane.org>
> ---
>
> This patch fixes the BUG() during boot that has appeared during the
> 2.6.30 window. It has been tested and appears correct on my 8280 based
> board.
> Sent to both linuxppc-dev and linux-i2c, since I'm not sure where it  
> belongs.
>
>
> drivers/i2c/busses/i2c-cpm.c |   14 ++++++++------
> 1 files changed, 8 insertions(+), 6 deletions(-)

Acked-by: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>

Ben, I'm expecting you to pick this up unless you tell me otherwise.

- k
