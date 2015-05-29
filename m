From: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH 06/12] i2c: pxa: Return I2C_RETRY when timeout in pio mode
Date: Fri, 29 May 2015 22:46:43 +0200
Message-ID: <87vbfbxgb0.fsf@belgarion.home>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
	<1432818224-17070-7-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432818224-17070-7-git-send-email-vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
	(Vaibhav Hiremath's message of "Thu, 28 May 2015 18:33:38 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shouming Wang <wangshm-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:

> From: Shouming Wang <wangshm-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>
> In case of timeout in pio mode of operation return I2C_RETRY.
> This behavior will be same as interrupt mode of operation.
>
> Signed-off-by: Shouming Wang <wangshm-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> [vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org: Updated changelog]
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-pxa.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index eb09071..2777d5c 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -841,8 +841,10 @@ static int i2c_pxa_do_pio_xfer(struct pxa_i2c *i2c,
>  	ret = i2c->msg_idx;
>  
>  out:
> -	if (timeout == 0)
> +	if (timeout == 0) {
>  		i2c_pxa_scream_blue_murder(i2c, "timeout");
> +		ret = I2C_RETRY;
> +	}
Ok, looks good to me.
As it changes the dynamic behavior of i2c_pxa_pio_xfer(), I'd like to know how
it was tested (on which platform, and what was on the I2C bus).

Cheers.

-- 
Robert
