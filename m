From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/7] x86/platform/intel/iosf_mbi: Add a mutex for punit
 access
Date: Sun, 08 Jan 2017 17:16:34 +0200
Message-ID: <1483888594.26691.8.camel@linux.intel.com>
References: <20170108134427.8392-1-hdegoede@redhat.com>
         <20170108134427.8392-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:45756 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751691AbdAHPWj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 8 Jan 2017 10:22:39 -0500
In-Reply-To: <20170108134427.8392-2-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

On Sun, 2017-01-08 at 14:44 +0100, Hans de Goede wrote:
> One some systems the punit accesses the pmic to change various
> voltages
> through the same bus as other kernel drivers use for e.g. battery
> monitoring.
> 
> If a driver sends requests to the punit which require the punit to
> access
> the pmic bus while another driver is also accessing the pmic bus
> various
> bad things happen.
> 
> This commit adds a mutex to protect the punit against simultaneous
> accesses
> and 2 functions to lock / unlock this mutex.
> 
> Note on these systems the i2c-bus driver will request a sempahore from
> the
> punit for exclusive access to the pmic bus when i2c drivers are
> accessing
> it, but this does not appear to be sufficient, we still need to avoid
> making certain punit requests during the access window to avoid
> problems.

I'm fine with the patch, but please spell
P-Unit
PMIC

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=155241
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Tested-by: tagorereddy <tagore.chandan@gmail.com>
> ---
>  arch/x86/include/asm/iosf_mbi.h    | 31
> +++++++++++++++++++++++++++++++
>  arch/x86/platform/intel/iosf_mbi.c | 13 +++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/arch/x86/include/asm/iosf_mbi.h
> b/arch/x86/include/asm/iosf_mbi.h
> index b41ee16..91f5d16 100644
> --- a/arch/x86/include/asm/iosf_mbi.h
> +++ b/arch/x86/include/asm/iosf_mbi.h
> @@ -88,6 +88,33 @@ int iosf_mbi_write(u8 port, u8 opcode, u32 offset,
> u32 mdr);
>   */
>  int iosf_mbi_modify(u8 port, u8 opcode, u32 offset, u32 mdr, u32
> mask);
>  
> +/**
> + * iosf_mbi_punit_lock() - Lock the punit mutex
> + *
> + * One some systems the punit accesses the pmic to change various
> voltages
> + * through the same bus as other kernel drivers use for e.g. battery
> monitoring.
> + *
> + * If a driver sends requests to the punit which require the punit to
> access the
> + * pmic bus while another driver is also accessing the pmic bus
> various bad
> + * things happen.
> + *
> + * To avoid these problems this function must be called before
> accessing the
> + * punit or the pmic, be it through iosf_mbi* functions or through
> other means.
> + *
> + * Note on these systems the i2c-bus driver will request a sempahore
> from the
> + * punit for exclusive access to the pmic bus when i2c drivers are
> accessing it,
> + * but this does not appear to be sufficient, we still need to avoid
> making
> + * certain punit requests during the access window to avoid problems.
> + *
> + * This function locks a mutex, as such it may sleep.
> + */
> +void iosf_mbi_punit_lock(void);
> +
> +/**
> + * iosf_mbi_punit_unlock() - Unlock the punit mutex
> + */
> +void iosf_mbi_punit_unlock(void);
> +
>  #else /* CONFIG_IOSF_MBI is not enabled */
>  static inline
>  bool iosf_mbi_available(void)
> @@ -115,6 +142,10 @@ int iosf_mbi_modify(u8 port, u8 opcode, u32
> offset, u32 mdr, u32 mask)
>  	WARN(1, "IOSF_MBI driver not available");
>  	return -EPERM;
>  }
> +
> +static inline void iosf_mbi_punit_lock(void) {}
> +static inline void iosf_mbi_punit_unlock(void) {}
> +
>  #endif /* CONFIG_IOSF_MBI */
>  
>  #endif /* IOSF_MBI_SYMS_H */
> diff --git a/arch/x86/platform/intel/iosf_mbi.c
> b/arch/x86/platform/intel/iosf_mbi.c
> index edf2c54..75d8135 100644
> --- a/arch/x86/platform/intel/iosf_mbi.c
> +++ b/arch/x86/platform/intel/iosf_mbi.c
> @@ -34,6 +34,7 @@
>  
>  static struct pci_dev *mbi_pdev;
>  static DEFINE_SPINLOCK(iosf_mbi_lock);
> +static DEFINE_MUTEX(iosf_mbi_punit_mutex);
>  
>  static inline u32 iosf_mbi_form_mcr(u8 op, u8 port, u8 offset)
>  {
> @@ -190,6 +191,18 @@ bool iosf_mbi_available(void)
>  }
>  EXPORT_SYMBOL(iosf_mbi_available);
>  
> +void iosf_mbi_punit_lock(void)
> +{
> +	mutex_lock(&iosf_mbi_punit_mutex);
> +}
> +EXPORT_SYMBOL(iosf_mbi_punit_lock);
> +
> +void iosf_mbi_punit_unlock(void)
> +{
> +	mutex_unlock(&iosf_mbi_punit_mutex);
> +}
> +EXPORT_SYMBOL(iosf_mbi_punit_unlock);
> +
>  #ifdef CONFIG_IOSF_MBI_DEBUG
>  static u32	dbg_mdr;
>  static u32	dbg_mcr;

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
