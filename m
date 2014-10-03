From: zhangfei <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/3] i2c: hix5hd2: add i2c controller driver
Date: Fri, 03 Oct 2014 21:15:07 +0800
Message-ID: <542EA15B.70605@linaro.org>
References: <1412079628-6316-1-git-send-email-zhangfei.gao@linaro.org> <1412079628-6316-3-git-send-email-zhangfei.gao@linaro.org> <20141003120926.GF1349@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141003120926.GF1349@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, haifeng.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jchxue-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On 10/03/2014 08:09 PM, Wolfram Sang wrote:
> Hi,
>
> On Tue, Sep 30, 2014 at 08:20:27PM +0800, Zhangfei Gao wrote:
>> From: Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>>
>> I2C drivers for hix5hd2 soc series, including following chipset
>> Hi3716CV200, Hi3719CV100, Hi3718CV100, Hi3719MV100, Hi3718MV100.
>>
>> Signed-off-by: Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> Looks good to me. You probably want to have a look at this patch
> http://patchwork.ozlabs.org/patch/394648/
>
> an do something similar here, I guess.
>
> BTW what tests have you performed?
>

Thanks Wolfram for the info, will update accordingly.

Currently Wei help do the test via I2C device interface, on a specific 
board with i2c device.
We do the test after the board is up, also no i2c activity during probe.

Thanks
