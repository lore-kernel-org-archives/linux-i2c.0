From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v3 12/12] drm/i915: Listen for PMIC bus access notifications
Date: Thu, 16 Feb 2017 21:02:10 +0200
Message-ID: <87inoadknh.fsf@intel.com>
References: <20170210102802.20898-1-hdegoede@redhat.com> <20170210102802.20898-13-hdegoede@redhat.com> <20170216184449.GN31595@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:2803 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932379AbdBPTCa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 16 Feb 2017 14:02:30 -0500
In-Reply-To: <20170216184449.GN31595@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>
Cc: Daniel Vetter <daniel.vetter@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

On Thu, 16 Feb 2017, Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
> On Fri, Feb 10, 2017 at 11:28:02AM +0100, Hans de Goede wrote:
>> Listen for PMIC bus access notifications and get FORCEWAKE_ALL while
>> the bus is accessed to avoid needing to do any forcewakes, which need
>> PMIC bus access, while the PMIC bus is busy:
>> 
>> This fixes errors like these showing up in dmesg, usually followed
>> by a gfx or system freeze:
>> 
>> [drm:fw_domains_get [i915]] *ERROR* render: timed out waiting for forcewake ack request.
>> [drm:fw_domains_get [i915]] *MEDIA* render: timed out waiting for forcewake ack request.
>> i2c_designware 808622C1:06: punit semaphore timed out, resetting
>> i2c_designware 808622C1:06: PUNIT SEM: 2
>> i2c_designware 808622C1:06: couldn't acquire bus ownership
>> 
>> Downside of this approach is that it causes wakeups whenever the PMIC
>> bus is accessed. Unfortunately we cannot simply wait for the PMIC bus
>> to go idle when we hit a race, as forcewakes may be done from interrupt
>> handlers where we cannot sleep to wait for the i2c PMIC bus access to
>> finish.
>> 
>> Note that the notifications and thus the wakeups will only happen on
>> baytrail / cherrytrail devices using PMICs with a shared i2c bus for
>> P-Unit and host PMIC access (i2c busses with a _SEM method in their
>> APCI node), e.g. an axp288 PMIC.
>> 
>> I plan to write some patches for drivers accessing the PMIC bus to
>> limit their bus accesses to a bare minimum (e.g. cache registers, do not
>> update battery level more often then 4 times a minute), to limit the
>> amount of wakeups.
>> 
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=155241
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> Tested-by: tagorereddy <tagore.chandan@gmail.com>
>
> I gave the previous versions a quick whirl on a few machines here, but
> them not being CR versions I guess this stuff doesn't kick in at all.
> And I don't see any _SEM stuff in the DSDT/SSDT, so I guess that
> confirms it. Which is fine since I've not seem any stability issues
> on those machines. So at least nothing seemed to break :)
>
> Anyways the changes look all right to me, so for both i915 patches
> Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

Acked-by: Jani Nikula <jani.nikula@intel.com>

for merging the i915 patches through some other tree if that makes
managing the pile easier.


>
>> ---
>> Changes in v2:
>> -Spelling: P-Unit, PMIC
>> Changes in v3:
>> -Improve comment explaining why we call intel_uncore_forcewake_get(ALL) on
>>  MBI_PMIC_BUS_ACCESS_BEGIN notification
>> ---
>>  drivers/gpu/drm/i915/Kconfig        |  1 +
>>  drivers/gpu/drm/i915/i915_drv.h     |  1 +
>>  drivers/gpu/drm/i915/intel_uncore.c | 39 +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 41 insertions(+)
>> 
>> diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
>> index 1ae0bb9..a5cd5da 100644
>> --- a/drivers/gpu/drm/i915/Kconfig
>> +++ b/drivers/gpu/drm/i915/Kconfig
>> @@ -20,6 +20,7 @@ config DRM_I915
>>  	select ACPI_VIDEO if ACPI
>>  	select ACPI_BUTTON if ACPI
>>  	select SYNC_FILE
>> +	select IOSF_MBI
>>  	help
>>  	  Choose this option if you have a system that has "Intel Graphics
>>  	  Media Accelerator" or "HD Graphics" integrated graphics,
>> diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
>> index 998239f..4e405d0 100644
>> --- a/drivers/gpu/drm/i915/i915_drv.h
>> +++ b/drivers/gpu/drm/i915/i915_drv.h
>> @@ -725,6 +725,7 @@ struct intel_uncore {
>>  	const struct intel_forcewake_range *fw_domains_table;
>>  	unsigned int fw_domains_table_entries;
>>  
>> +	struct notifier_block pmic_bus_access_nb;
>>  	struct intel_uncore_funcs funcs;
>>  
>>  	unsigned fifo_count;
>> diff --git a/drivers/gpu/drm/i915/intel_uncore.c b/drivers/gpu/drm/i915/intel_uncore.c
>> index b6d726b..1be3cdc 100644
>> --- a/drivers/gpu/drm/i915/intel_uncore.c
>> +++ b/drivers/gpu/drm/i915/intel_uncore.c
>> @@ -25,6 +25,7 @@
>>  #include "intel_drv.h"
>>  #include "i915_vgpu.h"
>>  
>> +#include <asm/iosf_mbi.h>
>>  #include <linux/pm_runtime.h>
>>  
>>  #define FORCEWAKE_ACK_TIMEOUT_MS 50
>> @@ -436,12 +437,16 @@ static void __intel_uncore_early_sanitize(struct drm_i915_private *dev_priv,
>>  
>>  void intel_uncore_suspend(struct drm_i915_private *dev_priv)
>>  {
>> +	iosf_mbi_unregister_pmic_bus_access_notifier(
>> +		&dev_priv->uncore.pmic_bus_access_nb);
>>  	intel_uncore_forcewake_reset(dev_priv, false);
>>  }
>>  
>>  void intel_uncore_resume_early(struct drm_i915_private *dev_priv)
>>  {
>>  	__intel_uncore_early_sanitize(dev_priv, true);
>> +	iosf_mbi_register_pmic_bus_access_notifier(
>> +		&dev_priv->uncore.pmic_bus_access_nb);
>>  	i915_check_and_clear_faults(dev_priv);
>>  }
>>  
>> @@ -1329,6 +1334,32 @@ static void intel_uncore_fw_domains_init(struct drm_i915_private *dev_priv)
>>  	dev_priv->uncore.fw_domains_table_entries = ARRAY_SIZE((d)); \
>>  }
>>  
>> +static int i915_pmic_bus_access_notifier(struct notifier_block *nb,
>> +					 unsigned long action, void *data)
>> +{
>> +	struct drm_i915_private *dev_priv = container_of(nb,
>> +			struct drm_i915_private, uncore.pmic_bus_access_nb);
>> +
>> +	switch (action) {
>> +	case MBI_PMIC_BUS_ACCESS_BEGIN:
>> +		/*
>> +		 * forcewake all now to make sure that we don't need to do a
>> +		 * forcewake later which on systems where this notifier gets
>> +		 * called requires the punit to access to the shared pmic i2c
>> +		 * bus, which will be busy after this notification, leading to:
>> +		 * "render: timed out waiting for forcewake ack request."
>> +		 * errors.
>> +		 */
>> +		intel_uncore_forcewake_get(dev_priv, FORCEWAKE_ALL);
>> +		break;
>> +	case MBI_PMIC_BUS_ACCESS_END:
>> +		intel_uncore_forcewake_put(dev_priv, FORCEWAKE_ALL);
>> +		break;
>> +	}
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
>>  void intel_uncore_init(struct drm_i915_private *dev_priv)
>>  {
>>  	i915_check_vgpu(dev_priv);
>> @@ -1338,6 +1369,8 @@ void intel_uncore_init(struct drm_i915_private *dev_priv)
>>  	__intel_uncore_early_sanitize(dev_priv, false);
>>  
>>  	dev_priv->uncore.unclaimed_mmio_check = 1;
>> +	dev_priv->uncore.pmic_bus_access_nb.notifier_call =
>> +		i915_pmic_bus_access_notifier;
>>  
>>  	switch (INTEL_INFO(dev_priv)->gen) {
>>  	default:
>> @@ -1392,6 +1425,9 @@ void intel_uncore_init(struct drm_i915_private *dev_priv)
>>  	if (INTEL_GEN(dev_priv) >= 8)
>>  		intel_shadow_table_check();
>>  
>> +	iosf_mbi_register_pmic_bus_access_notifier(
>> +		&dev_priv->uncore.pmic_bus_access_nb);
>> +
>>  	i915_check_and_clear_faults(dev_priv);
>>  }
>>  #undef ASSIGN_WRITE_MMIO_VFUNCS
>> @@ -1399,6 +1435,9 @@ void intel_uncore_init(struct drm_i915_private *dev_priv)
>>  
>>  void intel_uncore_fini(struct drm_i915_private *dev_priv)
>>  {
>> +	iosf_mbi_unregister_pmic_bus_access_notifier(
>> +		&dev_priv->uncore.pmic_bus_access_nb);
>> +
>>  	/* Paranoia: make sure we have disabled everything before we exit. */
>>  	intel_uncore_sanitize(dev_priv);
>>  	intel_uncore_forcewake_reset(dev_priv, false);
>> -- 
>> 2.9.3

-- 
Jani Nikula, Intel Open Source Technology Center
