From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 2/3] i2c/at91: add support for system PM
Date: Fri, 24 Oct 2014 17:02:37 +0400
Message-ID: <544A4DED.6090009@cogentembedded.com>
References: <1414133417-11530-1-git-send-email-wenyou.yang@atmel.com> <1414133417-11530-3-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1414133417-11530-3-git-send-email-wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
Cc: khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello.

On 10/24/2014 10:50 AM, Wenyou Yang wrote:

> Signed-off-by: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> ---
>   drivers/i2c/busses/i2c-at91.c |   26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)

> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index a25fb5e..6a84a2a 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -861,7 +861,33 @@ static int at91_twi_runtime_resume(struct device *dev)
[...]
> +static int at91_twi_resume_noirq(struct device *dev)
> +{
> +	int ret;
> +
> +	if (!pm_runtime_status_suspended(dev)) {
> +		ret = at91_twi_runtime_resume(dev);

    Resume if *not* suspended?

> +		if (ret)
> +			return ret;
> +	}
> +
> +	pm_runtime_mark_last_busy(dev);
> +	pm_request_autosuspend(dev);
> +
> +	return 0;
> +}
> +
[...]

WBR, Sergei
