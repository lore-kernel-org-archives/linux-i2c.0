From: "Voss, Nikolaus" <N.Voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Subject: RE: [PATCH V2] drivers/i2c/busses/i2c-at91.c: fix brokeness
Date: Mon, 7 Nov 2011 12:06:52 +0100
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D087B38B2AB@wm021.weinmann.com>
References: <alpine.DEB.2.00.1111071019560.21431@gatekeeper.vosshq.de>
 <20111107094701.GF4265@legolas.emea.dhcp.ti.com>
 <EF2E73589CA71846A15D0B2CDF79505D087B38B21C@wm021.weinmann.com>
 <20111107100446.GG4265@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111107100446.GG4265-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Content-Language: de-DE
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "'balbi-l0cyMroinI0@public.gmane.org'" <balbi-l0cyMroinI0@public.gmane.org>
Cc: "'linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <'linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'>, "'linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org'" <'linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org'>, "'nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org'" <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, "'plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org'" <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, "'linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "'ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org'" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> > > IMHO, you should split this patch into three or more smaller patches.
> > > You're doing lots of different things in one commit and it'll be a
> > > pain to bisect should this cause any issues to anyone.
> >
> > I didn't split the patch because it is virtually a complete rewrite.
> > Due to the severe limitations of the old driver, I think it should
> > replace the old driver.
> 
> The final decision is up to Ben and/or Jean but I think we should always have
> incremental patches, not sure if we should allow big patches for the reasons
> above.

Splitting the patch implies the possibility to test each incremental
change independently, a possibility I don't have with my current setup as
the old driver didn't work at all for me (for example, my client needs
repeated start). I developed and tested the driver in an all or nothing-at-all
approach. Splitting the patch would be a purely academic exercise for me,
without any extra value beyond readability (which is admittedly bad now).
>From that point of view, I should maybe submit the patch as a new independent
driver (although it is a logical replacement for the old one)?

Niko
