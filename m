From: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-eg20t: add helper function for xfer check
Date: Mon, 23 Apr 2012 13:25:03 +0900
Message-ID: <CANKRQnhW6bH2eok5LtrW0Qg2Dis5EpC9Sae6Le+9Chkv0yQA4w@mail.gmail.com>
References: <1334817485-7121-1-git-send-email-tomoya.rohm@gmail.com>
	<20120420203937.GB12691@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120420203937.GB12691-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Apr 21, 2012 at 5:39 AM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> On Thu, Apr 19, 2012 at 03:38:04PM +0900, Tomoya MORINAGA wrote:
>> Currently, there are the same code for xfer complete check processing.
>> So, I add helper function pch_i2c_wait_for_check_xfer.
>>
>> Reported-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>> Signed-off-by: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> Both applied to next, thanks for doing this! ~120 lines saved, that's
> about 10%. And also way better maintainable, yay.

Thank you for your applied.

>
> My checkers found some other issues, for which I will send patches in a
> minute. Please have a look and test.

OK.
I'll do until this week end and report to you.

thanks,

-- 
ROHM Co., Ltd.
tomoya
