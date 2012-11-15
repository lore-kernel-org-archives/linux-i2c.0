From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] bindings: i2c: use consistent naming for i2c binding descriptions
Date: Thu, 15 Nov 2012 15:58:14 +0000
Message-ID: <20121115155814.30AA83E194B@localhost>
References: <1352827003-24287-1-git-send-email-wolfram@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352827003-24287-1-git-send-email-wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 13 Nov 2012 18:16:43 +0100, Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> Filenames of devictree binding documentation seems to be arbitrary and
> for me it is unneeded hazzle to find the corresponding documentation for
> a specific driver.
> 
> Naming the description the same as the driver is a lot easier and makes
> sense to me since the driver defines the binding it understands.
> 
> Also, remove a reference in one source to the binding documentation, since path
> information easily gets stale.
> 
> Signed-off-by: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

Applied, thanks.

g.
