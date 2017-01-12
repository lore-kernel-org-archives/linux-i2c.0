From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/7] i2c: designware-baytrail: Take punit lock on bus
 acquire
Date: Thu, 12 Jan 2017 19:45:45 +0100
Message-ID: <20170112184545.sejbzawnesu6zj5i@ninjato>
References: <20170108134427.8392-1-hdegoede@redhat.com>
 <20170108134427.8392-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:53484 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750781AbdALSps (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 12 Jan 2017 13:45:48 -0500
Content-Disposition: inline
In-Reply-To: <20170108134427.8392-4-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

On Sun, Jan 08, 2017 at 02:44:23PM +0100, Hans de Goede wrote:
> Take the punit lock to stop others from accessing the punit while the
> pmic i2c bus is in use. This is necessary because accessing the punit
> from the kernel may result in the punit trying to access the pmic i2c
> bus, which results in a hang when it happens while we own the pmic i2c
> bus semaphore.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=155241
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Tested-by: tagorereddy <tagore.chandan@gmail.com>

I don't think the I2C patches need to go via I2C tree, so:

Acked-by: Wolfram Sang <wsa@the-dreams.de>
