From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c_mxs: Set ACK_MODE bit
Date: Tue, 20 Aug 2013 16:10:09 -0300
Message-ID: <CAOMZO5DTxNxoE7mDCM9UyYZSKFxQxRkiAyvCrLCuXF=ni-H51g@mail.gmail.com>
References: <1372780860-12972-1-git-send-email-fabio.estevam@freescale.com>
	<20130815100809.GE2987@katana>
	<52120D35.707@freescale.com>
	<20130820190431.GA24466@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130820190431.GA24466@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex-ynQEQJNshbs@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Christoph <cb-/RsSufbtIHM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 20, 2013 at 4:04 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>
>> According to the mx23 erratum 2727 this patch is needed.
>
> Have you measured it yourself?

No, only relying on the mx23 errata doc here.
