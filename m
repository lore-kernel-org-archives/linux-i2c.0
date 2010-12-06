From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-intel-mid: improve timeout handling
Date: Mon, 06 Dec 2010 04:32:31 +0000
Message-ID: <4CFC675F.2000904@fluff.org>
References: <20101124144904.10210.90314.stgit@bob.linux.org.uk> <20101124144920.10210.36601.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101124144920.10210.36601.stgit-Z/y2cZnRghHXmaaqVzeoHQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 24/11/10 14:49, Alan Cox wrote:
> From: Bin Yang <bin.yang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> The old solution for i2c xfer timeout was to set timeout value to one second
> for all i2c xfers.  That's not reasonable for all of the various speed modes
> and data lengths.
> 
> This patch sets the xfer_read timeout value based on both bus speed and data
> length.
> 
> Signed-off-by: Bin Yang <bin.yang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> [Ported to the upstream branch and extracted as a helper function]
> Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
> 
>  drivers/i2c/busses/i2c-intel-mid.c |   31 +++++++++++++++++++++++++++----
>  1 files changed, 27 insertions(+), 4 deletions(-)
> 
> 
> diff --git a/drivers/i2c/busses/i2c-intel-mid.c b/drivers/i2c/busses/i2c-intel-mid.c
> index bdf17da..b39abd8 100644
> --- a/drivers/i2c/busses/i2c-intel-mid.c
> +++ b/drivers/i2c/busses/i2c-intel-mid.c
> @@ -303,6 +303,29 @@ static int ctl_num = 6;
>  module_param_array(speed_mode, int, &ctl_num, S_IRUGO);
>  MODULE_PARM_DESC(speed_mode, "Set the speed of the i2c interface (0-2)");

ok, will queue for next merge window
