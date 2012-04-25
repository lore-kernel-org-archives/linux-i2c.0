From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] eepromer/24cXX: fix leaking file descriptor
Date: Wed, 25 Apr 2012 08:41:26 +0200
Message-ID: <20120425084126.317079a9@endymion.delvare>
References: <d53426eaec2f3212842b5a44a0fbc2d1c97f44e3.1335263046.git.npajkovs@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d53426eaec2f3212842b5a44a0fbc2d1c97f44e3.1335263046.git.npajkovs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nikola Pajkovsky <npajkovs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Nikola,

Patches for i2c-tools are better sent to the linux-i2c list,
redirecting.

On Tue, 24 Apr 2012 12:24:54 +0200, Nikola Pajkovsky wrote:
> Signed-off-by: Nikola Pajkovsky <npajkovs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  eepromer/24cXX.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/eepromer/24cXX.c b/eepromer/24cXX.c
> index 00a21fd..ab86c33 100644
> --- a/eepromer/24cXX.c
> +++ b/eepromer/24cXX.c
> @@ -79,9 +79,10 @@ int eeprom_open(char *dev_fqn, int addr, int type, struct eeprom* e)
>  		return -1;
>  
>  	// get funcs list
> -	if((r = ioctl(fd, I2C_FUNCS, &funcs) < 0))
> +	if((r = ioctl(fd, I2C_FUNCS, &funcs) < 0)) {
> +		close(fd);
>  		return r;
> -
> +	}
>  	
>  	// check for req funcs
>  	CHECK_I2C_FUNC( funcs, I2C_FUNC_SMBUS_READ_BYTE );

Good catch, however this function is leaking the same file descriptor
in 7 other cases (one obvious one plus six times in CHECK_I2C_FUNC.) If
we fix one, we should fix them all. I'd also be happy to get rid of
CHECK_I2C_FUNC as it exists, macro-generated code is evil. I see no
good reason why this couldn't be implemented as a regular function
instead.

Will you send updated patches, or do you want me to take care of these
changes?

Thanks,
-- 
Jean Delvare
