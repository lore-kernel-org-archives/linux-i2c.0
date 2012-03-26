From: Karol Lewandowski <k.lewandowsk-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: Dynamically assign adapter id if it wasn't
 explictly specified
Date: Mon, 26 Mar 2012 11:14:20 +0200
Message-ID: <4F70336C.70205@samsung.com>
References: <1331900343-6743-1-git-send-email-k.lewandowsk@samsung.com>
 <1331900343-6743-3-git-send-email-k.lewandowsk@samsung.com>
 <4F6B4532.7090806@samsung.com> <20120322214714.GA24684@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20120322214714.GA24684-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Rade Bozic <rade.bozic.ext-OYasijW0DpE@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 22.03.2012 22:47, Wolfram Sang wrote:

>> Dear Haavard, Rade, Wolfram and Russel
>>
>> Could you review following changes for gpio, octeon, pca-platform
>> and versatile i2c controller drivers (for which you are, or were,
>> maintainers)?
>>
>> Grant requested explicit Ack to get this merged.
> 
> ? Since those are I2C patches, I was assuming that I pick them. After the merge
> window, that is. Did I miss something?

That's all fine by me. I just wanted confirmation from respective
maintainers that changes I'm doing are ok for them.

... and it looks changes to i2c-octeon are redundant in light of
the work maintainer has done. I'll drop this part and repost patch
again.

Thanks.
-- 
Karol Lewandowski | Samsung Poland R&D Center | Linux/Platform
