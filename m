From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 05/12] i2c: pxa: Add bus reset functionality
Date: Thu, 04 Jun 2015 00:46:54 +0530
Message-ID: <556F52A6.3060104@linaro.org>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>	<1432818224-17070-6-git-send-email-vaibhav.hiremath@linaro.org> <CACRpkdaxWsi8t6aUFJK-KCmQF1gEOLiOE8=fgDRxQDSi4G6FgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdaxWsi8t6aUFJK-KCmQF1gEOLiOE8=fgDRxQDSi4G6FgQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Leilei Shang <shangll-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On Tuesday 02 June 2015 06:42 PM, Linus Walleij wrote:
> On Thu, May 28, 2015 at 3:03 PM, Vaibhav Hiremath
> <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>
>> From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>
>> Since there is some problematic i2c slave devices on some
>> platforms such as dkb (sometimes), it will drop down sda
>> and make i2c bus hang, at that time, it need to config
>> scl/sda into gpio to simulate "stop" sequence to recover
>> i2c bus, so add this interface.
>>
>> Signed-off-by: Leilei Shang <shangll-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> [vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org: Updated Changelog]
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> Double signed-off?
>

Thanks for your review.

Based on review comments on the list, i will have to change this patch
to use generic gpio reset implementation available in i2c-core.

Having said that, I am still sure whether GPIO lib (request/free)
would handle pinctrl configuration.

Thanks,
vaibhav
