From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: Add support for device alias names
Date: Mon, 28 Apr 2008 17:42:20 +0200
Message-ID: <20080428174220.0860ab25@hyperion.delvare>
References: <20080428113052.6d024bda@hyperion.delvare>
	<20080428113901.2772e9d9@hyperion.delvare>
	<9e4733910804280743q2de1da62m120c607b200cafa0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <9e4733910804280743q2de1da62m120c607b200cafa0-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>, linuxppc-dev list <linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jon,

On Mon, 28 Apr 2008 10:43:35 -0400, Jon Smirl wrote:
> On 4/28/08, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> >  One thing I am still not happy with is that the aliases created have a
> >  trailing "*":
> >
> >  $ /sbin/modinfo lm90
> >  filename:       /lib/modules/2.6.25-git11/kernel/drivers/hwmon/lm90.ko
> >  author:         Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> >  description:    LM90/ADM1032 driver
> >  license:        GPL
> >  vermagic:       2.6.25-git11 mod_unload
> >  depends:        hwmon
> >  alias:          i2c:lm90*
> >  alias:          i2c:adm1032*
> >  alias:          i2c:lm99*
> >  alias:          i2c:lm86*
> >  alias:          i2c:max6657*
> >  alias:          i2c:adt7461*
> >  alias:          i2c:max6680*
> >  $
> >
> >  This would cause trouble if one I2C chip name matches the beginning of
> >  another I2C chip name and both chips are supported by different
> >  drivers. This has yet to be seen, but still, I'd like to see this
> >  problem fixed quickly.
> 
> 
> Trailing wildcard is always added by file2alias.c:
> 
>                 if (do_entry(mod->name, symval+i, alias)) {
>                         /* Always end in a wildcard, for future extension */
>                         if (alias[strlen(alias)-1] != '*')
>                                 strcat(alias, "*");
> 
> 
> Can't the match order be controlled in the makefile? For example if
> you had lm905* and lm90*, put lm905* into into the makefile first
> which will cause it to appear in the alias file first. But that would
> still cause problems if only lm90 was built and you had a lm905
> device.

That's too trickly and fragile - I'd rather make sure that wrong
matches just can't happen.

> 
> Alternatively you could change the code to append something like a
> period to the name string.
> 
> sprintf(alias, I2C_MODULE_PREFIX "%s.", id->name);

Similar to what Kay proposed. It works and we'll do that if we have to,
but if we can just get rid of the "*" I'd rather do that.

> 
> I was using macros to alter the name strings to move the PowerPC names
> into their own namespace.
> 


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
