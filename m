From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] rtc-pcf8563: Add device ids table
Date: Sat, 19 Apr 2008 11:34:17 +0200
Message-ID: <20080419113417.19f5567a@hyperion.delvare>
References: <200804171708.32847.laurentp@cse-semaphore.com>
	<20080418235451.2643183b@i1501.lan.towertech.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080418235451.2643183b-1Z+4F8PJzVxlecnr3/Sf3RLwuzhV/fVh@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Alessandro Zummo <alessandro.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 18 Apr 2008 23:54:51 +0200, Alessandro Zummo wrote:
> On Thu, 17 Apr 2008 17:08:32 +0200
> Laurent Pinchart <laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org> wrote:
> 
> > 
> > Hi,
> > 
> > here's a patch against 2.6.25-rc8-mm2 that adds support for device tree names
> > to the rtc-pcf8563 driver.
> 
>  thanks!
>  
> > Is the new-style driver conversion patch in 2.6.25-rc8-mm2 scheduled for
> > 2.6.26 ?
> 
>  hope so! :)

Note that this patch depends on i2c patches which aren't upstream yet.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
