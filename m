From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/5] arm: shmobile: r7s72100: add i2c clocks
Date: Wed, 18 Dec 2013 18:02:14 +0400
Message-ID: <52B1AAE6.2020400@cogentembedded.com>
References: <1387316678-10174-1-git-send-email-wsa@the-dreams.de> <1387316678-10174-3-git-send-email-wsa@the-dreams.de> <52B1892B.1020806@cogentembedded.com> <20131218114351.GD3314@katana> <52B18CC9.8090200@cogentembedded.com> <20131218121541.GE3314@katana> <20131218134914.GA32664@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131218134914.GA32664-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello.

On 18-12-2013 17:49, Simon Horman wrote:

>>>>>> @@ -173,6 +179,10 @@ static struct clk_lookup lookups[] = {
>>>>>>   	CLKDEV_CON_ID("mtu2_fck", &mstp_clks[MSTP33]),

>>>>>>   	/* ICK */
>>>>>> +	CLKDEV_DEV_ID("fcfee000.i2c", &mstp_clks[MSTP97]),
>>>>>> +	CLKDEV_DEV_ID("fcfee400.i2c", &mstp_clks[MSTP96]),
>>>>>> +	CLKDEV_DEV_ID("fcfee800.i2c", &mstp_clks[MSTP95]),
>>>>>> +	CLKDEV_DEV_ID("fcfeec00.i2c", &mstp_clks[MSTP94]),

>>>>>     These belong to some other place, the group marked by /* ICK */
>>>>> is only for CLKDEV_ICK_ID().

>>>> So, I'll create a /* DEV */ prefix?

>>>     I really don't know. Other places have /* MSTP */ comment in this
>>> case despite all clocks, CLKDEV_DEV_ID() and CLKDEV_ICK_ID() are
>>> really MSTP clocks. I considered the idea of separating
>>> CLKDEV_ICK_ID() under /* ICK */ comment silly from the very start
>>> but Simon didn't listen to me.

>> I am puzzled, too. ICK is a type of registration and not a clock domain.
>> Also, there is 'mtu2_fck' which is under ICK as well as MSTP? Looks
>> wrong. From what I understand now, removing the /* ICK */ comment would
>> be easiest and proper?

> I'm not sure that I really understand what all the fuss is about.

> As I understand things the convention that prevails for
> MSTP clocks under mach-shmobile is as follows:

> 1. Clocks not registered by CLKDEV_ICK_ID() are grouped together
>     under /* MSTP */ followed by:
> 2. Clocks registered using CLKDEV_ICK_ID() are grouped together
>     under /* ICK */

> I am unsure of the historical reason for this

    Recent patches by Morimoto-san.

> but it does seem to be consistent.

    No, it doesn't. These comments are *clearly* not consistent and should be 
removed at least.

WBR, Sergei
