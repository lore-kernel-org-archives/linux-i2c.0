From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] MIPS: I2C: Return -ETIMEDOUT in octeon_i2c_wait() on
	timeout
Date: Mon, 27 Sep 2010 23:12:49 +0100
Message-ID: <20100927221249.GH21564@trinity.fluff.org>
References: <1285584916-21317-1-git-send-email-walle@corscience.de> <4CA0D516.9060404@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4CA0D516.9060404-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Cc: Bernhard Walle <walle-pDveNdigDaDu9UdzE1sIFA@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, rade.bozic.ext-OYasijW0DpE@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 27, 2010 at 10:32:06AM -0700, David Daney wrote:
> On 09/27/2010 03:55 AM, Bernhard Walle wrote:
>> It doesn't make sense to set result to -ETIMEDOUT but return 0 (success)
>> afterwards. Since there's code in octeon_i2c_start() to handle the
>> error, it should be called.
>>
>> Signed-off-by: Bernhard Walle<walle-pDveNdigDaDu9UdzE1sIFA@public.gmane.org>
>
> Thanks for fixing this.
>
> Acked-by: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>

Ok, will put into my for -rc6 branch.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
