From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 3/6] Minor typos in i2c/algos/Kconfig
Date: Wed, 13 Feb 2008 10:00:23 +0100
Message-ID: <20080213100023.1ea844e3@hyperion.delvare>
References: <20080121142010.988419876@pengutronix.de>
	<20080121143657.830988061@pengutronix.de>
	<20080123210840.3f4a78e6@hyperion.delvare>
	<fna4sv$ch6$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <fna4sv$ch6$1@ger.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 24 Jan 2008 14:47:11 +0100, Wolfram Sang wrote:
> Jean Delvare wrote:
> > On Mon, 21 Jan 2008 15:20:13 +0100, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org wrote:
> >> This patch corrects some minor typos. The term "below" in these paragraphs
> >> might also be replaced by "later" or something similar?
> > You're right, this is a remnant from the times where all the i2c
> > options were in a single menu. Nowadays, 'under "I2C Hardware Bus
> > support"' would be more appropriate. Or... nothing at all. After all,
> > the i2c "algorithm" modules are selected automatically whenever a
> > driver that relies on them is selected. They are visible in the menu
> > only so that one can enable them for an hypothetical out-of-tree driver
> > - but I doubt that this is terribly useful. So a 3rd option would be to
> > simply remove these items from the configuration menu.
>
> I support the idea of removing them. If there is an out-of-tree driver, 
> it will find a way to set the algorithm from outside. Shall I make such 
> a patch, if there are no further objections?

I will send such a patch later today.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
