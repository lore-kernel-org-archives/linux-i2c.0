From: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>
Subject: Re: [PATCH] Define a NO_GPIO macro to compare against and to use as
 an invalid GPIO
Date: Sun, 10 Feb 2008 18:59:39 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802101856460.4417@axis700.grange>
References: <Pine.LNX.4.64.0801311624370.8478@axis700.grange>
 <200802081543.42467.david-b@pacbell.net> <Pine.LNX.4.64.0802100053450.7517@axis700.grange>
 <200802091727.42628.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753911AbYBJR7j@vger.kernel.org>
In-Reply-To: <200802091727.42628.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

David, you convinced me:-) I'll redo the patch. Just one comment:

On Sat, 9 Feb 2008, David Brownell wrote:

> On Saturday 09 February 2008, Guennadi Liakhovetski wrote:
> 
> > And when those platforms share drivers, problems  
> > arise. And the simple and efficient NO_IRQ notion, that would fis those 
> > problems nicely, cannot seem to establish itself.
> 
> Inertia is one of the problems there ... plus, the only
> obvious advantage of "#define NO_IRQ 0" is that it makes
> it easier to be lazy about initialization.
> 
> Plus, changing platforms to use that convention means they
> mostly need to adopt an *unnatural* step of mapping from the
> hardware IRQ numbers (which often start at zero, as they do
> on one system I just ssh'd into) to some "logical" ID.
> Even if you believe that's worthwhile, it's work; and it
> could easily break something.

NO_IRQ doesn't have to be 0. Platforms, where 0 is a valid number can use 
-1, or 256, or whatever they want:-)

Thanks
Guennadi
---
Guennadi Liakhovetski
