From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2] i2c-ismt: Add Seth and Myself as maintainers
Date: Sun, 10 Feb 2013 11:10:37 +0100
Message-ID: <20130210111037.5b831d9b@endymion.delvare>
References: <20130208105756.35d00bae@endymion.delvare>
	<1360348061-13153-1-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1360348061-13153-1-git-send-email-nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Heasley, Seth" <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Bill E" <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri,  8 Feb 2013 13:27:41 -0500, Neil Horman wrote:
> Adding Seth Heasley and Myself as maintainers for the i2c-ismt drvier
> 
> Signed-off-by: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
> Signed-off-by: "Heasley, Seth" <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> CC: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> CC: "Brown, Bill E" <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3105c48..cb50da7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3750,6 +3750,13 @@ F:	drivers/i2c/busses/i2c-sis96x.c
>  F:	drivers/i2c/busses/i2c-via.c
>  F:	drivers/i2c/busses/i2c-viapro.c
>  
> +I2C/SMBUS ISMT Driver

This should be in uppercase letters. Sorry for missing this during my
first review.

After fixing this, you can add:

Reviewed-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

> +M:	Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> +M:	Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
> +L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> +F:	drivers/i2c/busses/i2c-ismt.c
> +F:	Documentation/i2c/busses/i2c-ismt
> +
>  I2C/SMBUS STUB DRIVER
>  M:	"Mark M. Hoffman" <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>
>  L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

-- 
Jean Delvare
