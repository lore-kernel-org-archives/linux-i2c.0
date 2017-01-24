From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 06/13] i2c: designware-baytrail: Disallow the CPU to
 enter C6 or C7 while holding the punit semaphore
Date: Tue, 24 Jan 2017 11:51:44 +0200
Message-ID: <1485251504.2133.296.camel@linux.intel.com>
References: <20170123210958.18410-1-hdegoede@redhat.com>
         <20170123210958.18410-7-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7842 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbdAXJ4T (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 24 Jan 2017 04:56:19 -0500
In-Reply-To: <20170123210958.18410-7-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

On Mon, 2017-01-23 at 22:09 +0100, Hans de Goede wrote:
> On my cherrytrail tablet with axp288 pmic, just doing a bunch of
> repeated
> reads from the pmic, e.g. "i2cdump -y 14 0x34" would lookup the tablet
> in
> 1 - 3 runs guaranteed.
> 
> This seems to be causes by the cpu trying to enter C6 or C7 while we
> hold
> the punit bus semaphore, at which point everything just hangs.
> 
> Avoid this by disallowing the CPU to enter C6 or C7 before acquiring
> the
> punit bus semaphore.


> Changes in v5:
> -Update the pm_qos for a latency of 0 *before* requesting the
> semaphore,
>  instead of doing it while waiting for the request to be acked

So, that's why you put to reset_semaphore() instead of
baytrail_i2c_release(), right?

I perhaps missed your answer to my comment about that.

> > @@ -56,6 +57,8 @@ static void reset_semaphore(struct dw_i2c_dev
> > *dev)
>  	data &= ~PUNIT_SEMAPHORE_BIT;
>  	if (iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
> PUNIT_SEMAPHORE, data))
>  		dev_err(dev->dev, "iosf failed to reset punit
> semaphore during write\n");
> +
> +	pm_qos_update_request(&dev->pm_qos, PM_QOS_DEFAULT_VALUE);
>  }

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
