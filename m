From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 4/7] i2c: designware-baytrail: Call
 pmic_bus_access_notifier_chain
Date: Sun, 08 Jan 2017 17:23:14 +0200
Message-ID: <1483888994.26691.13.camel@linux.intel.com>
References: <20170108134427.8392-1-hdegoede@redhat.com>
         <20170108134427.8392-5-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53564 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751691AbdAHPYs (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 8 Jan 2017 10:24:48 -0500
In-Reply-To: <20170108134427.8392-5-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

On Sun, 2017-01-08 at 14:44 +0100, Hans de Goede wrote:
> Call the iosf_mbi pmic_bus_access_notifier_chain on bus acquire /
> release.
> 

FWIW:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=155241
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Tested-by: tagorereddy <tagore.chandan@gmail.com>
> ---
>  drivers/i2c/busses/i2c-designware-baytrail.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c
> b/drivers/i2c/busses/i2c-designware-baytrail.c
> index cf7a2a0..e8cf10a 100644
> --- a/drivers/i2c/busses/i2c-designware-baytrail.c
> +++ b/drivers/i2c/busses/i2c-designware-baytrail.c
> @@ -63,6 +63,8 @@ static void reset_semaphore(struct dw_i2c_dev *dev)
>  
>  	pm_qos_update_request(&dev->pm_qos, PM_QOS_DEFAULT_VALUE);
>  
> +	iosf_mbi_call_pmic_bus_access_notifier_chain(MBI_PMIC_BUS_ACC
> ESS_END,
> +						     NULL);
>  	iosf_mbi_punit_unlock();
>  }
>  
> @@ -82,6 +84,8 @@ static int baytrail_i2c_acquire(struct dw_i2c_dev
> *dev)
>  		return 0;
>  
>  	iosf_mbi_punit_lock();
> +	iosf_mbi_call_pmic_bus_access_notifier_chain(MBI_PMIC_BUS_ACC
> ESS_BEGIN,
> +						     NULL);
>  
>  	/*
>  	 * Disallow the CPU to enter C6 or C7 state, entering these
> states

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
