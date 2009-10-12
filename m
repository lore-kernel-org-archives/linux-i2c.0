From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Modify code name SB900 to Hudson-2
Date: Mon, 12 Oct 2009 12:51:51 +0200
Message-ID: <20091012125151.2d0ef7bc@hyperion.delvare>
References: <20091012020518.GA19626@crane-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091012020518.GA19626@crane-desktop>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Crane,

On Mon, 12 Oct 2009 10:05:18 +0800, Crane Cai wrote:
> Hi Jean,
> We have changed the name of SB900 chip, and the source needs change also.
> Please apply.
> Thanks,
> - Crane
> 
> ---
> Change SB900 to its formal code name Hudson-2.
> 
> Signed-off-by: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
> ---
>  Documentation/i2c/busses/i2c-piix4 |    2 +-
>  drivers/i2c/busses/Kconfig         |    2 +-
>  drivers/i2c/busses/i2c-piix4.c     |    4 ++--
>  include/linux/pci_ids.h            |    2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)

Applied, thanks. Will go in kernel 2.6.32.

I have also added support to sensors-detect.

-- 
Jean Delvare
