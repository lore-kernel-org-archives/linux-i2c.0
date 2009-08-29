From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/1] I2C: i2c-core, make attr groups const
Date: Sat, 29 Aug 2009 15:23:14 +0200
Message-ID: <20090829152314.4731af0f@hyperion.delvare>
References: <1250966092-28291-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1250966092-28291-1-git-send-email-jirislaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Slaby <jirislaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 22 Aug 2009 20:34:52 +0200, Jiri Slaby wrote:
> Make attribute_group structure const, to avoid a compiler warning.
> 
> The groups were introduces by commit:
> i2c: Convert i2c adapters to bus devices
> 
> Signed-off-by: Jiri Slaby <jirislaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index eeb9ae5..8d80fce 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -214,7 +214,7 @@ static struct attribute_group i2c_dev_attr_group = {
>  	.attrs		= i2c_dev_attrs,
>  };
>  
> -static struct attribute_group *i2c_dev_attr_groups[] = {
> +static const struct attribute_group *i2c_dev_attr_groups[] = {
>  	&i2c_dev_attr_group,
>  	NULL
>  };
> @@ -528,7 +528,7 @@ static struct attribute_group i2c_adapter_attr_group = {
>  	.attrs		= i2c_adapter_attrs,
>  };
>  
> -static struct attribute_group *i2c_adapter_attr_groups[] = {
> +static const struct attribute_group *i2c_adapter_attr_groups[] = {
>  	&i2c_adapter_attr_group,
>  	NULL
>  };

Merged into the faulty patches, thanks for reporting.

-- 
Jean Delvare
