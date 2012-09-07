From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-core: fix for dep-lock validator
Date: Fri, 7 Sep 2012 22:51:22 +0200
Message-ID: <20120907225122.06fec12e@endymion.delvare>
References: <50473FC9.6000203@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50473FC9.6000203-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 05 Sep 2012 14:04:25 +0200, Michael Lawnick wrote:
> Documentation originally recommends to use an enum.
> This is not applicable for a tree with unlimited depth.
> This is why I use the adapter id which is expected
> to be unique and monotonic increasing with the depth of
> the tree.

For the records, "monotonic increasing with the depth of the tree"
isn't guaranteed. It is generally true, but with i2c adapter removal
and hot-plugging, it can happen that an adapter has a lower id than its
parent. For example:

* Register adapters 0, 1 and 2.
* Remove adapter 1.
* Instantiate a multiplexer on bus 2. The first child adapter will get
  number 1, and 1 < 2.

That being said, after looking at the code, I don't think lockdep cares
about locks with lower class being taken first. OTOH it cares about
locking order being always the same, and with i2c adapters coming and
going, this would have been impossible to guarantee with your first
implementation (although I very much doubt this would have been a
problem in practice.)

Of course these points are all moot anyway as we have a better
implementation which (hopefully) doesn't suffer from any of the
problems yours had.

-- 
Jean Delvare
