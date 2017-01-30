From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 13/13] drm/i915: Acquire P-Unit access when modifying
 P-Unit settings
Date: Mon, 30 Jan 2017 16:02:19 +0100
Message-ID: <f3585fe1-9bc3-08a0-f747-ee0336f97965@redhat.com>
References: <20170123210958.18410-1-hdegoede@redhat.com>
 <20170123210958.18410-14-hdegoede@redhat.com>
 <20170127135147.GS31595@intel.com>
 <64a4aef7-837f-059c-9be5-4a76602488be@redhat.com>
 <2eea197f-2485-5f93-1691-42a9a2e11267@redhat.com>
 <20170130131041.GM31595@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932155AbdA3PCZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 30 Jan 2017 10:02:25 -0500
In-Reply-To: <20170130131041.GM31595@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

Hi,

On 30-01-17 14:10, Ville Syrjälä wrote:
> On Sat, Jan 28, 2017 at 06:18:45PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 01/28/2017 05:25 PM, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 01/27/2017 02:51 PM, Ville Syrjälä wrote:
>>>> On Mon, Jan 23, 2017 at 10:09:58PM +0100, Hans de Goede wrote:
>>>>> Make sure the P-Unit or the PMIC i2c bus is not in use when we send a
>>>>> request to the P-Unit by calling iosf_mbi_punit_acquire() / _release()
>>>>> around P-Unit write accesses.
>>>>
>>>> Can't we just stuff the calls into the actual punit write function
>>>> rather than sprinkling them all over the place?
>>>
>>> punit access is acquired across sections like this:
>>>
>>>         iosf_mbi_punit_acquire();
>>>
>>>         val = vlv_punit_read(dev_priv, PUNIT_REG_DSPFREQ);
>>>         val &= ~DSPFREQGUAR_MASK;
>>>         val |= (cmd << DSPFREQGUAR_SHIFT);
>>>         vlv_punit_write(dev_priv, PUNIT_REG_DSPFREQ, val);
>>>         if (wait_for((vlv_punit_read(dev_priv, PUNIT_REG_DSPFREQ) &
>>>                       DSPFREQSTAT_MASK) == (cmd << DSPFREQSTAT_SHIFT),
>>>                      50)) {
>>>                 DRM_ERROR("timed out waiting for CDclk change\n");
>>>         }
>>>         iosf_mbi_punit_release();
>>>
>>> Where we want to wait for the requested change to have taken
>>> effect before releasing the punit.
>
> Hmm. That's somewhat unfortunate. It also highlights a problem with the
> patch wrt. RPS. We don't wait for the GPU to actually change frequencies
> in set_rps() because that would slow things down too much. So I have to
> wonder how much luck is needed to make this workaround really effective.

So the history of this patch-set is that I wrote this patch before
writing the patch to get FORCEWAKE_ALL before the pmic bus becomes
active (patch 12/13). Since a lot of testing was done with this
patch included in the patch-set and since it seemed a good idea
regardless (given my experience with accessing the punit vs
pmic bus accesses) I decided to leave it in.

Possibly just the patch to get FORCEWAKE_ALL is enough, that one
actually fixed things for me. That is also why I made this the
last patch in the set. I asked tagorereddy to test his system
without this patch, but he did not get around to that.

After all we do tell the punit to not touch the bus by acquiring
the pmic bus semaphore from i2c-desigware-baytrail.c, so maybe
for RPS freq changes it honors that and properly waits. Maybe it
honors that for all punit requests i915 does and the only real
problem is the forcewake stuff ?

I can try to drop this patch from my queue and run without it
for a while and see if things don't regress. And also ask
tagorereddy again to test his system that way.

Does that (dropping this patch for now) sound like a good idea?

>>>> + a comment would be nice why it's there.
>>>
>>> I will add comments to the acquire calls.
>>>
>>>> Do we need a kconfig select/depends on the iosf_mbi thing? Or some
>>>> ifdefs?
>>>
>>> No, the iosf_mbi header defines empty inline versions of
>>> iosf_mbi_punit_acquire / _release if IOSF_MBI is disabled,
>>> this does mean that iosf_mbi must be builtin if the i915
>>> driver is. I'll add:
>>>
>>>     depends on DRM_I915=IOSF_MBI || IOSF_MBI=y
>>>
>>> To the i915 Kconfig to enforce this.
>>
>> Hmm, ok so that does not work (long cyclic dependency through the
>> selection of ACPI_VIDEO).
>>
>> So I've now added this instead:
>>
>> 	# iosf_mbi needs to be builtin if we are builtin
>> 	select IOSF_MBI if DRM_I915=y
>
> That's probably not going to help anyone since i915 is usually a module.

Right, that is fine, then either the IOSF_MBI symbols are available,
or IOSF_MBI is disabled and we get the inline nops from the header.

The problem scenario is DRM_I915=y and IOSF_MBI=m, which is not very
realistic IMHO, but will get triggered by the random-config testing
several contributors do and lead to an unresolved symbol error there.

Hmm, thinking about this, this hunk actually belongs in 12/13 as that
is the first patch to use iosf_mbi functions.

Regards,

Hans



>>>>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=155241
>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>> Tested-by: tagorereddy <tagore.chandan@gmail.com>
>>>>> ---
>>>>> Changes in v2:
>>>>> -Spelling: P-Unit, PMIC
>>>>> -Adjust for iosf_mbi_punit_lock/_unlock to _acquire/_release rename
>>>>> ---
>>>>>  drivers/gpu/drm/i915/intel_display.c    | 6 ++++++
>>>>>  drivers/gpu/drm/i915/intel_pm.c         | 9 +++++++++
>>>>>  drivers/gpu/drm/i915/intel_runtime_pm.c | 9 +++++++++
>>>>>  3 files changed, 24 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
>>>>> index 5604701..13e5152 100644
>>>>> --- a/drivers/gpu/drm/i915/intel_display.c
>>>>> +++ b/drivers/gpu/drm/i915/intel_display.c
>>>>> @@ -47,6 +47,7 @@
>>>>>  #include <drm/drm_rect.h>
>>>>>  #include <linux/dma_remapping.h>
>>>>>  #include <linux/reservation.h>
>>>>> +#include <asm/iosf_mbi.h>
>>>>>
>>>>>  static bool is_mmio_work(struct intel_flip_work *work)
>>>>>  {
>>>>> @@ -6421,6 +6422,8 @@ static void valleyview_set_cdclk(struct drm_device *dev, int cdclk)
>>>>>          cmd = 0;
>>>>>
>>>>>      mutex_lock(&dev_priv->rps.hw_lock);
>>>>> +    iosf_mbi_punit_acquire();
>>>>> +
>>>>>      val = vlv_punit_read(dev_priv, PUNIT_REG_DSPFREQ);
>>>>>      val &= ~DSPFREQGUAR_MASK;
>>>>>      val |= (cmd << DSPFREQGUAR_SHIFT);
>>>>> @@ -6430,6 +6433,7 @@ static void valleyview_set_cdclk(struct drm_device *dev, int cdclk)
>>>>>               50)) {
>>>>>          DRM_ERROR("timed out waiting for CDclk change\n");
>>>>>      }
>>>>> +    iosf_mbi_punit_release();
>>>>>      mutex_unlock(&dev_priv->rps.hw_lock);
>>>>>
>>>>>      mutex_lock(&dev_priv->sb_lock);
>>>>> @@ -6497,6 +6501,7 @@ static void cherryview_set_cdclk(struct drm_device *dev, int cdclk)
>>>>>      cmd = DIV_ROUND_CLOSEST(dev_priv->hpll_freq << 1, cdclk) - 1;
>>>>>
>>>>>      mutex_lock(&dev_priv->rps.hw_lock);
>>>>> +    iosf_mbi_punit_acquire();
>>>>>      val = vlv_punit_read(dev_priv, PUNIT_REG_DSPFREQ);
>>>>>      val &= ~DSPFREQGUAR_MASK_CHV;
>>>>>      val |= (cmd << DSPFREQGUAR_SHIFT_CHV);
>>>>> @@ -6506,6 +6511,7 @@ static void cherryview_set_cdclk(struct drm_device *dev, int cdclk)
>>>>>               50)) {
>>>>>          DRM_ERROR("timed out waiting for CDclk change\n");
>>>>>      }
>>>>> +    iosf_mbi_punit_release();
>>>>>      mutex_unlock(&dev_priv->rps.hw_lock);
>>>>>
>>>>>      intel_update_cdclk(dev_priv);
>>>>> diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
>>>>> index 249623d..adff84a 100644
>>>>> --- a/drivers/gpu/drm/i915/intel_pm.c
>>>>> +++ b/drivers/gpu/drm/i915/intel_pm.c
>>>>> @@ -32,6 +32,7 @@
>>>>>  #include "../../../platform/x86/intel_ips.h"
>>>>>  #include <linux/module.h>
>>>>>  #include <drm/drm_atomic_helper.h>
>>>>> +#include <asm/iosf_mbi.h>
>>>>>
>>>>>  /**
>>>>>   * DOC: RC6
>>>>> @@ -276,6 +277,7 @@ static void chv_set_memory_dvfs(struct drm_i915_private *dev_priv, bool enable)
>>>>>      u32 val;
>>>>>
>>>>>      mutex_lock(&dev_priv->rps.hw_lock);
>>>>> +    iosf_mbi_punit_acquire();
>>>>>
>>>>>      val = vlv_punit_read(dev_priv, PUNIT_REG_DDR_SETUP2);
>>>>>      if (enable)
>>>>> @@ -290,6 +292,7 @@ static void chv_set_memory_dvfs(struct drm_i915_private *dev_priv, bool enable)
>>>>>                FORCE_DDR_FREQ_REQ_ACK) == 0, 3))
>>>>>          DRM_ERROR("timed out waiting for Punit DDR DVFS request\n");
>>>>>
>>>>> +    iosf_mbi_punit_release();
>>>>>      mutex_unlock(&dev_priv->rps.hw_lock);
>>>>>  }
>>>>>
>>>>> @@ -298,6 +301,7 @@ static void chv_set_memory_pm5(struct drm_i915_private *dev_priv, bool enable)
>>>>>      u32 val;
>>>>>
>>>>>      mutex_lock(&dev_priv->rps.hw_lock);
>>>>> +    iosf_mbi_punit_acquire();
>>>>>
>>>>>      val = vlv_punit_read(dev_priv, PUNIT_REG_DSPFREQ);
>>>>>      if (enable)
>>>>> @@ -306,6 +310,7 @@ static void chv_set_memory_pm5(struct drm_i915_private *dev_priv, bool enable)
>>>>>          val &= ~DSP_MAXFIFO_PM5_ENABLE;
>>>>>      vlv_punit_write(dev_priv, PUNIT_REG_DSPFREQ, val);
>>>>>
>>>>> +    iosf_mbi_punit_release();
>>>>>      mutex_unlock(&dev_priv->rps.hw_lock);
>>>>>  }
>>>>>
>>>>> @@ -4553,6 +4558,7 @@ void vlv_wm_get_hw_state(struct drm_device *dev)
>>>>>
>>>>>      if (IS_CHERRYVIEW(dev_priv)) {
>>>>>          mutex_lock(&dev_priv->rps.hw_lock);
>>>>> +        iosf_mbi_punit_acquire();
>>>>>
>>>>>          val = vlv_punit_read(dev_priv, PUNIT_REG_DSPFREQ);
>>>>>          if (val & DSP_MAXFIFO_PM5_ENABLE)
>>>>> @@ -4582,6 +4588,7 @@ void vlv_wm_get_hw_state(struct drm_device *dev)
>>>>>                  wm->level = VLV_WM_LEVEL_DDR_DVFS;
>>>>>          }
>>>>>
>>>>> +        iosf_mbi_punit_release();
>>>>>          mutex_unlock(&dev_priv->rps.hw_lock);
>>>>>      }
>>>>>
>>>>> @@ -4988,7 +4995,9 @@ static void valleyview_set_rps(struct drm_i915_private *dev_priv, u8 val)
>>>>>      I915_WRITE(GEN6_PMINTRMSK, gen6_rps_pm_mask(dev_priv, val));
>>>>>
>>>>>      if (val != dev_priv->rps.cur_freq) {
>>>>> +        iosf_mbi_punit_acquire();
>>>>>          vlv_punit_write(dev_priv, PUNIT_REG_GPU_FREQ_REQ, val);
>>>>> +        iosf_mbi_punit_release();
>>>>>          if (!IS_CHERRYVIEW(dev_priv))
>>>>>              gen6_set_rps_thresholds(dev_priv, val);
>>>>>      }
>>>>> diff --git a/drivers/gpu/drm/i915/intel_runtime_pm.c b/drivers/gpu/drm/i915/intel_runtime_pm.c
>>>>> index c0b7e95..e66bcc8 100644
>>>>> --- a/drivers/gpu/drm/i915/intel_runtime_pm.c
>>>>> +++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
>>>>> @@ -28,6 +28,7 @@
>>>>>
>>>>>  #include <linux/pm_runtime.h>
>>>>>  #include <linux/vgaarb.h>
>>>>> +#include <asm/iosf_mbi.h>
>>>>>
>>>>>  #include "i915_drv.h"
>>>>>  #include "intel_drv.h"
>>>>> @@ -1027,6 +1028,8 @@ static void vlv_set_power_well(struct drm_i915_private *dev_priv,
>>>>>      if (COND)
>>>>>          goto out;
>>>>>
>>>>> +    iosf_mbi_punit_acquire();
>>>>> +
>>>>>      ctrl = vlv_punit_read(dev_priv, PUNIT_REG_PWRGT_CTRL);
>>>>>      ctrl &= ~mask;
>>>>>      ctrl |= state;
>>>>> @@ -1037,6 +1040,8 @@ static void vlv_set_power_well(struct drm_i915_private *dev_priv,
>>>>>                state,
>>>>>                vlv_punit_read(dev_priv, PUNIT_REG_PWRGT_CTRL));
>>>>>
>>>>> +    iosf_mbi_punit_release();
>>>>> +
>>>>>  #undef COND
>>>>>
>>>>>  out:
>>>>> @@ -1643,6 +1648,8 @@ static void chv_set_pipe_power_well(struct drm_i915_private *dev_priv,
>>>>>      if (COND)
>>>>>          goto out;
>>>>>
>>>>> +    iosf_mbi_punit_acquire();
>>>>> +
>>>>>      ctrl = vlv_punit_read(dev_priv, PUNIT_REG_DSPFREQ);
>>>>>      ctrl &= ~DP_SSC_MASK(pipe);
>>>>>      ctrl |= enable ? DP_SSC_PWR_ON(pipe) : DP_SSC_PWR_GATE(pipe);
>>>>> @@ -1653,6 +1660,8 @@ static void chv_set_pipe_power_well(struct drm_i915_private *dev_priv,
>>>>>                state,
>>>>>                vlv_punit_read(dev_priv, PUNIT_REG_DSPFREQ));
>>>>>
>>>>> +    iosf_mbi_punit_release();
>>>>> +
>>>>>  #undef COND
>>>>>
>>>>>  out:
>>>>> --
>>>>> 2.9.3
>>>>
>
