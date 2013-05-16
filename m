From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: sirf: move driver init from module_init to
 subsys_initcall
Date: Thu, 16 May 2013 11:38:49 +0200
Message-ID: <20130516093846.GA2927@katana>
References: <1368672607-5536-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1368672607-5536-1-git-send-email-Baohua.Song-kQvG35nSl+M@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org, Xiaomeng Hou <Xiaomeng.Hou-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, May 16, 2013 at 10:50:07AM +0800, Barry Song wrote:
> From: Xiaomeng Hou <Xiaomeng.Hou-kQvG35nSl+M@public.gmane.org>
> 
> if we initilize i2c bus by module_init, there are some devices which want
> initialization earlier than i2c and could not do that in time, so move i2c
> driver initilization to subsys_initcall and make i2c ready before devices
> init.
> 
> Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou-kQvG35nSl+M@public.gmane.org>
> Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>

What about deferred probing?
