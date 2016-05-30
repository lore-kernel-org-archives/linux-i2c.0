From: Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 6/7] iio: inv_mpu6050: Reformat sample for active scan
 mask
Date: Mon, 30 May 2016 16:44:41 +0300
Message-ID: <49c4a235-29fd-aa55-d9d2-8ead5cefd737@intel.com>
References: <cover.1463582011.git.leonard.crestez@intel.com>
 <7df4b331d35e3e6a19d13ccbcb5d12f0347b660c.1463582011.git.leonard.crestez@intel.com>
 <14d4a757-f60a-40c0-03b4-c36d1b22d30e@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <14d4a757-f60a-40c0-03b4-c36d1b22d30e-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ge Gao <ggao-ktqnL0SqcGIj5TC/SZClsA@public.gmane.org>, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 05/29/2016 06:47 PM, Jonathan Cameron wrote:
> On 18/05/16 16:00, Crestez Dan Leonard wrote:
>> Right now it is possible to only enable some of the x/y/z channels, for
>> example you can enable accel_z without x or y but if you actually do
>> that what you get is actually only the x channel.
>>
>> Fix this by reformatting the hardware sample to only include the
>> requested channels.
> As it stands here there is no benefit in doing this over using the core
> demux. In fact it's considerably less efficient (fair enough that you
> are keeping it simple in the first instance).
> The patch description should make that clear.

Why is it less efficient? All it really does is a bunch of memcpy.

> I'd definitely like to see simple extension of that option to handle
> a callback to get the nearest scanmask that is possible (as an alternative
> to the static scan_masks_available list.)
> 
> This only gets interesting if we are dealing with the unaligned case and for
> these parts that only kicks in I think if the slave devices have say 3 bytes in
> their data type.  

But I want to deal with the unaligned case because it's better than
introducing odd validations on slave channels. If I added an extension
to get the nearest scanmask I would have to remove it in PATCH 7.

-- 
Regards,
Leonard
