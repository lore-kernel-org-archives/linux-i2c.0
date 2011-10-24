From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH V2] i2c-designware: Change readl to readw and writel to
 writew
Date: Mon, 24 Oct 2011 12:33:16 +0200
Message-ID: <20111024103316.GC26649@sapphire.tkos.co.il>
References: <1319450282-914-1-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1319450282-914-1-git-send-email-rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rajeev Kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shiraz.hashim-qxv4g6HH51o@public.gmane.org, viresh.kumar-qxv4g6HH51o@public.gmane.org, bhupesh.sharma-qxv4g6HH51o@public.gmane.org, pratyush.anand-qxv4g6HH51o@public.gmane.org, vipin.kumar-qxv4g6HH51o@public.gmane.org, deepak.sikri-qxv4g6HH51o@public.gmane.org, amit.virdi-qxv4g6HH51o@public.gmane.org, vipulkumar.samar-qxv4g6HH51o@public.gmane.org, armando.visconti-qxv4g6HH51o@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Rajeev,

On Mon, Oct 24, 2011 at 03:28:02PM +0530, Rajeev Kumar wrote:
> Since I2C designware registers are 16 bit wide and so we should use
> readw/writew.
> 
> Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-designware.c |  104 +++++++++++++++++-----------------
>  1 files changed, 52 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
> index 6eaa681..5149a10 100644
> --- a/drivers/i2c/busses/i2c-designware.c
> +++ b/drivers/i2c/busses/i2c-designware.c
> @@ -216,11 +216,11 @@ struct dw_i2c_dev {
>  	u32			abort_source;
>  	int			irq;
>  	struct i2c_adapter	adapter;
> -	unsigned int		tx_fifo_depth;
> -	unsigned int		rx_fifo_depth;
> +	u16			tx_fifo_depth;
> +	u16			rx_fifo_depth;
>  };

This looks wrong. The {tx,rx}_fifo_depth fields do not represent bit fields, 
but numbers. So unsigned int should be better here.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
