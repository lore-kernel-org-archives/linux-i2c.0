From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v2 3/5] i2c: emev2: add driver
Date: Mon, 13 Jul 2015 00:12:33 +0300
Message-ID: <2917132.jbtRA6ZB7M@avalon>
References: <1436600786-3068-1-git-send-email-wsa@the-dreams.de> <1436600786-3068-4-git-send-email-wsa@the-dreams.de> <20150711100312.GA1536@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150711100312.GA1536@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Ian Molton <ian.molton-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Saturday 11 July 2015 12:03:13 Wolfram Sang wrote:
> > +	dev_info(&pdev->dev, "Added i2c controller %d irq %d @ 0x%zx\n",
> > +		priv->adap.nr, irq, r->start);
> 
> I removed the address printout entirely. It is part of the dev_*
> printout already and I got a format warning from buildbot.

With that change,

Reviewed-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

-- 
Regards,

Laurent Pinchart
