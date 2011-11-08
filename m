From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH V3 2/4] drivers/i2c/busses/i2c-at91.c: add new driver
Date: Tue, 8 Nov 2011 21:14:42 +0000
Message-ID: <20111108211442.GK12913@n2100.arm.linux.org.uk>
References: <7bdd6b456b0e055441cb25634c8cb6d483718f6c.1320753142.git.n.voss@weinmann.de> <20111108144115.GH20728@legolas.emea.dhcp.ti.com> <4EB9477E.8070002@atmel.com> <20111108152343.GJ20728@legolas.emea.dhcp.ti.com> <20111108182955.GH12913@n2100.arm.linux.org.uk> <20111108184447.GB24399@legolas.emea.dhcp.ti.com> <20111108185525.GI12913@n2100.arm.linux.org.uk> <20111108190200.GC24399@legolas.emea.dhcp.ti.com> <20111108193930.GJ12913@n2100.arm.linux.org.uk> <20111108195854.GD24399@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20111108195854.GD24399-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Nikolaus Voss <n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 08, 2011 at 09:58:55PM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Nov 08, 2011 at 07:39:30PM +0000, Russell King - ARM Linux wrote:
> > But, that's something very different from your statement in your previous
> > message about my alleged stance on *all* asm/*.h includes in drivers,
> > which is FALSE.
> 
> http://marc.info/?l=linux-arm-kernel&m=132077795410718&w=2
> 
> I don't see me complaining about *all* headers anywhere in that message.
> I did generalize, but I didn't stated you were complaining about *all*
> headers. Go back and read it for yourself.

I really can't believe what you're saying.

"You were (actually still is) one of the biggest source of complaints for
drivers using <mach/*> and <asm/*> includes and now you're changing your
mind ?"

That's an exact quote.

That statement is very clear in its meaning - and it doesn't match your
assertion that it doesn't mean "all" because it makes no distinction what
so ever between any of those header files.

> You see ? I was asking $author to try and use some revision register in
> order to apply erratas instead of using cpu_is_at91rm9200().

For fuck sake, - AND AGAIN - I was asking you to *qualify* your fucking
statement.  It was you who then launched an attack about irrelevant junk
like what includes and so forth.

You must be drunk this evening.  Please come back once you've sobered up.
