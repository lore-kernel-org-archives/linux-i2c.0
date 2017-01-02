From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [Intel-gfx] [RFC 3/4] drm/i915: valleyview: Make intel_set_rps
 get FORCEWAKE_MEDIA
Date: Mon, 2 Jan 2017 17:02:25 +0200
Message-ID: <20170102150225.GA31595@intel.com>
References: <20170101201403.12132-1-hdegoede@redhat.com>
 <20170101201403.12132-4-hdegoede@redhat.com>
 <20170101202400.GG13154@nuc-i3427.alporthouse.com>
 <556a9c6d-33ba-0047-82df-8bf75e09e208@redhat.com>
 <20170102113759.GC16295@nuc-i3427.alporthouse.com>
 <20170102141049.GX31595@intel.com>
 <20170102142158.GE16295@nuc-i3427.alporthouse.com>
 <20170102144005.GZ31595@intel.com>
 <20170102145359.GF16295@nuc-i3427.alporthouse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:62414 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755504AbdABPCc (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 2 Jan 2017 10:02:32 -0500
Content-Disposition: inline
In-Reply-To: <20170102145359.GF16295@nuc-i3427.alporthouse.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Chris Wilson <chris@chris-wilson.co.uk>, Hans de Goede <hdegoede@redhat.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Len Brown <lenb@kernel.org>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-i2c@vger.kernel.org

On Mon, Jan 02, 2017 at 02:53:59PM +0000, Chris Wilson wrote:
> On Mon, Jan 02, 2017 at 04:40:05PM +0200, Ville Syrjälä wrote:
> > On Mon, Jan 02, 2017 at 02:21:58PM +0000, Chris Wilson wrote:
> > > On Mon, Jan 02, 2017 at 04:10:49PM +0200, Ville Syrjälä wrote:
> > > > On Mon, Jan 02, 2017 at 11:37:59AM +0000, Chris Wilson wrote:
> > > > > On Sun, Jan 01, 2017 at 09:48:53PM +0100, Hans de Goede wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > On 01-01-17 21:24, Chris Wilson wrote:
> > > > > > >On Sun, Jan 01, 2017 at 09:14:02PM +0100, Hans de Goede wrote:
> > > > > > >>All callers of valleyview_set_rps() get at least FORCEWAKE_MEDIA, except
> > > > > > >>for intel_set_rps(). Since intel_set_rps can for example be called from
> > > > > > >>sysfs store functions, there is no guarantee this is already done, so add
> > > > > > >>an intel_uncore_forcewake_get(FORCEWAKE_MEDIA) call to intel_set_rps.
> > > > > > >>
> > > > > > >>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > > > > >>---
> > > > > > >> drivers/gpu/drm/i915/intel_pm.c | 9 +++++++--
> > > > > > >> 1 file changed, 7 insertions(+), 2 deletions(-)
> > > > > > >>
> > > > > > >>diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
> > > > > > >>index 4b12637..cc4fbd7 100644
> > > > > > >>--- a/drivers/gpu/drm/i915/intel_pm.c
> > > > > > >>+++ b/drivers/gpu/drm/i915/intel_pm.c
> > > > > > >>@@ -5096,9 +5096,14 @@ void gen6_rps_boost(struct drm_i915_private *dev_priv,
> > > > > > >>
> > > > > > >> void intel_set_rps(struct drm_i915_private *dev_priv, u8 val)
> > > > > > >> {
> > > > > > >>-	if (IS_VALLEYVIEW(dev_priv) || IS_CHERRYVIEW(dev_priv))
> > > > > > >>+	if (IS_VALLEYVIEW(dev_priv) || IS_CHERRYVIEW(dev_priv)) {
> > > > > > >>+		/* Wake up the media well, as that takes a lot less
> > > > > > >>+		 * power than the Render well.
> > > > > > >>+		 */
> > > > > > >>+		intel_uncore_forcewake_get(dev_priv, FORCEWAKE_MEDIA);
> > > > > > >> 		valleyview_set_rps(dev_priv, val);
> > > > > > >
> > > > > > >Both powerwells are woken for rps. (Taking one but not the other has no
> > > > > > >benefit, and very misleading.)
> > > > > > 
> > > > > > The comment on why FORCEWAKE_MEDIA is used + code is copy pasted from the
> > > > > > existing code in vlv_set_rps_idle().
> > > > > 
> > > > > It's not correct there either...
> > > > 
> > > > Why not? If the render well is in rc6 already we don't want to waste
> > > > power by waking it. The only reason we have to wake up *something* is
> > > > so that the gpll frequency actually gets changed.
> > > 
> > > If the register write requires the powerwell, the mmio access will take
> > > the powerwell.
> > 
> > The register write doesn't require a power well. It's a sideband access.
> > The punit will simply not change the GPLL frequency if the GPLL is
> > currently not running (which will/can happen when all power wells are
> > asleep). That in itself doesn't sound too back (why change the
> > frequency if the thing isn't even running, right?). But the real problem
> > is that the punit will not let the voltage on the rail to drop
> > either until the new frequency gets programmed into the GPLL. Hence if
> > the GPU goes idle before we've dropped the GPLL frequency to the
> > minimum value, we will waste power by having a needlessly high voltage.
> > 
> > Originally we tried to avoid this problem via vlv_force_gfx_clock(),
> > which should just force the GPLL to turn on without powering on
> > any power wells. But that caused some spurious WARNs or something
> > IIRC, so we had to come up with another workaround. And since powering
> > either well is sufficient we chose to use the cheaper media well.
> 
> That explains set_idle() (and would be a better comment that the one
> there). But not set_rps(), since there we don't care if the write is
> delayed until the GPU is next active.

I don't see any forcewakes in set_rps()

-- 
Ville Syrjälä
Intel OTC
