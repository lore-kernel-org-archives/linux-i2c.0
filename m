From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: omap: Do not enable the irq always
Date: Fri, 12 Oct 2012 20:29:14 +0530
Message-ID: <50783042.2040609@ti.com>
References: <1349687116-14463-1-git-send-email-shubhrajyoti@ti.com> <87lifb7odc.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87lifb7odc.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, huzefank-l0cyMroinI0@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Friday 12 October 2012 08:01 PM, Kevin Hilman wrote:
> When using runtime PM with auto-suspend timeouts, why would you disable
> the IRQ before the runtime suspend handlers have run?   
>
> If you really want to do this, you probably should have these in the
> runtime PM callbacks.  But I'll wait until you add a more descriptive
> changelog before I can really tell why this is being done.  Based on the
> discussion in the patch from Kalle, I'm assuming this is to prevent
> interrups when I2C is being used by co-processors.  If so, plese
> describe in the changelog.
>
> That being said, doesn't the runtime suspend callback already disable
> IRQs at the device level instead of the INTC level?
I thought of not relying on the intc as the registers may be reconfigured.
> Kevin
