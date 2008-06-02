From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [patch 1/8] I2C: S3C2410: Check ACK on byte transmission
Date: Mon, 2 Jun 2008 20:29:09 +0100
Message-ID: <20080602192909.GE6226@fluff.org.uk>
References: <20080529132244.818543231@fluff.org.uk>
	<20080529132405.971048345@fluff.org.uk>
	<20080530214540.638008b7@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080530214540.638008b7-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, May 30, 2008 at 09:45:40PM +0200, Jean Delvare wrote:
> Hi Ben,
> 
> On Thu, 29 May 2008 14:22:45 +0100, Ben Dooks wrote:
> > We should check for the reception of an ACK after transmissint each
> 
> Spelling: transmitting.

fixed.
 

> > +		if (!(i2c->msg->flags & I2C_M_IGNORE_NAK)) {
> > +			if (iicstat & S3C2410_IICSTAT_LASTBIT) {
> > +				dev_dbg(i2c->dev, "WRITE: No Ack\n");
> > +
> > +				s3c24xx_i2c_stop(i2c, -ECONNREFUSED);
> > +				goto out_ack;
> > +			}
> > +		}
> > +
> 
> Do you really want to check this again when you jump to retry_write? I
> doubt it. My guess is that you want to add the code before the
> retry_write label, rather than after it.

fixed, not really a bug, but more efficient to not try and run this
through again after we've already checked the i2c master status in
the interrupt.

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
