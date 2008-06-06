From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 3/4] i2c: Use i2c_listener in driver f75375s
Date: Fri, 6 Jun 2008 13:38:46 +0200
Message-ID: <20080606133846.55238b3c@hyperion.delvare>
References: <20080604201334.19636f30@hyperion.delvare>
	<20080604203322.472f8653@hyperion.delvare>
	<4847A4E2.9040406@movial.fi>
	<20080605110659.3456fbe4@hyperion.delvare>
	<48490FA3.8020702@movial.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <48490FA3.8020702-WgUW+8SLYMv1KXRcyAk9cg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Riku Voipio <riku.voipio-WgUW+8SLYMv1KXRcyAk9cg@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Riku,

On Fri, 06 Jun 2008 13:21:23 +0300, Riku Voipio wrote:
> Jean Delvare wrote:
> > I have already tested the latter, using i2c-stub + a dump of a F75375S
> > chip. So if you can test the former (new-style) we cover the whole set
> > of possibilities and that's alright :)
> >
> > Thanks,
> >   
> I failed to get the patchset against Linux 2.6.26-rc5, and didn't have time
> to fight:
> 
>  > patch -p1 --dry-run < 
> ../p2/\[PATCH_1_4\]_i2c__Introduce_i2c_listeners.txt
> patching file include/linux/i2c.h
> Hunk #2 succeeded at 94 (offset 1 line).
> Hunk #3 succeeded at 185 (offset 1 line).
> Hunk #4 succeeded at 203 (offset 1 line).
> patching file drivers/i2c/i2c-core.c
> Hunk #1 succeeded at 43 (offset 1 line).
> Hunk #2 succeeded at 432 (offset 6 lines).
> Hunk #3 succeeded at 463 (offset 6 lines).
> Hunk #4 FAILED at 598.
> Hunk #5 succeeded at 612 (offset 7 lines).
> Hunk #6 succeeded at 796 (offset 12 lines).
> Hunk #7 succeeded at 1240 (offset -35 lines).
> 1 out of 7 hunks FAILED -- saving rejects to file drivers/i2c/i2c-core.c.rej

>From the patch header:

This patch depends on:
http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-use-class_for_each_device.patch

Did you apply that patch first?

> However, none of the functions you touched are used in F75375S driver
> with new-style loading path, so it would seem fine for me.

The part that needs testing is in i2c-core, not in the f75375s driver
itself.

That being said, I am about to post a second version of the patch set,
you probably want to wait for it before you do your tests.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
