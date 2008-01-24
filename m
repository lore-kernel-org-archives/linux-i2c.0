From: Kalle Pokki <kalle.pokki-jgfpPLbCha8@public.gmane.org>
Subject: Re: [PATCH] i2c-bfin-twi: Register adapter with a specific
 bus number
Date: Thu, 24 Jan 2008 12:55:56 +0200 (EET)
Message-ID: <Pine.LNX.4.64.0801241247220.26552@pc-213-140-179-32.aina.net>
References: <Pine.LNX.4.64.0801222335050.11948@pc-213-140-179-32.aina.net>
	<1201075019.6725.7.camel@roc-laptop>
	<Pine.LNX.4.64.0801231047230.30599@pc-213-140-179-32.aina.net>
	<20080123142634.2cc71cd2@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080123142634.2cc71cd2-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 23 Jan 2008, Jean Delvare wrote:

> > I don't see the point in ever defining dev->id as -1.
> 
> The point is spelled out just above:
> 
> "The reason to do so is to avoid sysfs names that only make sense when
> there are multiple adapters."
> 
> I.e., some people prefer to have their platform device named just foo
> instead of foo.0. Me, I wouldn't have bothered making an exception for
> this, but the fact is that the platform core code supports it.

OK, now I get it. I didn't even consider that the platform core handled 
this as a special case, too.

Each in-tree user of the driver already sets dev->id = 0, even if there 
is only one device, so adding the extra check wouldn't make much 
difference now.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
