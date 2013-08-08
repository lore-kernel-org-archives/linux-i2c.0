From: Nguyen Viet Dung <nv-dung-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Subject: Re: [PATCH v2 1/1 resend] i2c: rcar: modify I2C driver
Date: Thu, 08 Aug 2013 20:39:17 +0900
Message-ID: <52038365.4000508@jinso.co.jp>
References: <1375687174-577-1-git-send-email-nv-dung@jinso.co.jp> <1375687174-577-2-git-send-email-nv-dung@jinso.co.jp> <20130807151234.GH2978@katana> <5202F0AC.4070609@jinso.co.jp> <20130808080819.GA6070@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130808080819.GA6070-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolffam

Thank for your advice.
I have understand what you have guided.

Time of 08/10~08/18 day is summer holiday in Japan.
Affter summer holiday, I am going modify the patch, and send again.

At that time,please check it for me.
Thanks,
Dung

On 08/08/2013 05:12 PM, Wolfram Sang wrote:
> On Thu, Aug 08, 2013 at 10:13:16AM +0900, Nguyen Viet Dung wrote:
>
>> Difference between H2 and H1 in hardware is only CDF bit of ICCCR register.
> No IP version register? Sigh...
>
>> If this method is not a common method, please tell me about common method.
> Use a new platform_device_id and populate the driver_data with the info
> needed to distinguish between the revisions. Check i2c-imx.c for an
> example.
>
>
>
