From: Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>
Subject: Re: [RFC] Revert "i2c: core: Dispose OF IRQ mapping at client
 removal time"
Date: Thu, 12 Mar 2015 12:02:50 +0100
Message-ID: <20150312120250.588f0e13@north>
References: <1426095336-16108-1-git-send-email-kubakici@wp.pl>
	<20150312092326.GA1000@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150312092326.GA1000@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 12 Mar 2015 10:23:26 +0100, Wolfram Sang wrote:
> On Wed, Mar 11, 2015 at 06:35:36PM +0100, Jakub Kicinski wrote:
> > This reverts commit e4df3a0b6228
> > ("i2c: core: Dispose OF IRQ mapping at client removal time")
> > 
> > Calling irq_dispose_mapping() will destroy the mapping and
> > disassociate the IRQ from the IRQ chip to which it belongs.
> > There should be no real need to dispose of the mapping in
> > the first place.
> > 
> > Signed-off-by: Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>
> 
> There was another issue with this patch so I was going to revert it
> today anyhow. However, you were first, so I'll take your patch, adapt
> the commit message and send it out for -rc4.

Perfect, I didn't expect to get this done so quickly :)
Will I see the patch in your tree at kernel.org? [1]

Also please consider queuing this up for stable, the unfortunate patch
got it's way into 3.18 as well as 3.19.

[1]
https://git.kernel.org/cgit/linux/kernel/git/wsa/linux.git/log/?h=i2c/for-current
