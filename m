From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: Re: [PATCH 5/5] i2c: mux: pca954x: Add irq_mask_en to delay enabling
 irqs
Date: Thu, 5 Jan 2017 11:31:19 +0800
Message-ID: <dd7a34b0-9390-b035-0d81-e216204eab39@electromag.com.au>
References: <1483522197-38819-1-git-send-email-preid@electromag.com.au>
 <1483522197-38819-6-git-send-email-preid@electromag.com.au>
 <2bc78ee3-be23-40b8-54ca-90bb2cc05a47@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2bc78ee3-be23-40b8-54ca-90bb2cc05a47-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 4/01/2017 22:21, Peter Rosin wrote:
> On 2017-01-04 10:29, Phil Reid wrote:
>> Unfortunately some hardware device will assert their irq line immediately
>> on power on and provide no mechanism to mask the irq. As the i2c muxes
>> provide no method to mask irq line this provides a work around by keeping
>> the parent irq masked until enough device drivers have loaded to service
>> all pending interrupts.
>>
>> For example the the ltc1760 assert its SMBALERT irq immediately on power
>> on. With two ltc1760 attached to bus 0 & 1 on a pca954x mux when the first
>> device is registered irq are enabled and fire continuously as the second
>> device driver has not yet loaded. Setting this parameter to 0x3 while
>> delay the irq being enabled until both devices are ready.
>
> I think this also needs a comment in the code, including a description
> of the limitations. If the interrupt is shared between two devices on
> the same bus, you would have the exact same problem and this workaround
> would be no good...
>
> Overall, this series fixes the issues I had with the patch from half
> a year ago or so. Thanks!
>
> With nitpicks fixed,
> Acked-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
>
G'day Pater,

Thanks for the review. v2 on it's way.


-- 
Regards
Phil Reid

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
