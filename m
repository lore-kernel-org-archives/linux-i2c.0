From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] Bugfix for i2c-s3c2410
Date: Tue, 17 Feb 2009 13:10:01 +0000
Message-ID: <20090217131001.GC19758@fluff.org.uk>
References: <1234446401.9457.25.camel@petitemort>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1234446401.9457.25.camel@petitemort>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Silverstone <dsilvers-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Feb 12, 2009 at 01:46:41PM +0000, Daniel Silverstone wrote:
> I2C: Rework i2c-s3c2410 frequency calculator to be much simpler.

I think you wanted this as the subject of the patch.
 
> The platform data for the i2c-s3c2410 driver used to allow a min,
> max and desired frequency for the I2C bus. This patch reduces it
> to simply a desired frequency ceiling and corrects all the uses
> of the platform data appropriately.
> 
> This means, for example, that on a system with a 66MHz fclk, a
> request for 100KHz will achieve 65KHz which is safe and
> acceptable, rather than 378KHz which it would have achieved
> without this change.
> 
> Signed-off-by: Simtec Linux Team <linux-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
> Signed-off-by: Daniel Silverstone <dsilvers-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>

The rest of the patch is ok.

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
