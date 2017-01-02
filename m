From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [Intel-gfx] [RFC 3/4] drm/i915: valleyview: Make intel_set_rps
 get FORCEWAKE_MEDIA
Date: Mon, 2 Jan 2017 14:21:58 +0000
Message-ID: <20170102142158.GE16295@nuc-i3427.alporthouse.com>
References: <20170101201403.12132-1-hdegoede@redhat.com>
 <20170101201403.12132-4-hdegoede@redhat.com>
 <20170101202400.GG13154@nuc-i3427.alporthouse.com>
 <556a9c6d-33ba-0047-82df-8bf75e09e208@redhat.com>
 <20170102113759.GC16295@nuc-i3427.alporthouse.com>
 <20170102141049.GX31595@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.fireflyinternet.com ([109.228.58.192]:52181 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932670AbdABOWG (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 2 Jan 2017 09:22:06 -0500
Content-Disposition: inline
In-Reply-To: <20170102141049.GX31595@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Len Brown <lenb@kernel.org>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-i2c@vger.kernel.org

On Mon, Jan 02, 2017 at 04:10:49PM +0200, Ville Syrjälä wrote:
> On Mon, Jan 02, 2017 at 11:37:59AM +0000, Chris Wilson wrote:
> > On Sun, Jan 01, 2017 at 09:48:53PM +0100, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 01-01-17 21:24, Chris Wilson wrote:
> > > >On Sun, Jan 01, 2017 at 09:14:02PM +0100, Hans de Goede wrote:
> > > >>All callers of valleyview_set_rps() get at least FORCEWAKE_MEDIA, except
> > > >>for intel_set_rps(). Since intel_set_rps can for example be called from
> > > >>sysfs store functions, there is no guarantee this is already done, so add
> > > >>an intel_uncore_forcewake_get(FORCEWAKE_MEDIA) call to intel_set_rps.
> > > >>
> > > >>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > >>---
> > > >> drivers/gpu/drm/i915/intel_pm.c | 9 +++++++--
> > > >> 1 file changed, 7 insertions(+), 2 deletions(-)
> > > >>
> > > >>diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
> > > >>index 4b12637..cc4fbd7 100644
> > > >>--- a/drivers/gpu/drm/i915/intel_pm.c
> > > >>+++ b/drivers/gpu/drm/i915/intel_pm.c
> > > >>@@ -5096,9 +5096,14 @@ void gen6_rps_boost(struct drm_i915_private *dev_priv,
> > > >>
> > > >> void intel_set_rps(struct drm_i915_private *dev_priv, u8 val)
> > > >> {
> > > >>-	if (IS_VALLEYVIEW(dev_priv) || IS_CHERRYVIEW(dev_priv))
> > > >>+	if (IS_VALLEYVIEW(dev_priv) || IS_CHERRYVIEW(dev_priv)) {
> > > >>+		/* Wake up the media well, as that takes a lot less
> > > >>+		 * power than the Render well.
> > > >>+		 */
> > > >>+		intel_uncore_forcewake_get(dev_priv, FORCEWAKE_MEDIA);
> > > >> 		valleyview_set_rps(dev_priv, val);
> > > >
> > > >Both powerwells are woken for rps. (Taking one but not the other has no
> > > >benefit, and very misleading.)
> > > 
> > > The comment on why FORCEWAKE_MEDIA is used + code is copy pasted from the
> > > existing code in vlv_set_rps_idle().
> > 
> > It's not correct there either...
> 
> Why not? If the render well is in rc6 already we don't want to waste
> power by waking it. The only reason we have to wake up *something* is
> so that the gpll frequency actually gets changed.

If the register write requires the powerwell, the mmio access will take
the powerwell. Manually taking the wakelock has to be for a reason, the
one given is bogus. (That is if the register write only requires meda
access that is taken, but iirc, rps requires both, so both are taken
inside.) If the claimed benefit is indeed real, and there is indeed
freedom of choice, we want that inside the mmio accessor to choose the
cheaper well.
-Chris

-- 
Chris Wilson, Intel Open Source Technology Centre
