From: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Subject: Re: [PATCH 2/7] drm/nouveau: do a better job at hiding the NIH i2c
 bit-banging algo
Date: Mon, 27 Feb 2012 18:25:48 +0100
Message-ID: <20120227172548.GG4866@phenom.ffwll.local>
References: <1329255445-6312-1-git-send-email-daniel.vetter@ffwll.ch>
 <1329255445-6312-2-git-send-email-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1329255445-6312-2-git-send-email-daniel.vetter-/w4YWyX8dFk@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Intel Graphics Development <intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: DRI Development <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

Can you ack this patch for merging through drm-intel-next? Imo that's the
easiest way to get it in (assuming you don't have any objections).

Thanks, Daniel

On Tue, Feb 14, 2012 at 10:37:20PM +0100, Daniel Vetter wrote:
> I'd like to export the corresponding functions from the i2c core
> so that I can use them in fallback bit-banging in i915.ko
> 
> Cc: nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Signed-off-by: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
> ---
>  drivers/gpu/drm/nouveau/nouveau_i2c.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_i2c.c b/drivers/gpu/drm/nouveau/nouveau_i2c.c
> index 820ae7f..7a7e751 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_i2c.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_i2c.c
> @@ -242,7 +242,7 @@ i2c_addr(struct nouveau_i2c_chan *port, struct i2c_msg *msg)
>  }
>  
>  static int
> -i2c_bit_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
> +nouveau_i2c_bit_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>  {
>  	struct nouveau_i2c_chan *port = (struct nouveau_i2c_chan *)adap;
>  	struct i2c_msg *msg = msgs;
> @@ -272,14 +272,14 @@ i2c_bit_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>  }
>  
>  static u32
> -i2c_bit_func(struct i2c_adapter *adap)
> +nouveau_i2c_bit_func(struct i2c_adapter *adap)
>  {
>  	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
>  }
>  
>  const struct i2c_algorithm i2c_bit_algo = {
> -	.master_xfer = i2c_bit_xfer,
> -	.functionality = i2c_bit_func
> +	.master_xfer = nouveau_i2c_bit_xfer,
> +	.functionality = nouveau_i2c_bit_func
>  };
>  
>  static const uint32_t nv50_i2c_port[] = {
> -- 
> 1.7.7.5
> 

-- 
Daniel Vetter
Mail: daniel-/w4YWyX8dFk@public.gmane.org
Mobile: +41 (0)79 365 57 48
