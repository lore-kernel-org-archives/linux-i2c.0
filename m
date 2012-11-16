From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: Handle i2c DMA failure properly
Date: Fri, 16 Nov 2012 13:29:12 -0200
Message-ID: <CAOMZO5De2m3=4-ONemO8UwNZK2q12HthkuiYit7MdCWwFRtMuA@mail.gmail.com>
References: <1352903508-18113-1-git-send-email-marex@denx.de>
	<CAOMZO5AVDXeu59ZwB35k_0yYx5XwTzdmtj+QXXEoQRMs7Br-KA@mail.gmail.com>
	<201211141622.22161.marex@denx.de>
	<CANqk_c-f3+a=f1QqWFxEpGcMQRqMD61eHiXNLyfzciJkzPGMRA@mail.gmail.com>
	<20121116141624.GF7313@pengutronix.de>
	<CANqk_c8xocNsdbj+FFowPjjj_7vWuZ3OEurRHc+fFF-=pYRu0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANqk_c8xocNsdbj+FFowPjjj_7vWuZ3OEurRHc+fFF-=pYRu0w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Michals <tcmichals-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Tim,

On Fri, Nov 16, 2012 at 1:24 PM, Tim Michals <tcmichals-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> My suggestion was to always clear the DMA in the reset i2c code.  This way
> if there is an error reported from the ISR or a timeout, it always clears
> it.  I've tested this approach with I2C devices connected and and doing a
> i2cdetect -r 0.

Thanks for the explanation.

Maybe you could post your proposed patch?

Thanks,

Fabio Estevam
