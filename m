From: Kefeng Wang <wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: question about i2c-designware
Date: Fri, 10 Jul 2015 12:11:38 +0800
Message-ID: <559F45FA.8060801@huawei.com>
References: <559E37D7.6040103@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <559E37D7.6040103-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Alexey Brodkin <abrodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Ding Tianhong <dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "Guohanjun (Hanjun Guo)" <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

+ linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

On 2015-07-09 16:59, Kefeng Wang wrote:
> Hi all,
> 
>   We met a issue when use Synopsys DesignWare I2C. The SDA will keep low level and never go back to the high level
> if both i2c controllers simultaneously access the same i2c device(rtc), then both two i2c controllers can't send any data.
> we try to reset the rtc, but not working. After reset the i2c controller, the SDA goes back to the high state and we
> can get time from rtc again.
> 
> The scenario is as follows, any advice will be appreciated.
> 
>                    OS 1         |     OS 2
>                                 |
> 	+--------------+----------|--------------+
> 	|	       |	  |              |
> 	|    +---------|----+-----|---------+    |
> 	|    |	       |    |     |         |    |
>    ----------------    ------	  |    -----------------
>    |i2c controller1|   | rtc|	  |    |i2c controller2|
>    ----------------    ------   |    -----------------
>                                 |
> note:
> 1) i2c controller1 and controller2 use same IP.
> 2) OS1 use v3.19 and OS2 use 2.6
> 
> Thanks
> Kefeng
> 
