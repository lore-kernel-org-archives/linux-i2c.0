From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 2/2] Add the of_find_i2c_device_by_node function,
	V4
Date: Tue, 1 Jul 2008 10:45:18 -0600
Message-ID: <20080701164518.GG6918@secretlab.ca>
References: <20080630230126.12482.87927.stgit@terra>
	<20080630230128.12482.79570.stgit@terra>
	<20080701170544.72051418@hyperion.delvare>
	<9e4733910807010812h30e49144v5b3012e6c156ecca@mail.gmail.com>
	<20080701182949.12119d6e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080701182949.12119d6e-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

On Tue, Jul 01, 2008 at 06:29:49PM +0200, Jean Delvare wrote:
> On Tue, 1 Jul 2008 11:12:58 -0400, Jon Smirl wrote:
> > On 7/1/08, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > > I'm fine with this patch. In particular, exporting i2c_bus_type is OK.
> > >  It was un-exported only because it had no user left, but it can be
> > >  exported again if needed.
> > 
> > Another solution would be to move drivers/of/of_i2c into the i2c
> > directory and make it part of i2c core on powerpc builds.
> 
> I don't think this is a good idea. Merging arch-specific code (or
> half-arch-specific code in this case) into arch-neutral drivers ends up
> being a pain to maintain. People will keep sending me patches for stuff
> I don't know anything about and can't help with. Having of-specific
> stuff in just one directory as is the case now sounds much better to
> me. All it's missing is a MAINTAINERS entry.

But the other side of the coin is that each driver must have
driver-specific OF code to translate data in the device tree to data
usable by the driver.  It doesn't make any sense to me for that stuff to
live anywhere other that with the driver that it supports.

g.


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
