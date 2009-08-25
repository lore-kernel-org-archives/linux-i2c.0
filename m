From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 4/6] of_i2c.h: add new prototypes to of_i2c header file.
Date: Tue, 25 Aug 2009 12:09:34 +0200
Message-ID: <20090825100934.GI2039@gundam.enneenne.com>
References: <1251193008-25807-1-git-send-email-christian.herzig@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1251193008-25807-1-git-send-email-christian.herzig-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Herzig <christian.herzig-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, chris-jmrfutXsf6TiB9QmIjCX8w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 25, 2009 at 11:36:48AM +0200, Christian Herzig wrote:
> add two new prototypes: one for registrating a single device and one, for registrating devices behind muxes.
> 
> Signed-off-by: Christian Herzig <christian.herzig-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
> ---
>  include/linux/of_i2c.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/of_i2c.h b/include/linux/of_i2c.h
> index 34974b5..111c919 100644
> --- a/include/linux/of_i2c.h
> +++ b/include/linux/of_i2c.h
> @@ -17,6 +17,11 @@
>  void of_register_i2c_devices(struct i2c_adapter *adap,
>  			     struct device_node *adap_node);
>  
> +void of_register_i2c_devices_behind_muxes(struct i2c_adapter *adap,
> +			struct device_node *mux_node, int channel);
> +
> +void of_register_i2c_device(struct i2c_adapter *adap, struct device_node *dn);
> +
>  /* must call put_device() when done with returned i2c_client device */
>  struct i2c_client *of_find_i2c_device_by_node(struct device_node *node);
>  
> -- 
> 1.6.0.1

Please, group patches into logical steps. I suppose is better move
these modifications into next patch.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
