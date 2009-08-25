From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/6] i2c pca954x: catch dereferencing from NULL-pointer
Date: Tue, 25 Aug 2009 12:00:40 +0200
Message-ID: <20090825100040.GF2039@gundam.enneenne.com>
References: <1251192966-25724-1-git-send-email-christian.herzig@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1251192966-25724-1-git-send-email-christian.herzig-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Herzig <christian.herzig-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, chris-jmrfutXsf6TiB9QmIjCX8w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 25, 2009 at 11:36:06AM +0200, Christian Herzig wrote:
> pdata can be NULL, so pdata->modes[i] will crashes the kernel.
> 
> Signed-off-by: Christian Herzig <christian.herzig-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/i2c/muxes/pca954x.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/muxes/pca954x.c b/drivers/i2c/muxes/pca954x.c
> index b12e6b7..59d3917 100644
> --- a/drivers/i2c/muxes/pca954x.c
> +++ b/drivers/i2c/muxes/pca954x.c
> @@ -259,10 +259,12 @@ static int pca954x_probe(struct i2c_client *client,
>  			goto virt_reg_failed;
>  		}
>  
> -		data->deselect_on_exit = pdata ?
> +		if (pdata) {
> +			data->deselect_on_exit = pdata ?
>  				pdata->modes[i].deselect_on_exit : 0;
> -		data->is_chan_connected = pdata ?
> +			data->is_chan_connected = pdata ?
>  				pdata->modes[i].is_chan_connected : NULL;
> +		}
>  	}
>  
>  	dev_info(&client->dev, "registered %d virtual busses for I2C %s %s\n",
> -- 
> 1.6.0.1

If pdata is NULL then the condition is false and the CPU should jump
to the false branch and returning 0 or NULL. Did you really get error
here?

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
