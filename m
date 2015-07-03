From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH-V2 11/12] i2c: pxa: Add ILCR (tLow & tHigh) configuration
 support
Date: Fri, 03 Jul 2015 23:47:10 +0530
Message-ID: <5596D1A6.7030600@linaro.org>
References: <vaibhav.hiremath@linaro.org>	<1434383399-2370-1-git-send-email-vaibhav.hiremath@linaro.org>	<1434383399-2370-12-git-send-email-vaibhav.hiremath@linaro.org> <87vbe1b6ra.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87vbe1b6ra.fsf-4ty26DBLk+jEm7gnYqmdkQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On Friday 03 July 2015 08:58 PM, Robert Jarzmik wrote:
> Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
>
>> +	i2c->clk = devm_clk_get(&dev->dev, NULL);
>> +	if (IS_ERR(i2c->clk)) {
>> +		dev_err(&dev->dev, "failed to get the clk\n");
>> +		dev_err(&dev->dev, "failed to get the clk: %ld\n", PTR_ERR(i2c->clk));
>
>> +		return PTR_ERR(i2c->clk);
>> +	}
> Why is this block moving up ? I can't find the reason in the commit message or
> in the code.
>

Because of obvious reason :)

The clk_rate is being used in i2c_pxa_probe_dt() function.

Although I did not mention in commit description as I felt it is
evident from the patch.
Probably should have been more descriptive here, sorry for that.
I will take care of it in next version.

Thanks,
Vaibhav
