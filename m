From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 4/7] i2c: designware-baytrail: Call
 pmic_bus_access_notifier_chain
Date: Thu, 12 Jan 2017 19:45:54 +0100
Message-ID: <20170112184554.xbdsp3dbs75b2ycj@ninjato>
References: <20170108134427.8392-1-hdegoede@redhat.com>
 <20170108134427.8392-5-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:53582 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750832AbdALSp4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 12 Jan 2017 13:45:56 -0500
Content-Disposition: inline
In-Reply-To: <20170108134427.8392-5-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

On Sun, Jan 08, 2017 at 02:44:24PM +0100, Hans de Goede wrote:
> Call the iosf_mbi pmic_bus_access_notifier_chain on bus acquire / release.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=155241
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Tested-by: tagorereddy <tagore.chandan@gmail.com>

Acked-by: Wolfram Sang <wsa@the-dreams.de>
