From: "David E. Box" <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 3/5] i2c-designware-baytrail: fix sparse warnings
Date: Wed, 11 Feb 2015 08:44:47 -0800
Message-ID: <20150211164447.GC14753@pathfinder>
References: <1423587970-19136-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1423587970-19136-3-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423587970-19136-3-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 10, 2015 at 07:06:08PM +0200, Andy Shevchenko wrote:
> There is no need to export functions that are used as the callbacks in the
> struct dw_i2c_dev. Otherwise we get the following warnings:
> 
> drivers/i2c/busses/i2c-designware-baytrail.c:63:5: warning: symbol 'baytrail_i2c_acquire' was not declared. Should it be static?
> drivers/i2c/busses/i2c-designware-baytrail.c:114:6: warning: symbol 'baytrail_i2c_release' was not declared. Should it be static?
> 
> While here, do few indentation fixes, remove i2c_dw_eval_lock_support() from
> functions exported to the modules and redundant assignment of local sem
> variable.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Acked-by: David E. Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Yep. These remained from original versions of the patch that did use them as
callbacks in struct dw_i2c_dev. Thanks.
