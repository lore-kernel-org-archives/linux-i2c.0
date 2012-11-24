From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 13/24] MAINTAINERS: fix drivers/i2c/busses/i2c-stub.c
Date: Sat, 24 Nov 2012 09:44:13 +0100
Message-ID: <20121124094413.35547dab@endymion.delvare>
References: <1353716808-16375-1-git-send-email-cesarb@cesarb.net>
	<1353716808-16375-14-git-send-email-cesarb@cesarb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1353716808-16375-14-git-send-email-cesarb-PWySMVKUnqmsTnJN9+BGXg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cesar Eduardo Barros <cesarb-PWySMVKUnqmsTnJN9+BGXg@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Mark M. Hoffman" <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Cesar,

On Fri, 23 Nov 2012 22:26:37 -0200, Cesar Eduardo Barros wrote:
> This file was moved to drivers/i2c/i2c-stub.c by commit 31d178b
> (i2c-stub: Move to drivers/i2c).
> 
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: "Mark M. Hoffman" <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Cesar Eduardo Barros <cesarb-PWySMVKUnqmsTnJN9+BGXg@public.gmane.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 91feba2..eaf1a59 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3667,7 +3667,7 @@ I2C/SMBUS STUB DRIVER
>  M:	"Mark M. Hoffman" <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>
>  L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>  S:	Maintained
> -F:	drivers/i2c/busses/i2c-stub.c
> +F:	drivers/i2c/i2c-stub.c

Right. I thought I had fixed it meanwhile, but either I forgot or it
got lost along the way. Applied, thanks.

BTW, Mark has been away from linux kernel development for years now and
he did even not reply to my latest e-mail, so maybe it would be better
to drop his entries from MAINTAINERS altogether. Mark, please speak up.

-- 
Jean Delvare
