From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH -mm] i2c: style cleanups after idr_alloc() conversion
Date: Tue, 12 Feb 2013 19:00:58 +0100
Message-ID: <20130212190058.3d987d85@endymion.delvare>
References: <1360179649-22465-1-git-send-email-tj@kernel.org>
	<1360179649-22465-38-git-send-email-tj@kernel.org>
	<20130207152831.GA14797@sirena.org.uk>
	<20130207163247.GL2875@htj.dyndns.org>
	<20130207163958.GY4720@opensource.wolfsonmicro.com>
	<20130207165547.GO2875@htj.dyndns.org>
	<20130210114729.GB5472@nekote.pengutronix.de>
	<20130212173414.GD7348@htj.dyndns.org>
	<20130212173648.GE7348@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130212173648.GE7348-Gd/HAXX7CRxy/B6EtB590w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 12 Feb 2013 09:36:48 -0800, Tejun Heo wrote:
> On Tue, Feb 12, 2013 at 09:34:14AM -0800, Tejun Heo wrote:
> > Style cleanups suggested by Wolfram.
> > 
> > * s/res/id/ in i2c_add_numbered_adapter() so that it matches
> >   i2c_add_adapter().
> > 
> > * Add a blank line before return in i2c_add_numbered_adapter().
> > 
> > This patch is purely cosmetic.
> > 
> > Signed-off-by: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> JFYI, got a permanent delivery failure for w.sang-bIcnvbaLZ9NtG/3OEaXNhw@public.gmane.org
> Does anyone in i2c circle know other contact points?  If so, please
> ping him about it.

See the updated Cc list :)

-- 
Jean Delvare
