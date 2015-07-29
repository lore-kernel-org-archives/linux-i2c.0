From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: Regression in v4.2-rc1 caused by hierarchical irqdomain
 changes
Date: Wed, 29 Jul 2015 23:03:13 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1507292245000.3825@nanos>
References: <20150727152107.GA3571@codeblueprint.co.uk> <55B65DD8.9020002@linux.intel.com> <20150727211502.GA2492@codeblueprint.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150727211502.GA2492-mF/unelCI9GS6iBeEJttW/XRex20P6io@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Fleming <matt-mF/unelCI9GS6iBeEJttW/XRex20P6io@public.gmane.org>
Cc: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 27 Jul 2015, Matt Fleming wrote:
> [BAD]
>   3:          1          0          0          0  IR-IO-APIC   3-edge    
>   6:          0          0          0          0  IR-IO-APIC   6-edge      dw_dmac
>   7:         15          1          0          0  IR-IO-APIC   7-edge      INT3432:00, INT3433:00

[GOOD]
>   3:         16         17         49         20  IR-IO-APIC-fasteoi   AudioDSP, dw_dmac
>   6:          0          0          0          0  IR-IO-APIC-fasteoi   dw_dmac
>   7:       2662       3072      12307       5419  IR-IO-APIC-fasteoi   INT3432:00, INT3433:00

So the old code uses fasteoi while the new one uses edge.

Jiang????
