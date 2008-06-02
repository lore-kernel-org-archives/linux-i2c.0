From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 3/8] I2C: S3C2410: Pass the I2C bus number via
 drivers platform data
Date: Mon, 2 Jun 2008 08:38:13 +0200
Message-ID: <20080602083813.260297e1@hyperion.delvare>
References: <20080529132244.818543231@fluff.org.uk>
	<20080529132406.387873305@fluff.org.uk>
	<20080601090706.0e29a76d@hyperion.delvare>
	<20080601215335.GK7334@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080601215335.GK7334-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

On Sun, 1 Jun 2008 22:53:35 +0100, Ben Dooks wrote:
> On Sun, Jun 01, 2008 at 09:07:06AM +0200, Jean Delvare wrote:
> > Do you plan to send this patch (and the next ones in the series) to
> > Linus yourself, or should I take them in my tree?
> 
> No, firstly these are enhancements for the next kernel, and aren't ready
> for merging yet. Secondly they form a part of a larger series that needs to
> go to Russell King to avoid any horrible merge problems as some of these
> machines require other updates.

OK, I'll leave these patches to you then.

> I was considering sending the first two patches as fixes as soon as
> possible myself as a first test to see how it all works.

Fine with me as well.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
