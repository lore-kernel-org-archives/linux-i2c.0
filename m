From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH V9] I2C driver for IMX
Date: Tue, 15 Jul 2008 17:38:05 +0100
Message-ID: <20080715163805.GL30539@fluff.org.uk>
References: <g56uvk$e6s$1@ger.gmane.org>
	<20080715135231.491c41bb@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080715135231.491c41bb-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jul 15, 2008 at 01:52:31PM +0200, Jean Delvare wrote:
> On Fri, 11 Jul 2008 09:29:29 +0300, Darius wrote:
> > Changes from V8 version:
> > 
> > - Error numbers replaced to standard numbers from errno.h
> > - Enable/Start and Disable/Stop functions merged into two Start and Stop functions
> > - Removed all unused info about slave mode
> > - Removed unused includes
> > 
> > Can somebody review functional part of this I2C driver? Because all
> > other part is already acked by ARM Linux kernel guys.
> > 
> > Signed-off-by: Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> 
> Ben, this is something for you as well.

sorry, was away for long-weekend, just sorted out a quick
review.

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
