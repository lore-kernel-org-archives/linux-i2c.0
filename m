From: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v5] i2c: Add device tree support to i2c-pnx.c
Date: Fri, 20 Apr 2012 15:14:46 +0200
Message-ID: <4F916146.1080904@antcom.de>
References: <1334913755-10466-1-git-send-email-stigge@antcom.de> <20120420120950.GA15613@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120420120950.GA15613-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kevin.wells-3arQi8VN3Tc@public.gmane.org, Srinivas Bakki <srinivas.bakki-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On 04/20/2012 02:09 PM, Wolfram Sang wrote:
>> Signed-off-by: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org> Reviewed-by: Arnd
>> Bergmann <arnd-r2nGTMty4D4@public.gmane.org> Acked-by: Wolfram Sang
>> <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> NACK! I said the approach of dropping "timeout" is OK, but unless I
> say "you may add my ack after changing this and that", please do
> not automatically add my ack. Doesn't hurt here, since I have to
> pick it up anyway.

Sorry - my apologies! Removing for next re-post.

>> Changes since v4: * Removed OF timeout property (to be added
>> later when there is consensus about how to call and handle it) *
>> Changed clock-frequency example to decimal
> 
> Thanks, I just noticed. Please drop (more precise: remove) the 
> "slave-addr" for the same reasons as "timeout".

OK, will do.

>> ret = request_irq(alg_data->irq, i2c_pnx_interrupt, -			0,
>> pdev->name, alg_data); +			  0, pdev->name, alg_data);
> 
> I know that checkpatch complains about this, but I'd prefer to
> avoid such changes unless the code before was really unreadable.

OK!

Roland
