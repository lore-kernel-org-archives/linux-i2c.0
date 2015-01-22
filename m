From: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-ocores: add common clock support
Date: Thu, 22 Jan 2015 22:15:40 +0300
Message-ID: <CAMo8BfJdmB-=i4bJypHzGvegxgBPafpiT_hyQXLhvzBUmE+u_g@mail.gmail.com>
References: <1421230899-7843-1-git-send-email-jcmvbkbc@gmail.com>
	<20150122144522.GF3413@katana>
	<CAMo8Bf+XJY_bY+OB2i_SZQmAavwERG39BR8FVj202V-E3UidPg@mail.gmail.com>
	<20150122150717.GJ3413@katana>
	<87wq4e7jqy.fsf@dell.be.48ers.dk>
	<20150122185711.GA14880@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150122185711.GA14880@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Peter Korsgaard <peter-+2lRwdCCLRT2eFz/2MeuCQ@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 22, 2015 at 9:57 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> My suggestion is:
>
> 1) if there is a clk node:
>         - we get the clock rate via clock framework
>         - "clock-frequency" is describing the bus speed as usual (Note
>           that parsing here can be as simple as checking for 100kHz only.
>           Although a seperate patch could probably easily add support for
>           other bus speeds to)
>
> 2?) a new binding is present to specify the IP clock speed:
>         - is this needed? is somebody using the driver without CCF?
>         - if so, the new binding is parsed and evaluated
>         - I couldn't find an existing binding to specify a clock speed.
>           Please have a look, too. Otherwise we need to introduce sth
>           like "opencores,ip-clock-khz" probably.
>         - "clock-frequency" is describing the bus speed as usual
>
> 3) only "clock-frequency" is present:
>         - we keep the current behaviour to be backwards compatible.
>         - driver should emit a warning to convert to new style
>         - must be marked deprecated everywhere
>
> The documentation should be updated accordingly.
>
> Thoughts?

I can update my patch to do (1) and (3), leaving (2) to whoever may
need that.

-- 
Thanks.
-- Max
