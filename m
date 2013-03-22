From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: designware: add CONFIG_PM_SLEEP to
 suspend/resume functions
Date: Fri, 22 Mar 2013 12:46:34 +0100
Message-ID: <20130322114634.GA24508@the-dreams.de>
References: <00b901ce26a2$cb3c57d0$61b50770$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <00b901ce26a2$cb3c57d0$61b50770$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: 'Wolfram Sang' <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Ben Dooks' <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Mar 22, 2013 at 11:13:07AM +0900, Jingoo Han wrote:
> Add CONFIG_PM_SLEEP to suspend/resume functions to fix the following
> build warning when CONFIG_PM_SLEEP is not selected. This is because
> sleep PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
> the CONFIG_PM_SLEEP is enabled.
> 
> drivers/i2c/busses/i2c-designware-platdrv.c:253:12: warning: 'dw_i2c_suspend' defined but not used [-Wunused-function]
> drivers/i2c/busses/i2c-designware-platdrv.c:263:12: warning: 'dw_i2c_resume' defined but not used [-Wunused-function]
> 
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

What about doing it like the s3c2410 driver which also adds CONFIG_PM
around the whole structure? (comment applies for both patches)

Thanks,

   Wolfram
