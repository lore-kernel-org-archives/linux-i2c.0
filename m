From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [Intel-gfx] [RFC 3/4] drm/i915: valleyview: Make intel_set_rps
 get FORCEWAKE_MEDIA
Date: Sun, 1 Jan 2017 20:24:00 +0000
Message-ID: <20170101202400.GG13154@nuc-i3427.alporthouse.com>
References: <20170101201403.12132-1-hdegoede@redhat.com>
 <20170101201403.12132-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.fireflyinternet.com ([109.228.58.192]:65356 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932229AbdAAUYO (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 1 Jan 2017 15:24:14 -0500
Content-Disposition: inline
In-Reply-To: <20170101201403.12132-4-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Len Brown <lenb@kernel.org>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-i2c@vger.kernel.org

On Sun, Jan 01, 2017 at 09:14:02PM +0100, Hans de Goede wrote:
> All callers of valleyview_set_rps() get at least FORCEWAKE_MEDIA, except
> for intel_set_rps(). Since intel_set_rps can for example be called from
> sysfs store functions, there is no guarantee this is already done, so add
> an intel_uncore_forcewake_get(FORCEWAKE_MEDIA) call to intel_set_rps.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/gpu/drm/i915/intel_pm.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
> index 4b12637..cc4fbd7 100644
> --- a/drivers/gpu/drm/i915/intel_pm.c
> +++ b/drivers/gpu/drm/i915/intel_pm.c
> @@ -5096,9 +5096,14 @@ void gen6_rps_boost(struct drm_i915_private *dev_priv,
>  
>  void intel_set_rps(struct drm_i915_private *dev_priv, u8 val)
>  {
> -	if (IS_VALLEYVIEW(dev_priv) || IS_CHERRYVIEW(dev_priv))
> +	if (IS_VALLEYVIEW(dev_priv) || IS_CHERRYVIEW(dev_priv)) {
> +		/* Wake up the media well, as that takes a lot less
> +		 * power than the Render well.
> +		 */
> +		intel_uncore_forcewake_get(dev_priv, FORCEWAKE_MEDIA);
>  		valleyview_set_rps(dev_priv, val);

Both powerwells are woken for rps. (Taking one but not the other has no
benefit, and very misleading.) The forcewake is already held by the
lower level routines, taking the wakelock in the caller is an optimisation
that is only interesting if there is a danger from the forcewake being
dropped mid-sequence (due to preemption whatever).
-Chris

-- 
Chris Wilson, Intel Open Source Technology Centre
