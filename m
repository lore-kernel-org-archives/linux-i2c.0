From: Jonathan Cameron <Jonathan.Cameron-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ALS: TSL2550 driver move from i2c/chips
Date: Fri, 09 Oct 2009 15:53:39 +0100
Message-ID: <4ACF4E73.5010606@gmail.com>
References: <4ACF4AC6.7070802@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4ACF4AC6.7070802-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, "Michele De Candia (VT)" <michele.decandia-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Friday afternoon moment....

That id element will need to be signed for any errors on idr allocation
to be detected.  Will fix for next version.
>  struct tsl2550_data {
> +	struct device *classdev;
>  	struct i2c_client *client;
>  	struct mutex update_lock;
> +	unsigned int id;
>  
>  	unsigned int power_state : 1;
>  	unsigned int operating_mode : 1;
>   
....
>  
> +	data->id = tsl2550_get_id();
> +	if (data->id < 0) {
> +		err = data->id;
> +		goto exit_kfree;
> +	}
>   

Jonathan
