From: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] power supply: add driver for TI BQ20Z75 gas gauge IC
Date: Thu, 2 Sep 2010 21:47:36 +0400
Message-ID: <20100902174736.GA28649@oksana.dev.rtsoft.ru>
References: <1283448586-14613-1-git-send-email-rklein@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1283448586-14613-1-git-send-email-rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, achew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 02, 2010 at 10:29:46AM -0700, rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org wrote:
> From: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> this driver depends on I2C and uses SMBUS for communication with the host.
> 
> Addressed comments from reviews by Mark Brown and Jean Delvare.
>   * Cleaned up whitespace and alignment issues
>   * changed return codes to more appropriate values
>   * change Kconfig option name to be consistent with existing devices
>   * removed global struct and moved to device specific data
>   * changed printk to dev_dbg

The driver looks good to me. But I'll wait a day or two for Jean's
and Mark's Acked-by or Reviewed-by tags before applying, just to
give them some credit for reviwing this driver.

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
irc://irc.freenode.net/bd2
