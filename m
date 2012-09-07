From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-core: fix for dep-lock validator
Date: Fri, 7 Sep 2012 16:20:32 +0200
Message-ID: <20120907162032.140f0419@endymion.delvare>
References: <50473FC9.6000203@gmx.de>
	<5049F005.2040300@gmx.de>
	<20120907152840.4de537b3@endymion.delvare>
	<5049FD7E.9080709@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5049FD7E.9080709-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 07 Sep 2012 15:58:22 +0200, Michael Lawnick wrote:
> I did not test yet, but thought already in same direction. The draw back
> of this is that there is still maximum tree depth, but we could say 8
> should be enough and the performance issue. May be introducing the depth
> into struct i2c_adapter and setting it to parent->depth + 1?

I think we are safe with max depth 8 (actually 7.) I still have to see
a setup with depth > 1, and I seriously don't expect ever seeing one
with depth > 3.

As far as performance is concerned, I thought about storing the depth
value in struct i2c_adapter, but in fact I suspect the call to
i2c_adapter_depth(adap) will be dropped at compilation time if
CONFIG_PROVE_LOCKING isn't set, so the overhead should be zero. While a
small overhead will be present if we store the value (the compiler
won't be able to optimize that away.) I couldn't find the time to check
this, though, which is why my original reply is still in my draft
folder.

-- 
Jean Delvare
