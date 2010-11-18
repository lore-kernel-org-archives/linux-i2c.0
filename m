From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] dw_spi: add DMA support
Date: Thu, 18 Nov 2010 21:36:38 +0100
Message-ID: <20101118213638.233ef701@endymion.delvare>
References: <20101118200935.26334.53708.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101118200935.26334.53708.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Alan,

On Thu, 18 Nov 2010 20:10:09 +0000, Alan Cox wrote:
> From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> dw_spi driver in upstream only supports PIO mode, and this patch
> will support it to cowork with the Designware DMA controller used
> on Intel Moorestown platform
> 
> It has been tested with a Option GTM501L 3G modem, to use DMA mode,
> DMA controller 2 of Moorestown has to be enabled
> 
> Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> [Typo fix and renames to match intel_mid_dma renaming]
> Signed-off-by: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> [Clean up]
> Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> [Fix timing delay, add cpu_relax]
> Signed-off-by: Arjan van de Ven <arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
> 
>  drivers/spi/Kconfig        |    4 +
>  drivers/spi/Makefile       |    3 -
>  drivers/spi/dw_spi.c       |   48 +++++----
>  drivers/spi/dw_spi_mid.c   |  246 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/spi/dw_spi_pci.c   |   14 ++-
>  include/linux/spi/dw_spi.h |   15 +++
>  6 files changed, 305 insertions(+), 25 deletions(-)
>  create mode 100644 drivers/spi/dw_spi_mid.c

Err, why is this being sent to the linux-i2c list?

-- 
Jean Delvare
