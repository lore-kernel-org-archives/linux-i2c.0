From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v1 4/4] i2c-mux: i2c_add_mux_adapter() should use -1 for
 auto bus num
Date: Wed, 13 Feb 2013 14:09:08 -0700
Message-ID: <511C00F4.4080708@wwwdotorg.org>
References: <1360778532-7480-1-git-send-email-dianders@chromium.org> <1360778532-7480-4-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1360778532-7480-4-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Yuvaraj Kumar <yuvaraj.cd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Girish Shivananjappa <girish.shivananjappa-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, bhushan.r-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sreekumar.c-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Prashanth G <prashanth.g-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Barry Song <baohua.song>
List-Id: linux-i2c@vger.kernel.org

On 02/13/2013 11:02 AM, Doug Anderson wrote:
> The force_nr parameter to i2c_add_mux_adapter() uses 0 to signify that
> we don't want to force the bus number of the adapter.  This is
> non-ideal because:
> * 0 is actually a valid bus number to request
> * i2c_add_numbered_adapter() (which i2c_add_mux_adapter() calls) uses
>   -1 to mean the same thing.  That means extra logic in
>   i2c_add_mux_adapter().
> 
> Fix i2c_add_mux_adapter() to use -1 and update all mux drivers
> accordingly.
> 
> Signed-off-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
> Notes:
> - If there's a good reason that force_nr uses 0 for auto then feel
>   free to drop this patch.  I've place it at the end of the series to
>   make it easy to just drop it.

IIRC (and I only vaguely do...) it's because:

> diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
> index 9f50ef0..301ed0b 100644
> --- a/drivers/i2c/muxes/i2c-mux-gpio.c
> +++ b/drivers/i2c/muxes/i2c-mux-gpio.c
> @@ -208,7 +208,7 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
>  	}
>  
>  	for (i = 0; i < mux->data.n_values; i++) {
> -		u32 nr = mux->data.base_nr ? (mux->data.base_nr + i) : 0;
> +		int nr = mux->data.base_nr ? (mux->data.base_nr + i) : -1;

Here, mux->data.base_nr is platform data (or copied directly from it),
and any field in a platform data struct stored in a global variable not
explicitly initialized would be 0, hence 0 would typically mean "no
explicit bus number desired". Since a mux can't exist without a parent
I2C bus, it's unlikely anyone would want a mux to be I2C bus 0, but
rather the parent to have that number.
