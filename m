From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] rtc-pcf8563: Add device ids table
Date: Wed, 23 Apr 2008 09:11:49 -0400
Message-ID: <9e4733910804230611s5ce220pda75119138e60eb2@mail.gmail.com>
References: <200804171708.32847.laurentp@cse-semaphore.com>
	<20080419162358.746b714c@hyperion.delvare> <480A2117.7020502@scram.de>
	<200804221612.06745.laurentp@cse-semaphore.com>
	<20080423131657.71d6312f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080423131657.71d6312f-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: linuxppc-dev list <linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, Alessandro Zummo <alessandro.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 4/23/08, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> Hi Laurent,
>
>
>  On Tue, 22 Apr 2008 16:11:56 +0200, Laurent Pinchart wrote:
>  > Hi Jean,
>  >
>  > On Saturday 19 April 2008 18:43, Jochen Friedrich wrote:
>  > > Jean Delvare wrote:
>
> > > > I'm not sure. I didn't have the time to look at it myself, but I am
>  > > > under the impression that the powerpc folks are tired of having to wait
>  > > > for me and may push it to Linus through their tree? That would be fine
>  > > > with me, as I don't want to be the one delaying something many
>  > > > developers want (but I also can't sign patches I've not even read.)

My company has stuck with 2.6.24 and my original patch set.  We'd like
to sync back up with mainline at some point.

> I still don't know exactly what happened there... I think I saw some
>  "OpenFirmware i2c" patches go upstream yesterday? But not the ones
>  listed below, which I thought they depended upon.
>
>
>  > > The required patches are:
>  > >
>  > > http://patchwork.ozlabs.org/linuxppc/patch?id=17833
>  > > http://patchwork.ozlabs.org/linuxppc/patch?id=17834
>  > >
>  > > which are just the forward ported patches you sent to the poweprc mailing
>  > > list some time ago:
>  > >
>  > > http://patchwork.ozlabs.org/linuxppc/patch?id=16282
>  > > http://patchwork.ozlabs.org/linuxppc/patch?id=16283
>  >
>  > Given that the required patches are just forward-ported versions of patches
>  > you sent (and thus probably reviewed as well :-)), what's the best way to get
>  > them in 2.6.26 (if at all possible) ?
>
>
> It's not that easy. A lot of new new-style i2c drivers have shown up in
>  the kernel since I wrote my patches (themselves derived heavily from
>  Jon Smirl's). Even if Jochen's patches are based on mine, we still need
>  to take a careful look on how each driver is modified, I remember for
>  example that some v4l drivers were using the original new-style driver
>  binding in a way I did not expect. So I can't just sign these patches
>  and hope they didn't break anything. It needs care, and this requires
>  time.
>
>  I will do my best to get this done before the 2.6.26 merge window
>  closes, but I can't promise anything.
>
>  --
>
> Jean Delvare
>
> _______________________________________________
>  Linuxppc-dev mailing list
>  Linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
