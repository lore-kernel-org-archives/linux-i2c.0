From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/13] i2c: sirf: use clk_prepare_enable and clk_disable_unprepare
Date: Mon, 27 Aug 2012 09:44:54 +0800
Message-ID: <CAGsJ_4zSsnyJ0sn385g_1OvGXTwXbW-E1P_o7EWtM75+CSxDww@mail.gmail.com>
References: <1345996865-32082-1-git-send-email-Julia.Lawall@lip6.fr> <1345996865-32082-5-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1345996865-32082-5-git-send-email-Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Wolfram Sang (embedded platforms)" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, DL-SHA-WorkGroupLinux <workgroup.linux-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2012/8/27 Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>:
> From: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
>
> Clk_prepare_enable and clk_disable_unprepare combine clk_prepare and
> clk_enable, and clk_disable and clk_unprepare.  They make the code more
> concise, and ensure that clk_unprepare is called when clk_enable fails.
>
> A simplified version of the semantic patch that introduces calls to these
> functions is as follows: (http://coccinelle.lip6.fr/)
>
> // <smpl>
> @@
> expression e;
> @@
>
> - clk_prepare(e);
> - clk_enable(e);
> + clk_prepare_enable(e);
>
> @@
> expression e;
> @@
>
> - clk_disable(e);
> - clk_unprepare(e);
> + clk_disable_unprepare(e);
> // </smpl>
>
> Signed-off-by: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>

Acked-by: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
