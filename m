From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 2/6] i2c pca954x: add readable channel-property in sysfs
Date: Tue, 25 Aug 2009 12:04:57 +0200
Message-ID: <20090825100457.GG2039@gundam.enneenne.com>
References: <1251192981-25751-1-git-send-email-christian.herzig@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1251192981-25751-1-git-send-email-christian.herzig-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Herzig <christian.herzig-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, chris-jmrfutXsf6TiB9QmIjCX8w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 25, 2009 at 11:36:21AM +0200, Christian Herzig wrote:
> Add to the pca954x driver the ability to check the
> actual channel. The channel property is readable only.
> 
> Signed-off-by: Christian Herzig <christian.herzig-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/i2c/muxes/pca954x.c |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/muxes/pca954x.c b/drivers/i2c/muxes/pca954x.c
> index 59d3917..ba4fef1 100644
> --- a/drivers/i2c/muxes/pca954x.c
> +++ b/drivers/i2c/muxes/pca954x.c
> @@ -56,6 +56,8 @@ enum pca_type {
>  	pca_9548,
>  };
>  
> +static u8 channel;
> +

Nack. Why are you using global variable? Please use reentrant code.

>  struct pca954x {
>  	struct i2c_client *client;
>  	struct i2c_client dev;
> @@ -208,6 +210,17 @@ static int pca954x_deselect_mux(struct i2c_adapter *adap,
>  	return pca954x_xfer(adap, client, I2C_SMBUS_WRITE, &regval);
>  }
>  
> +/* called when reading channel property */
> +static ssize_t read_channel(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	snprintf(buf, 8, "%d\n", channel);
> +	return strlen(buf)+1;

I suppose you can simply do:

  return sprintf(buf "%d\n", channel);

> +}
> +
> +/* define read and write method for channel attribute and its access rights */
> +static DEVICE_ATTR(channel, S_IRUGO, read_channel, NULL);
> +
>  /*
>   * I2C init/probing/exit functions
>   */
> @@ -271,6 +284,11 @@ static int pca954x_probe(struct i2c_client *client,
>  			i, chips[data->type].muxtype == pca954x_ismux ?
>  					"mux" : "switch", client->name);
>  
> +	/* create channel attribute file in sysfs */
> +	ret = sysfs_create_file(&client->dev.kobj, &dev_attr_channel);
> +	if (0 != ret)
> +		printk(KERN_ERR "creating file in sysfs failed\n");
> +

No remove code?

>  	return 0;
>  
>  virt_reg_failed:
> -- 
> 1.6.0.1
> 

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
