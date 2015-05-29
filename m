From: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH 03/12] i2c: pxa: Add reset operation when i2c bus busy
Date: Fri, 29 May 2015 21:39:14 +0200
Message-ID: <878uc7yxzx.fsf@belgarion.home>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
	<1432818224-17070-4-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432818224-17070-4-git-send-email-vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
	(Vaibhav Hiremath's message of "Thu, 28 May 2015 18:33:35 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:

> From: "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>
> According to some test in emei_dkb, we found some i2c slave device
> (eg. camera sensor ov2659 power up) introduce noise on sda, so detect
> i2c controller busy, and assert reset to i2c controller to recover as
> early as possible to avoid more latency on the entire i2c transaction.
>
> Signed-off-by: Jett.Zhou <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> [vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org: Removed reduction in timeout value, as I
> do not have goot explanation for it. Logically it is not required.
> And also Updated changelog]
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-pxa.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index d4c798a..a76c901 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -314,6 +314,10 @@ static int i2c_pxa_wait_bus_not_busy(struct pxa_i2c *i2c)
>  {
>  	int timeout = DEF_TIMEOUT;
>  
> +	if (readl(_ISR(i2c)) & (ISR_IBB | ISR_UB))
> +		i2c_pxa_reset(i2c);

The pxa27x manual states in the Developer Manual, chapter 9.4.13 "Reset
Conditions" :
            Software must ensure that (1) the I 2 C unit is not busy before it
            asserts a reset

Given that, I don't agree with this patch. Moreover, reseting unconditionaly the
i2c bus on each busy state on a write transaction for one single corner case is
not something that has my agreement. A quirk might overcome my reluctance.

Cheers.

-- 
Robert
