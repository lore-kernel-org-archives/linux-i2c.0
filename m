From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: use enable on resume instead
 initialization
Date: Wed, 10 Jun 2015 10:55:55 +0300
Message-ID: <20150610075555.GO1478@lahna.fi.intel.com>
References: <1433785828-4100-1-git-send-email-lucas.de.marchi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1433785828-4100-1-git-send-email-lucas.de.marchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lucas.de.marchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Fabio Mello <fabio.mello-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lucas De Marchi <lucas.demarchi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 08, 2015 at 02:50:28PM -0300, lucas.de.marchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> @@ -320,7 +320,7 @@ static int dw_i2c_resume(struct device *dev)
>  	clk_prepare_enable(i_dev->clk);
>  
>  	if (!i_dev->pm_runtime_disabled)
> -		i2c_dw_init(i_dev);
> +		i2c_dw_enable(i_dev);

This will not work if the device power gets removed (for example being
put to D3cold) as it looses context.
