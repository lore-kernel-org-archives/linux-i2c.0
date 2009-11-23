From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH v2] i2c-designware updates
Date: Mon, 23 Nov 2009 23:11:43 +0000
Message-ID: <20091123231143.GA32202@fluff.org.uk>
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
> 
> There are 22 patches in total and might be slightly annoying.  I'll
> send subsequent patches only to linux-i2c.

These are all queued at:

	git://git.fluff.org/bjdooks/linux.git next-i2c-designware

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
