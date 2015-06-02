From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 00/12] i2c: pxa: Fixes, cleanup and support for pxa910
 family
Date: Tue, 02 Jun 2015 10:28:32 +0530
Message-ID: <556D37F8.2030904@linaro.org>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org> <fb192019ec75e9aa10b04b79e87a6e79@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fb192019ec75e9aa10b04b79e87a6e79-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On Monday 01 June 2015 05:37 AM, Wolfram Sang wrote:
>> TODO:
>>   - Due to lack of client driver support as of now, could not
>>     able to do functionality testing from client. I am working
>>     on PMIC driver support which is over I2C, so will have good
>>     meaningful testing then.
>
> Okay, thanks for the info. So, unless this is done I'll consider these
> patches as RFC.


I already have PMIC client driver up and doing some testing with it.
So we should not have this issue for my next version.

Thanks,
Vaibhav
