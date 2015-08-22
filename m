From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 6/8] iio: gyro: bmg160: optimize i2c transfers in
 trigger handler
Date: Sat, 22 Aug 2015 18:29:24 +0100
Message-ID: <55D8B174.1010403@kernel.org>
References: <1439389900-10108-1-git-send-email-irina.tirdea@intel.com>
 <1439389900-10108-7-git-send-email-irina.tirdea@intel.com>
 <55D056DF.5020201@kernel.org> <20150817090943.GO19600@pengutronix.de>
 <20150821102125.GA1656@katana> <1440172701.4081.1.camel@intel.com>
 <20150822040258.GA1605@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150822040258.GA1605@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Pandruvada, Srinivas" <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org" <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Tirdea, Irina" <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 22/08/15 05:02, Wolfram Sang wrote:
> 
>>>> The series[1] I am working on implements a i2c smbus block data 
>>>> regmap
>>>> bus driver. Regmap should then automatically do a block read in
>>>> regmap_bulk_read.
>>>
>>> Hmm, so doesn't your series make Irina's series obsolete? It 
>>> addresses
>>> the same problem only at a different layer (i2c core vs. regmap), or? 
>>> It
>>> would mean that i2c client drivers which want to support byte, word, 
>>> or
>>> block transfers should be converted to regmap. I assume most of the
>>> potential candidates are register based devices anyhow. Then, regmap
>>> would be the proper abstraction layer. Have I overlooked something?
>>>
>> This is the only driver converted to use regmap, because of SPI mode
>> support. The other drivers will still use Irina's changes.
> 
> The question is if they should. Or rather be converted to regmap. It is
> an open question and I am seeking for further input.
> 
There are a fairly large number of legacy drivers where this might apply.
Do we have any real idea of how many?  I'm assuming Irina only made use
of it in ones that were of personal interest.  A quick grep suggests
10's of drivers use the block call. I'm guessing quite a few would use
it if needed for a particular board.

Do we want to insist on a much larger change (conversion to regmap)
when if this in place, a simple single functional call change will do the
job?

Jonathan
