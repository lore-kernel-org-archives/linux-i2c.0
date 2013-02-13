From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH -mm] i2c: style cleanups after idr_alloc() conversion
Date: Wed, 13 Feb 2013 21:42:01 +0100
Message-ID: <20130213204201.GA19993@nekote.pengutronix.de>
References: <1360179649-22465-1-git-send-email-tj@kernel.org>
 <1360179649-22465-38-git-send-email-tj@kernel.org>
 <20130207152831.GA14797@sirena.org.uk>
 <20130207163247.GL2875@htj.dyndns.org>
 <20130207163958.GY4720@opensource.wolfsonmicro.com>
 <20130207165547.GO2875@htj.dyndns.org>
 <20130210114729.GB5472@nekote.pengutronix.de>
 <20130212173414.GD7348@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130212173414.GD7348-Gd/HAXX7CRxy/B6EtB590w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 12, 2013 at 09:34:14AM -0800, Tejun Heo wrote:
> Style cleanups suggested by Wolfram.
> 
> * s/res/id/ in i2c_add_numbered_adapter() so that it matches
>   i2c_add_adapter().
> 
> * Add a blank line before return in i2c_add_numbered_adapter().
> 
> This patch is purely cosmetic.
> 
> Signed-off-by: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Acked-by: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Would be nice to fold this patch into the previous one, if possible.
