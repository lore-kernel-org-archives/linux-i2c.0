From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-core: fix for dep-lock validator
Date: Fri, 7 Sep 2012 20:07:38 +0200
Message-ID: <20120907200738.54efd8f3@endymion.delvare>
References: <50473FC9.6000203@gmx.de>
	<5049F005.2040300@gmx.de>
	<20120907152840.4de537b3@endymion.delvare>
	<5049FD7E.9080709@gmx.de>
	<20120907162032.140f0419@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120907162032.140f0419-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 7 Sep 2012 16:20:32 +0200, Jean Delvare wrote:
> As far as performance is concerned, I thought about storing the depth
> value in struct i2c_adapter, but in fact I suspect the call to
> i2c_adapter_depth(adap) will be dropped at compilation time if
> CONFIG_PROVE_LOCKING isn't set, so the overhead should be zero.

I confirm the nonexistent overhead, except that the relevant
configuration option isn't CONFIG_PROVE_LOCKING but
CONFIG_DEBUG_LOCK_ALLOC. I think this is acceptable, that's not an
option distribution kernels would enable.

-- 
Jean Delvare
