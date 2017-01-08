From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 3/7] i2c: designware-baytrail: Take punit lock on bus
 acquire
Date: Sun, 08 Jan 2017 17:27:19 +0200
Message-ID: <1483889239.26691.16.camel@linux.intel.com>
References: <20170108134427.8392-1-hdegoede@redhat.com>
         <20170108134427.8392-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:49643 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751691AbdAHP1Y (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 8 Jan 2017 10:27:24 -0500
In-Reply-To: <20170108134427.8392-4-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

On Sun, 2017-01-08 at 14:44 +0100, Hans de Goede wrote:
> Take the punit lock to stop others from accessing the punit while the
> pmic i2c bus is in use. This is necessary because accessing the punit
> from the kernel may result in the punit trying to access the pmic i2c
> bus, which results in a hang when it happens while we own the pmic i2c
> bus semaphore.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=155241
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Tested-by: tagorereddy <tagore.chandan@gmail.com>
> ---
>  drivers/i2c/busses/i2c-designware-baytrail.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c
> b/drivers/i2c/busses/i2c-designware-baytrail.c
> index 3effc9a..cf7a2a0 100644
> --- a/drivers/i2c/busses/i2c-designware-baytrail.c
> +++ b/drivers/i2c/busses/i2c-designware-baytrail.c
> 

> @@ -62,6 +62,8 @@ static void reset_semaphore(struct dw_i2c_dev *dev)

> +	iosf_mbi_punit_unlock();

> @@ -79,6 +81,8 @@ static int baytrail_i2c_acquire(struct dw_i2c_dev
> +	iosf_mbi_punit_lock();

For me it looks a bit asymmetrical.

Can we use acquire()/release()?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
