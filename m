From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Platform driver for PCA9564
Date: Sat, 19 Jan 2008 19:02:21 +0100
Message-ID: <20080119190221.6cd8bbe0@hyperion.delvare>
References: <fmqck1$uam$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <fmqck1$uam$1@ger.gmane.org>
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

Hi Wolfram,

On Fri, 18 Jan 2008 15:20:48 +0100, Wolfram Sang wrote:
> I just finished a platform driver for the PCA9564. On the way, I had to 
> change some things in i2c-algo-pca.[ch], too (like adding private data, 
> support for a reset routine and such). My question now is if the 
> i2c-pca-isa driver has to be adapted to the new algorithm or will it be 
> replaced by the platform driver anyway?

I don't know. I don't know on which systems the i2c-pca-isa driver is
used these days, so I don't know if these can instantiate platform
devices easily. I guess it shouldn't be too difficult to update the
i2c-pca-isa driver so that it still works after your changes, then you
can tag it as deprecated, and we wait for 6 months or so before we
remove it?

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
