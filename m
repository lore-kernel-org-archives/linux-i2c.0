From: Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v2 0/5] Add-Broadcom-Kona-I2C-Support
Date: Mon, 18 Nov 2013 08:12:44 -0800
Message-ID: <CAEPRUYqHj3LJtsxxD0psuLHtQPxAybUpme5hYKRrVNyuWFGg7Q@mail.gmail.com>
References: <1384462936-7906-1-git-send-email-tim.kryger@linaro.org>
	<20131115225234.GC2672@katana>
	<CAAYSxhrk6qgfy3TUdme3ge98d8Db7e=aW3LG8VfsJgjfuHAS3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAYSxhrk6qgfy3TUdme3ge98d8Db7e=aW3LG8VfsJgjfuHAS3A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Device Tree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Doc List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C List <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linaro Patches List <patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Nov 15, 2013 at 3:30 PM, Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Nov 15, 2013 at 2:52 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>
>> Fixed Kconfig sorting, squashed broken out patches 1-3 into one and
>> applied to for-next, thanks! Let me know if I should take patches 4-5
>> also, but usually they go via arm-soc. Also, please provide a "Changes
>> since V1" log which will speed up reviewing.
>
> Thanks.  It appears that when I updated the dependencies, I
> accidentally removed the change list I had planned to send.  This is
> what should have appeared in my cover letter:
>
> Changes in v2:
>   - Binding documentation is in its own patch
>   - Minor cosmetic changes
>   - Fixed bug related to improper signedness
>   - Removed superflous mutex
>   - Simplified probe function
>
> I think it would be best for the DTS changes (patches 4 and 5) to go
> through Christian's tree.

I'll pick up 4 and 5.
 thanks
   csd
