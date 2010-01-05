From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 01/12] i2c-core: Storage class should be before const
 qualifier
Date: Tue, 5 Jan 2010 13:43:44 +0100
Message-ID: <20100105134344.651a7f9f@hyperion.delvare>
References: <1261572971-8537-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1261572971-8537-1-git-send-email-tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Tobias,

On Wed, 23 Dec 2009 13:56:11 +0100, Tobias Klauser wrote:
> The C99 specification states in section 6.11.5:
> 
> The placement of a storage-class specifier other than at the beginning
> of the declaration specifiers in a declaration is an obsolescent
> feature.
> 
> Signed-off-by: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 0ac2f90..d610e99 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -248,7 +248,7 @@ static const struct attribute_group *i2c_dev_attr_groups[] = {
>  	NULL
>  };
>  
> -const static struct dev_pm_ops i2c_device_pm_ops = {
> +static const struct dev_pm_ops i2c_device_pm_ops = {
>  	.suspend = i2c_device_pm_suspend,
>  	.resume = i2c_device_pm_resume,
>  };

Applied, thanks.

-- 
Jean Delvare
