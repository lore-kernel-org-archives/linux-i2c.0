From: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: i2c-ocores: Add irq support for sparc
Date: Wed, 24 Oct 2012 11:05:04 +0200
Message-ID: <5087AF40.7090105@gaisler.com>
References: <1351004637-11049-1-git-send-email-andreas@gaisler.com> <1351004637-11049-2-git-send-email-andreas@gaisler.com> <87wqyhlzfv.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87wqyhlzfv.fsf-uXGAPMMVk8amE9MCos8gUmSdvHPH+/yF@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, software-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 10/23/2012 10:13 PM, Peter Korsgaard wrote:
>>>>>> "Andreas" == Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org> writes:
>
>   Andreas> There are no platform resources of type IORESOURCE_IRQ on
>   Andreas> sparc, so the irq number is acquired in a different manner for
>   Andreas> sparc. The general case uses platform_get_irq, that internally
>   Andreas> still uses platform_get_resource.
>
> I have no idea why sparc is being odd in this regard, but assuming this
> is how it's done, I'm fine with this change.
>
> A quick grep doesn't find any other drivers doing this though:
>
> git grep -l archdata.irqs drivers | xargs grep platform_get_irq
>
> Acked-by: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>

Other drivers that work both on sparc and on other platforms usually use 
irq_of_parse_and_map on a corresponding device_node. For non-sparc 
architectures irq_of_parse_and_map sets up mappings that needs to be 
teared down on module exit. Sparc however has its own version of 
irq_of_parse_and_map that just returns the irq number using archdata.irq[].

I am trying to get through a patch platform_get_irq to work for sparc as 
well. If that eventually goes through, the CONFIG_SPARC stuff can then 
be removed cleanly from this driver withouth having to mess with 
irq_of_parse_and_map and tearing mappings down.

Another solution is to use irq_of_parse_and_map for the of-case if no 
irq was found using platform_get_irq. But that would make for more 
rearrangements and add the need for irq_dispose_mapping to be added on 
module exit as well (even though the disposing would do nothing for sparc).

Cheers,
Andreas Larsson
