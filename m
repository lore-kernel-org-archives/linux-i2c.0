From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: sirf: register i2c_client from dt child-nodes
 in probe entry
Date: Wed, 23 Jan 2013 10:56:08 +0100
Message-ID: <20130123095608.GC3767@nekote.pengutronix.de>
References: <1356489017-17737-1-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1356489017-17737-1-git-send-email-Barry.Song-kQvG35nSl+M@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Dec 26, 2012 at 10:30:16AM +0800, Barry Song wrote:
> From: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
> 
> in probe() entry of i2c_driver, set the of node of adapter and
> call of_i2c_register_devices to register all i2c_client from
> dt child-nodes
> 
> Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>

Thanks, applied to for-current.
