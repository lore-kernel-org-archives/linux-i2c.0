From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 4/4] ARM: dts: mvebu: Introduce a new compatible string
 for mv64xxx-i2c
Date: Mon, 24 Jun 2013 11:54:51 +0200
Message-ID: <51C8176B.4000807@free-electrons.com>
References: <1371821529-13791-1-git-send-email-gregory.clement@free-electrons.com> <1371821529-13791-5-git-send-email-gregory.clement@free-electrons.com> <20130621140707.GO31667@titan.lakedaemon.net> <51C46001.30500@gmail.com> <20130621171836.GC10905@obsidianresearch.com> <51C5CD57.6040200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51C5CD57.6040200-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ike Pan <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dan Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, David Marlin <dmarlin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Eran Ben-Avi <benavi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Chris Van Hoof <vanhoof-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Leif Lindholm <leif.lindholm-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 06/22/2013 06:14 PM, Sebastian Hesselbarth wrote:
> On 06/21/2013 07:18 PM, Jason Gunthorpe wrote:
>> On Fri, Jun 21, 2013 at 04:15:29PM +0200, Sebastian Hesselbarth wrote:
>>> from a quick check of the patch set (which you forgot to send to LKML)
>>> I am wondering why you didn't update the of matches struct with the new
>>> compatible for "marvell,mv78230-i2c"? This will save you from still
>>> having "marvell,mv64xxx-i2c" as additional compatible to match device
>>> and driver. With that the above should also be s/and/or/.
>>
>> Agree, I noticed the same things.
>>
>> Alos, the compatible string should be:
>>
>>    compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
>>
>> (note the order reversal, most specific is first)
> 
> Actually, I suggest to use "marvell,mv78230-i2c" alone. With a new
> entry in the match table it will be sufficient for matching driver and

I would prefer using a specialization rather than a new entry, so I can just
use the "marvell,mv64xxx-i2c" entry for the data pointer .

> device. BTW, is mv78230 sufficient to match all SoC variants having
> this feature? Maybe mv78xx0 but that could interfere with Discovery
> Innovation or even better armada-xp-i2c (or armada-370-i2c)?

I am pretty sure that the convention in the device tree is to always use
specific product numbers, rather than wildcards. So, here, the choice of
mv78230 was just that we can see the mv78260 and mv78460 as extension of
the mv78230, so I chose the smallest common denominator.

> 
>> and I think it is better to use the 'data' field of of_device_id than
>> a of_is_compatible call. The former is sensitive to order of the
>> compatible string, the latter is not.
> 
> IMHO as long as there is only one compatible and only a bool to set,
> using of_device_is_compatible without data pointer is fine here.
> IIRC sunxi i2c isn't using data pointer the different register offset
> struct, so we shouldn't for a simple bool. And casting a bool to
> (void *) looks awkward.
> 
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
