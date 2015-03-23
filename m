From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 1/4] i2c: mux-pinctrl: Rework to honor disabled child
 nodes
Date: Mon, 23 Mar 2015 19:32:11 +0100
Message-ID: <20150323183211.GB1128@katana>
References: <55097C46.9010605@gmail.com>
 <20150318140037.GE3580@katana>
 <550A05E5.3050100@gmail.com>
 <20150319100944.GA914@katana>
 <550AEF9D.6090307@wwwdotorg.org>
 <20150319160208.GF7657@katana>
 <550B3725.10209@gmail.com>
 <20150320101925.GC2071@katana>
 <20150321210028.GA1078@katana>
 <550EBDBC.9000903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <550EBDBC.9000903-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gabriel Dobato <dobatog-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


> If modifying i2c-mux-pinctrl to respect the sub-bus status property is
> such a big issue, I'd rather leave the driver as is and expose all
> sub-busses to userspace.

Well, dunno what 'big issue' is in your book :) What definately needs to
be done is:

* handle "status" at mux-core level, not mux-driver
* that probably needs us to convert i2c_add_mux_adapter() to return
  ERR_PTRs instead of NULL, so we can distinguish the "disabled" case
* that would mean to fix all existing users

That's all not groundbreaking stuff, but needs caution and thoroughness.
There might be some gory details left, though...

Regards,

   Wolfram
