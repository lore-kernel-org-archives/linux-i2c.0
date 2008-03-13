From: "Bryan Wu" <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/6] Blackfin I2C TWI driver updates
Date: Thu, 13 Mar 2008 09:25:49 -0700
Message-ID: <386072610803130925r3353032kc4e47d4a0948dba4@mail.gmail.com>
References: <1205479360-25240-1-git-send-email-cooloney@kernel.org>
	<20080312193718.1aa86caf@hyperion.delvare>
	<386072610803121907y499903ban37456d06d36a07a8@mail.gmail.com>
	<Pine.LNX.4.64.0803130726410.26435@pc-213-140-179-32.aina.net>
	<386072610803130050j47f2659bpbf53199c7dec4916@mail.gmail.com>
	<20080313153412.6c978e24@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080313153412.6c978e24-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: Kalle Pokki <kalle.pokki-jgfpPLbCha8@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 13, 2008 at 7:34 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> Hi Bryan, Kalle,
>
>
>  On Thu, 13 Mar 2008 15:50:59 +0800, Bryan Wu wrote:
>  > On Thu, Mar 13, 2008 at 1:43 PM, Kalle Pokki <kalle.pokki-jgfpPLbCha8@public.gmane.org> wrote:
>  > > On Thu, 13 Mar 2008, Bryan Wu wrote:
>  > >
>  > >  > I understand. It is too late.
>  > >  >
>  > >  > Actually, I plan to send out these for 2.6.26 at first. But found
>  > >  > following BF54x compiling error:
>  > >
>  > >  Please post a fix for the compile error in 2.6.25. As Jean pointed out,
>  > >  build and bug fixes should always be sent upstream asap, without waiting
>  > >  for the next merge window.
>  >
>  > [PATCH 2/6]  is to fix this compile error bug.
>  > So Jean, could you please just merge
>  > patch 1/6 and patch 2/6 for 2.6.25, while others for 2.6.26?
>
>  I can't believe that this patch is the easiest way to fix the build
>  failure. I seem to understand that the problem is one of the Blackfin
>  machines missing the proper header definitions? Then I suggest that you
>  simply exclude this machine in Kconfig. This fixes the build failure in
>  one line, which is perfectly acceptable at this point of the release
>  cycle.
>

OK, Killing BF54x from drivers/i2c/busses/Kconfig is acceptable.
And the whole i2c function of BF54x will be disabled in 2.6.25, it
will be fixed in 2.6.26, right?

>  > (...)
>
> > >  Actually, patch 1/6 seems to be a real bug fix. In the current code the
>  > >  i2c-bfin-twi master transmit is broken for all drivers requiring a restart
>  > >  condition.
>  >
>  > So patch 1/6 and patch 2/6 is ready for 2.6.25, don't they?
>
>  The problem is that these are the 2 biggest patches of the series,
>  summing up to 30 kB. This is really more than I want to take at this
>  point of the release cycle.
>
>  Patch 1/6 looks more like a new feature to me. The bug was not that
>  some transaction types were not supported, but that the driver
>  advertised them as being supported. So the proper fix (again, because
>  we are late in the release cycle) would be to adjust the advertised
>  functionality bitmap. That being said, I doubt that it will really help
>  in practice, if a chip driver needs one of the missing transaction
>  types, it will fail both ways. So I won't insist on changing this for
>  2.6.25.
>
>  For patch 2/6, see what I wrote above, I'd prefer that we adjust
>  Kconfig to avoid the build breakage in 2.6.25, and add the large patch
>  in 2.6.26.
>

In fact, this patch set was sent out before. While some BF54x i2c header
change was merged, patch 2/6 was queued for a long. So it introduced
this compile error.

>  On a general note, the patch summaries and header comments should
>  really tell that they fix build failures or bugs when they do. Here
>  patches 1/6 and 2/6 both say that they "add" something, not that they
>  "fix" something; this made it hard for me to figure out what was
>  needed for 2.6.25 and what wasn't (leaving aside the patch size
>  considerations for a moment.)
>

Yes, originally they are fuction-adding patches, not bug fixing. I
agree with to workaround in 2.6.25
and added this patches to 2.6.26 to both adding new functions and
fixing compile bug.

I will send out the Kconfig fixing patch soon.

Thanks a lot
-Bryan Wu

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
