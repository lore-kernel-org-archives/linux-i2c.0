From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/5] i2c: stu300: add CONFIG_PM_SLEEP to suspend/resume
 functions
Date: Mon, 8 Apr 2013 19:33:03 +0200
Message-ID: <20130408173303.GC6865@the-dreams.de>
References: <001501ce29ee$fd997150$f8cc53f0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <001501ce29ee$fd997150$f8cc53f0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: 'Wolfram Sang' <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Ben Dooks' <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Mar 26, 2013 at 03:56:07PM +0900, Jingoo Han wrote:
> Add CONFIG_PM_SLEEP to suspend/resume functions to fix the following
> build warning when CONFIG_PM_SLEEP is not selected. This is because
> sleep PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
> the CONFIG_PM_SLEEP is enabled.
> 
> drivers/i2c/busses/i2c-stu300.c:941:12: warning: 'stu300_suspend' defined but not used [-Wunused-function]
> drivers/i2c/busses/i2c-stu300.c:950:12: warning: 'stu300_resume' defined but not used [-Wunused-function]
> 
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

My comment from http://patchwork.ozlabs.org/patch/229867/ applies also
to this series.
