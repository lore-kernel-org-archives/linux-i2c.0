From: zhangfei <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/3] i2c: hix5hd2: add i2c controller driver
Date: Sat, 04 Oct 2014 08:22:50 +0800
Message-ID: <542F3DDA.9060607@linaro.org>
References: <1412079628-6316-1-git-send-email-zhangfei.gao@linaro.org> <1412079628-6316-3-git-send-email-zhangfei.gao@linaro.org> <20141003120926.GF1349@katana> <542EA15B.70605@linaro.org> <20141003164851.GA1481@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141003164851.GA1481@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, haifeng.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jchxue-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On 10/04/2014 12:48 AM, Wolfram Sang wrote:
>> Currently Wei help do the test via I2C device interface, on a specific board
>> with i2c device.
>> We do the test after the board is up, also no i2c activity during probe.
>
> Huh, so the driver has not been tested with a real i2c slave so far? Or
> am I misunderstanding something?

Sorry for the confusion

It is tested via e2prom,
Write group of data then read back to check whether they are same or not.
We use I2C device interface, and only run the test application when 
board is up.

Thanks
