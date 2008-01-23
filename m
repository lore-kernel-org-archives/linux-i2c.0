From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] Convert PowerPC MPC i2c to of_platform_driver
	from platform_driver
Date: Wed, 23 Jan 2008 09:40:38 -0500
Message-ID: <9e4733910801230640u6e02ed07r476c201895d46d9f@mail.gmail.com>
References: <20080123020912.31675.48787.stgit@terra.home>
	<20080123020914.31675.35659.stgit@terra.home>
	<E1JHgdB-0002zV-F4@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <E1JHgdB-0002zV-F4-CYoMK+44s/E@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jon Loeliger <jdl-CYoMK+44s/E@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 1/23/08, Jon Loeliger <jdl-CYoMK+44s/E@public.gmane.org> wrote:
> So, like, the other day Jon Smirl mumbled:
> > Convert MPC i2c driver from a platform_driver to a
> > of_platform_driver. Add the ability to dynamically load i2c drivers
> > based on device tree names. Routine names were changed from fsl_ to
> > mpc_ to make them match the file name. Common code moved to
> > powerpc-common.* Orginal ppc driver left intact for deletion when ppc
> > arch is removed.
>
> This seems backwards to me.  I was under the impression
> that our trend was _toward_ "Freescale" and "fsl" names...?
> And aren't the drivers also already using "fsl-i2c" in the
> DTS files as called out in the b-w-o.txt too?

The routine names should match the file name which then determines the
module name. I didn't want to change the module name so I made the
routines names match the module name.

>
> Grumble long lines not hard-limited to 70-ish columns,
> yes, even in log messages... :-)
>
> jdl
>


-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
