From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 19 3/5] Clean up error returns
Date: Tue, 22 Jan 2008 10:06:41 +1100
Message-ID: <1200956801.6807.16.camel@pasglop>
References: <20080112024737.7023.61680.stgit@terra.home>
	<20080112024743.7023.23630.stgit@terra.home>
	<20080120120730.06dd8a7f@hyperion.delvare>
	<9e4733910801200718q7304bc29q38e67580613189e4@mail.gmail.com>
Reply-To: benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <9e4733910801200718q7304bc29q38e67580613189e4-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


On Sun, 2008-01-20 at 10:18 -0500, Jon Smirl wrote:
> > So it seems to me like the polling mode code is never actually used?
> > Unless some platforms include an "empty" IRQ in their device
> > definition. Which indeed seems to be the case... but then they set
> the
> > IRQ to 0, NOT to NO_IRQ, so I'm wondering if the change you propose
> is
> > really correct.
> 
> All of this is very confusing to me, There are physical IRQs and
> virtual IRQs. Apparently zero is a legal physical IRQ but it is not a
> legal virtual IRQ. We only get virtual IRQs in this code. We need to
> get BenH to give us the right answer on these two cases.

Testing against NO_IRQ for a linux IRQ number should always be correct.

Physical IRQ numbers are remapped and shouldn't be visible to drivers,
NO_IRQ is a value that never exist for a valid logical interrupt number,
that is 0 for arch/powerpc and -1 for arch/ppc.

Ben.



_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
