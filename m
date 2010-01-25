From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v3 1/2] i2c: Add SDA and SCL pin numbers to i2c platform data
Date: Mon, 25 Jan 2010 15:27:42 -0800
Message-ID: <87eild4vf5.fsf@deeprootsystems.com>
References: <1263295031.3437.16.camel@localhost.localdomain>
	<1263974661.3546.103.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1263974661.3546.103.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org> (Philby John's message of "Wed\, 20 Jan 2010 13\:34\:21 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org> writes:

> Kevin,
>
> On Tue, 2010-01-12 at 16:47 +0530, Philby John wrote:
>> >From cb3347e45449ff16a332aa164eae24ef6a2432e6 Mon Sep 17 00:00:00 2001
>> From: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
>> Date: Mon, 11 Jan 2010 15:53:31 +0530
>> Subject: [PATCH 1/2] Add SDA and SCL pin numbers to i2c platform data
>> 
>> Patch adds SDA and SCL pin numbers to the i2c platform data
>> structure for Davinci DM355 and DM6446. This at present is
>> used for i2c bus recovery.
>> TODO: Add SDA and SCL pin number information to include all
>> Davinci platforms such as dm355-leopard, dm365, dm646x, da8xx etc.
>
>
> Will this be included in your next pull? My concern was [PATCH v3 2/2]
> would fail as it depends on data structures in this patch least it be
> pulled into the i2c git repo by Jean, though chances of that happening
> are highly unlikely. Would like to follow up with Jean once you include
> this into your tree.

Hello,

This looks good, I will queue in davinci-next for 2.6.34.

Kevin
