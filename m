From: Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH v2] i2c-s3c2410: Remove unconditional 1ms delay on each
 transfer
Date: Mon, 5 Apr 2010 23:44:02 +0100
Message-ID: <20100405224402.GA32401@fluff.org.uk>
References: <1270214109-28226-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1270214109-28226-1-git-send-email-broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Apr 02, 2010 at 02:15:09PM +0100, Mark Brown wrote:
> The S3C I2C controller indicates completion of I2C transfers before
> the bus has a stop condition on it. In order to ensure that we do not
> attempt to start a new transfer before the bus is idle the driver
> currently inserts a 1ms delay. This is vastly larger than is generally
> required and has a visible effect on performance under load, such as
> when bringing up audio CODECs or reading back status information with
> non-bulk I2C reads.

ok, so far no problems with this on an s3c2440. I'll add it to the
next tree.

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
