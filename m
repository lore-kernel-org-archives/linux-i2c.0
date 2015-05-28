From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 12/12] i2c: pxa: enable/disable i2c module across msg xfer
Date: Thu, 28 May 2015 14:23:12 +0100
Message-ID: <20150528132312.GC2067@n2100.arm.linux.org.uk>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1432818224-17070-13-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1432818224-17070-13-git-send-email-vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, May 28, 2015 at 06:33:44PM +0530, Vaibhav Hiremath wrote:
> From: Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> 
> Enable i2c module/unit before transmission and disable when it finishes.
> 
> why?
> It's because the i2c bus may be distrubed if the slave device,
> typically a touch, powers on.

"disturbed"

I'd recommend that this is a DT property - not every platform is going to
want this, and as there is rudimentary I2C slave support in this driver,
this change breaks that.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
