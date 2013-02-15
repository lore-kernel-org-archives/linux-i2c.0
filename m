From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: i2c/i2c-mxs: use devm_request_and_ioremap
Date: Fri, 15 Feb 2013 20:04:32 +0100
Message-ID: <20130215190432.GA27970@the-dreams.de>
References: <1359850497-927-1-git-send-email-peterhuewe@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1359850497-927-1-git-send-email-peterhuewe-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Huewe <peterhuewe-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Feb 02, 2013 at 02:14:57PM -0000, =?utf-8?q?Peter_H=C3=BCwe_=3CPeterHuewe=40gmx=2Ede=3E?= wrote:

> Replace a call to devm_request_mem_region followed by a call to
> dev_ioremap_nocache with devm_request_and_ioremap which does the same.
> And since res_size isn't needed anymore we can remove it as well.

Since this is the only change, we better wait for devm_ioremap_resource
in 3.9.
