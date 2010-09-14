From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c-mv64xxx: use subsys_initcall for early
	initialization
Date: Wed, 15 Sep 2010 00:25:47 +0100
Message-ID: <20100914232547.GD7494@trinity.fluff.org>
References: <1284284129-28105-1-git-send-email-mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1284284129-28105-1-git-send-email-mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Sep 12, 2010 at 11:35:29AM +0200, Mike Rapoport wrote:
> Signed-off-by: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-mv64xxx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

We really should have an i2c_initcall, but it may be difficult to move
everyone over to it. What would be lovely is some form of dependency
based initialisation, but that's probably a way off...

I'll consider this for the next merge window.
 
> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
> index 1624206..6f3d084 100644
> --- a/drivers/i2c/busses/i2c-mv64xxx.c
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> @@ -592,7 +592,7 @@ mv64xxx_i2c_exit(void)
>  	platform_driver_unregister(&mv64xxx_i2c_driver);
>  }
>  
> -module_init(mv64xxx_i2c_init);
> +subsys_initcall(mv64xxx_i2c_init);
>  module_exit(mv64xxx_i2c_exit);
>  
>  MODULE_AUTHOR("Mark A. Greer <mgreer-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>");

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
