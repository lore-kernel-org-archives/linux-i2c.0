From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] Add the of_find_i2c_device_by_node function,
	V4
Date: Tue, 1 Jul 2008 12:38:05 -0400
Message-ID: <9e4733910807010938w67bab979tfba888641debe72f@mail.gmail.com>
References: <20080630230126.12482.87927.stgit@terra>
	<20080630230128.12482.79570.stgit@terra>
	<20080701170544.72051418@hyperion.delvare>
	<9e4733910807010812h30e49144v5b3012e6c156ecca@mail.gmail.com>
	<20080701182949.12119d6e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080701182949.12119d6e-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 7/1/08, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> On Tue, 1 Jul 2008 11:12:58 -0400, Jon Smirl wrote:
>  > On 7/1/08, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
>  > > I'm fine with this patch. In particular, exporting i2c_bus_type is OK.
>  > >  It was un-exported only because it had no user left, but it can be
>  > >  exported again if needed.
>  >
>  > Another solution would be to move drivers/of/of_i2c into the i2c
>  > directory and make it part of i2c core on powerpc builds.
>
>
> I don't think this is a good idea. Merging arch-specific code (or
>  half-arch-specific code in this case) into arch-neutral drivers ends up
>  being a pain to maintain. People will keep sending me patches for stuff
>  I don't know anything about and can't help with. Having of-specific
>  stuff in just one directory as is the case now sounds much better to
>  me. All it's missing is a MAINTAINERS entry.

A side effect of this is that the small pieces of code in drivers/of
have to be compiled into stand alone modules and they may need access
to internal symbols from the subsystem. If they were directly linked
into the subsystems you wouldn't need to make the internal symbols
visible. Now the subsystems have to be careful about breaking the
in-kernel, external users of the symbols and we've made it possible
for out of tree drivers to get to internal structures.




>
>  --
>
> Jean Delvare
>


-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
