From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH v2] i2c-designware updates
Date: Fri, 6 Nov 2009 22:25:06 +0000
Message-ID: <20091106222506.GP23772@trinity.fluff.org>
References: <4AF419B6.1000802@necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4AF419B6.1000802-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Cc: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Nov 06, 2009 at 09:42:30PM +0900, Shinya Kuribayashi wrote:
> Hi Baruch and Ben,
>
> here's v2 patchset of DesignWare I2C driver (i2c-designware.c).
> I did all test I can do for now (including arbitration tests), and
> fixed more issues left in the v1 patchset.  I think now the driver is
> in reasonable shape for the mainline, and hope gets merged.
>
> The patches which already have Baruch's Acked-by: line are logically
> same as the previous v1 patches.  For the rest are revised version of
> v1 patches, or newly added in v2.

thanks, the first pass seems ok, will give a thorough review by next
week and get a branch with them on for -next submission.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
