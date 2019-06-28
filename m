From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH 19/87] i2c: busses: Remove call to memset after
 dmam_alloc_coherent
Date: Fri, 28 Jun 2019 12:13:43 -0400
Message-ID: <20190628161343.GB14635@hmswarspite.think-freely.org>
References: <20190627173653.2833-1-huangfq.daxian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190627173653.2833-1-huangfq.daxian@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fuqian Huang <huangfq.daxian@gmail.com>
Cc: Seth Heasley <seth.heasley@intel.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jun 28, 2019 at 01:36:51AM +0800, Fuqian Huang wrote:
> In commit af7ddd8a627c
> ("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
> dmam_alloc_coherent has already zeroed the memory.
> So memset is not needed.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>  drivers/i2c/busses/i2c-ismt.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
> index 02d23edb2fb1..2f95e25a10f7 100644
> --- a/drivers/i2c/busses/i2c-ismt.c
> +++ b/drivers/i2c/busses/i2c-ismt.c
> @@ -781,8 +781,6 @@ static int ismt_dev_init(struct ismt_priv *priv)
>  	if (!priv->hw)
>  		return -ENOMEM;
>  
> -	memset(priv->hw, 0, (ISMT_DESC_ENTRIES * sizeof(struct ismt_desc)));
> -
>  	priv->head = 0;
>  	init_completion(&priv->cmp);
>  
> -- 
> 2.11.0
> 
> 
Acked-by: Neil Horman <nhorman@tuxdriver.com>
