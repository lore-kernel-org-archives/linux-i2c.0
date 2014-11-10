From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4] i2c/at91: adopt pinctrl support
Date: Mon, 10 Nov 2014 14:13:28 +0300
Message-ID: <54609DD8.8030903@cogentembedded.com>
References: <1415584552-11390-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415584552-11390-1-git-send-email-wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
Cc: khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello.

On 11/10/2014 4:55 AM, Wenyou Yang wrote:

> Amend the at91 i2c pin controller

    You're amending the hardware itself, really? :-)

> to optionally take a pin controlhandle

    I don't see the code that does this.

> and set the state of the pins to:
> - "default" on boot and resume.

    I don't see where you are changing anything for the probe() method. 
Perhaps you meant the driver core code which selects the dafault profile 
automatically?

> - "sleep" on suspend().

> This should make it possible to optimize energy usage for the pins
> both for the suspend/resume cycle

> Signed-off-by: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> ---
> Hi Wolfram,
>
> Thanks a lot.
>
> The change of this version is to remove
> 	pinctrl_pm_select_default_state(&pdev->dev) from the _probe function.

    Aha, you've specifically removed this...

WBR, Sergei
