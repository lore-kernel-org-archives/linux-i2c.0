From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Linux irq subsys i2c interaction question
Date: Wed, 15 Mar 2017 11:03:52 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1703151102520.3554@nanos>
References: <ff19dd32-2e6a-d4a2-a4f0-f11e1316b7c1@redhat.com> <alpine.DEB.2.20.1703070942430.3584@nanos> <d2e66f4d-c868-c9d3-4c4e-d2ca3e93394e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d2e66f4d-c868-c9d3-4c4e-d2ca3e93394e@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 7 Mar 2017, Hans de Goede wrote:
> On 07-03-17 10:18, Thomas Gleixner wrote:
> > I'm a bit worried about this being hardcoded for that particular use
> > case. That also means that you cannot use the generic regmap irq handling
> > stuff and need to have your own irq magic there.
> 
> Yeah, although the amount of irqchip code needed is pretty minimal
> for this (otherwise) simple device.
> 
> > Wouldn't it be smarter to
> > mark that interrupt in some way and have that as a generic option?
> 
> Such a generic option is what I was looking for before going this
> route, so yeah +1 for that. I'm not familiar enough with the
> irq code to feel comfortable adding that, but if you can provide
> a patch, I can test it.
> 
> > Can you point me at the relevant drivers/patches?
> 
> Here is my current wip stuff (I've pushed this to a for-irq-discussion
> branch so that the commits won't go away when I rebase my wip
> branch).
> 
> mfd patches:
> https://github.com/jwrdegoede/linux-sunxi/commit/a0b9ee4ba7b8206880415351a53d5fbbd5969ba6
> https://github.com/jwrdegoede/linux-sunxi/commit/a2bff50785c31239ec699a8b43e827c40089ee1f
> https://github.com/jwrdegoede/linux-sunxi/commit/708985e8f33471976359c9ff52e2db9964e3ddf4
> 
> i2c-adapter patch:
> https://github.com/jwrdegoede/linux-sunxi/commit/88a671b3543ffd1f5f4251f4028e4a5d67d88fda
> 
> Note the mfd driver has its own irqchip using the regmap-irq.c stuff (second
> commit)
> and the trouble some irqchip driver is nested from that in the i2c-adapter
> driver
> (the last commit).

As this is anyway using it's own interrupt handler and not using the
generic regmap one, this should be fine.

Thanks,

	tglx
