From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c-s3c2410: Pass I2C bus number via platform data
Date: Tue, 19 Feb 2008 17:50:51 +0100
Message-ID: <20080219175051.6c8a0fe5@hyperion.delvare>
References: <20080131112452.859942220@fluff.org.uk>
	<20080212122701.GA15415@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080212122701.GA15415-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Vincent Sanders <vince-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>, I2C List <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

On Tue, 12 Feb 2008 12:27:01 +0000, Ben Dooks wrote:
> On Thu, Jan 31, 2008 at 11:24:53AM +0000, Ben Dooks wrote:
> > Allow the platform data to specify the bus bumber of the
> > I2C bus (or automatically choose one) for the driver.
> > 
> > Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> 
> Did this get lost in the list traffic or should it have
> been sent to someone specific to get it merged during the
> now defunct merge window?

Lost in the traffic, I'm reviewing it just now, sorry.

That being said, you sent this patch on January 31st while I issued my
i2c git pull request to Linus on January 27th, so it was already too
late. If you want changes to go upstream quickly, you shouldn't wait
until the last minute for submitting them. Any change should be
included in at least one -mm (or now linux-next) release before I
consider pushing it upstream!

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
