From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH] i2c-designware: increase timeout of semaphore transfer
Date: Mon, 20 Mar 2017 14:39:06 +0100
Message-ID: <1490017146.8775.9.camel@suse.com>
References: <20170316162455.22876-1-oneukum@suse.com>
         <1489682129.19767.25.camel@linux.intel.com>
         <df37d77a-c0a2-9c13-f70f-140fcfbb72e7@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38829 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753172AbdCTNkT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 20 Mar 2017 09:40:19 -0400
In-Reply-To: <df37d77a-c0a2-9c13-f70f-140fcfbb72e7@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

Am Freitag, den 17.03.2017, 08:35 +0100 schrieb Hans de Goede:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Oliver, can you rebase this on top of:
> 
> 
> https://cgit.freedesktop.org/drm-intel/commit/?h=topic/designware-baytrail
> 
> Which is in -next now, please ? I'm sorta surprised you didn't
> use this is a base since your commit msg mentions cherrytrail
> and with that series the semaphore code is broken on
> cherrytrail.

Done. I used Linus' tree specifically because it is kind of canonical.
The patch is taken from an internal tree which had your patches.

	Regards
		Oliver
