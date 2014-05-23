From: czankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>
Subject: Re: i2c: removal of s6000 driver
Date: Fri, 23 May 2014 10:33:06 -0700
Message-ID: <537F8652.1090807@zankel.net>
References: <20140521113029.GT2708@katana> <20140523131722.GA28143@curry>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140523131722.GA28143@curry>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oskar Schirmer <oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org" <linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org>, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Marc Gauthier <marc-66fqrpuXKgGB+jHODAdFcQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Oskar,

I might have asked you before, but do you still have the overlay for the 
S6000 somewhere laying around?

Thanks,
-Chris

On 5/23/14, 6:17 AM, Oskar Schirmer wrote:
> Hi Wolfram,
>
> On Wed, May 21, 2014 at 13:30:29 +0200, Wolfram Sang wrote:
>> I recently discovered that the I2C core of the S6000 is basically a
>> Designware IP core. For the latter we have a frequently used and updated
>> i2c driver while the S6000 driver seems to bitrot. My wish is to remove
>> the s6000 driver in favor of the DesignWare one. My question is if there
>> is someone who could test such a change on real hardware?
>> Grepping through sources, it looks to me like the only candidate in
>> mainline is the s6105, yet its defconfig doesn't even have I2C
>> activated? Can we remove this driver right away? Am I missing something?
> Removing drivers without a replacement tested and running
> doesn't make much sense, except one chooses to drop support
> for the whole S6 thing right away. Which I don't support.
>
> best regards,
>    Oskar
