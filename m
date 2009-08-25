From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 3/6] i2c pca954x: add dts-binding facility
Date: Tue, 25 Aug 2009 12:08:16 +0200
Message-ID: <20090825100815.GH2039@gundam.enneenne.com>
References: <1251192994-25779-1-git-send-email-christian.herzig@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1251192994-25779-1-git-send-email-christian.herzig-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Herzig <christian.herzig-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, chris-jmrfutXsf6TiB9QmIjCX8w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 25, 2009 at 11:36:34AM +0200, Christian Herzig wrote:
> At the end of probe, the driver is checking the i2c_clients
> corresponding device_node entry. If an entry is found, the
> binding is forced according the device tree.
> 
> Signed-off-by: Christian Herzig <christian.herzig-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/i2c/muxes/pca954x.c |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/muxes/pca954x.c b/drivers/i2c/muxes/pca954x.c
> index ba4fef1..7dd1000 100644
> --- a/drivers/i2c/muxes/pca954x.c
> +++ b/drivers/i2c/muxes/pca954x.c
> @@ -40,6 +40,7 @@
>  #include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
> +#include <linux/of_i2c.h>
>  
>  #include <linux/i2c/pca954x.h>
>  
> @@ -57,6 +58,9 @@ enum pca_type {
>  };
>  
>  static u8 channel;
> +struct i2c_adapter *virt_adap;
> +int adap_nbr;
> +int ret;

Nack. Use reentrant code.

>  struct pca954x {
>  	struct i2c_client *client;
> @@ -233,6 +237,13 @@ static int pca954x_probe(struct i2c_client *client,
>  	int i, n, f;
>  	struct pca954x *data;
>  	int ret = -ENODEV;
> +	struct device_node *ofdn;
> +
> +	/* count registered i2c-adapters */
> +	int reg_adaps = 0;
> +	while (i2c_get_adapter(reg_adaps))
> +		reg_adaps++;
> +	pr_debug("pca954x: already %i i2c-adapters registrated\n", reg_adaps);
>  
>  	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE))
>  		goto err;
> @@ -289,6 +300,23 @@ static int pca954x_probe(struct i2c_client *client,
>  	if (0 != ret)
>  		printk(KERN_ERR "creating file in sysfs failed\n");
>  
> +	/* arch specific code for of-support.
> +	 * checkup dts binding in kernel-documentation
> +	 * Documentation/powerpc/dts_binding/mux/pca954x.txt.
> +	 */
> +	ofdn = dev_archdata_get_node(&client->dev.archdata);
> +	if (ofdn) {
> +		for (adap_nbr = reg_adaps;
> +			adap_nbr < chips[data->type].nchans + reg_adaps;
> +			adap_nbr++) {
> +			pr_debug("register devices at adap i2c-%i\n", adap_nbr);
> +
> +			virt_adap = i2c_get_adapter(adap_nbr);
> +			of_register_i2c_devices_behind_muxes
> +				(virt_adap, ofdn, adap_nbr - reg_adaps);
> +		}
> +	}
> +

What happens if current arch has no of-support?

>  	return 0;
>  
>  virt_reg_failed:
> -- 
> 1.6.0.1

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
