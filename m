From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] i2c-mv64xxx: use subsys_initcall for early
	initialization
Date: Thu, 23 Sep 2010 13:29:27 +0100
Message-ID: <20100923122927.GA21874@sirena.org.uk>
References: <1284284129-28105-1-git-send-email-mike@compulab.co.il> <20100914232547.GD7494@trinity.fluff.org> <AANLkTi=gtXJ8zQt2kTSCCy7=Zc4R-8BDp=Z8w7u8_ua+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=gtXJ8zQt2kTSCCy7=Zc4R-8BDp=Z8w7u8_ua+-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 23, 2010 at 09:11:00AM +0200, Linus Walleij wrote:

> Makes me think of crazy things like putting a lightweight version of
> Lennars P?tterings "systemd" scheme into the kernel for resolving
> these initcalls.

We pretty much need that; it's not just the initcalls - we also need the
probes to go through in the right order, we're just using the initcall
fiddling to bodge that for now with particularly critical system
components.
