From: Alessandro Zummo <alessandro.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>
Subject: Re: [PATCH] Convert pfc8563 i2c driver from old style to new
	style
Date: Tue, 19 Feb 2008 17:24:50 +0100
Message-ID: <20080219172450.0e4ccc7c@i1501.lan.towertech.it>
References: <20080121200901.15517.30253.stgit@terra.home>
	<20080219161020.61f7ec10@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080219161020.61f7ec10-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Clemens Koller <clemens.koller-IEdZaowOqhEb1SvskN2V4Q@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 19 Feb 2008 16:10:20 +0100
Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:

> Hi Jon,
> 
> On Mon, 21 Jan 2008 15:09:01 -0500, Jon Smirl wrote:
> > Convert pfc8563 i2c driver from old style to new style.
> > 
> > Signed-off-by: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> > 
> >  drivers/rtc/rtc-pcf8563.c |  107 +++++++++++----------------------------------
> >  1 files changed, 27 insertions(+), 80 deletions(-)
> 
> Preliminary note: this driver belongs to the RTC subsystem, so it will
> be up to Alessandro Zummo (Cc'd) to push this patch upstream... when it
> is ready to go there.

 A conversion to new style for this driver has already been
 pushed upstream. Adapting platforms to instantiate the device
 should be fairly easy, especially when you use the dts.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
