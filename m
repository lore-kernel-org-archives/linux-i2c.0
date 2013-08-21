From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 0/3] i2c-mv64xxx: Fixes and new feature for controlers
 embedded in Aramda XP
Date: Wed, 21 Aug 2013 12:44:18 +0200
Message-ID: <52149A02.1000504@free-electrons.com>
References: <1376039158-1896-1-git-send-email-gregory.clement@free-electrons.com> <5213979B.4050306@free-electrons.com> <20130820190714.GB24466@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130820190714.GB24466@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Eran Ben-Avi <benavi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ike Pan <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Chris Van Hoof <vanhoof-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Dan Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Leif Lindholm <leif.lindholm-5wv7dgnIgG8@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Marlin <dmarlin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 20/08/2013 21:07, Wolfram Sang wrote:
> 
>> Jason Cooper drooped the third patch as it conflicted with a patch from Maxime Ripard which adds the AllWinner support. Olof also asked a formal acked-by from a device tree maintainer
>> even if we already answer to Mark Rutland request.
>> 
>> Olof also requested that you take the binding update, so I am going to send a new version of this patch set with the last patch split in two parts.
> 
> Yeah, I wondered about the binding already being accepted when the driver review was not done.

As there will be a conflict for the
Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt file with the
commit "i2c: mv64xxx: Document the newly introduced allwinner
compatible", do you want that I rebase my patch set on your
i2c/for-current branch, or do you prefer to take care of the merge
conflict yourself?

> 
>> As explained earlier today, unless you really want I use be32_to_cpu in the mv64xxx_i2c_offload_msg() I won't change anything else.
> 
> I found some more (minor) issues. Expect a review by tomorrow evening.
> 

Ok I will wait for your review to send the new version

Thanks,
-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
