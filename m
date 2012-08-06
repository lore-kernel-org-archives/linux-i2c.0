From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: fix i2c-i801.c printk format warning
Date: Mon, 6 Aug 2012 18:17:28 +0200
Message-ID: <20120806181728.56c471dd@endymion.delvare>
References: <20120806140109.b1a33b63686ef04f30139c9e@canb.auug.org.au>
	<501FEC87.6060506@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <501FEC87.6060506-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Randy,

On Mon, 06 Aug 2012 09:10:47 -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
> 
> Fix printk format warning.  ARRAY_SIZE() uses sizeof(),
> which is size_t, so use %zu to print it.
> 
> drivers/i2c/busses/i2c-i801.c: In function 'i801_add_mux':
> drivers/i2c/busses/i2c-i801.c:1043:4: warning: format '%lu' expects type 'long unsigned int', but argument 3 has type 'unsigned int'
> 
> Signed-off-by: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
> Cc: Mark D. Studebaker <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-i801.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20120806.orig/drivers/i2c/busses/i2c-i801.c
> +++ linux-next-20120806/drivers/i2c/busses/i2c-i801.c
> @@ -1039,7 +1039,7 @@ static int __devinit i801_add_mux(struct
>  
>  	/* Find absolute GPIO pin numbers */
>  	if (ARRAY_SIZE(priv->mux_priv) < mux_config->n_gpios) {
> -		dev_err(dev, "i801_priv.mux_priv too small (%lu, need %d)\n",
> +		dev_err(dev, "i801_priv.mux_priv too small (%zu, need %d)\n",
>  			ARRAY_SIZE(priv->mux_priv), mux_config->n_gpios);
>  		return -ENODEV;
>  	}

Good catch once again, thanks a lot. As the offending patch is still
not upstream, I've folded your fix into it.

-- 
Jean Delvare
