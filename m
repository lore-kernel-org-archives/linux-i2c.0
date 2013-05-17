From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 0/2] i2c: fix two wrong mem release
Date: Fri, 17 May 2013 11:43:04 +0200
Message-ID: <20130517094301.GH17056@katana>
References: <1368088044-20408-1-git-send-email-libo.chen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1368088044-20408-1-git-send-email-libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Libo Chen <libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, May 09, 2013 at 04:27:22PM +0800, Libo Chen wrote:
> fix two wrong mem release
> 
> * Changelog from v1:
>   * exchange out_error_no_irq and out_error_pin_mux  suggested by Sonic <Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>  
>   * add some new tag , make code cleanly

Thanks for the submission. I do think the proper solution would be to
convert the drivers to use the devm_* mechanisms, though. You can check
commit 857968434bb6dbda0911f38ec46b0c3d0c963771 ("i2c: davinci: update
to devm_* API") as a reference.

Thanks,

   Wolfram
