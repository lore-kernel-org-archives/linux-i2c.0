From: Jean Delvare <jdelvare@suse.de>
Subject: Re: New location for i2c-tools.git
Date: Mon, 4 Jul 2016 10:31:47 +0200
Message-ID: <20160704103147.51185bdf@endymion>
References: <1434710432-4182-2-git-send-email-wsa@the-dreams.de>
	<20160427173308.GN7946@pengutronix.de>
	<20160619195641.GD26875@pengutronix.de>
	<20160621111255.1a27363e@endymion>
	<20160622185252.5ecfdf1d@endymion>
	<20160623073249.GM26875@pengutronix.de>
	<CA+TH9VkztGak0FugD0zLgOigBope5pT4FheQJkqhvg3xrnUxcw@mail.gmail.com>
	<20160623115314.1e20f84f@endymion>
	<CA+TH9VkXPFBgAiLHwx+_B96RRYMmtG-Kc_5qN-0Ps6FceBrVhg@mail.gmail.com>
	<20160623194016.6d89dc01@endymion>
	<20160623185000.GA1611@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41146 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753062AbcGDIbu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 4 Jul 2016 04:31:50 -0400
In-Reply-To: <20160623185000.GA1611@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>, Uwe =?UTF-8?B?S2xl?= =?UTF-8?B?aW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, linux-i2c@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Hi Wolfram,

On Thu, 23 Jun 2016 20:50:00 +0200, Wolfram Sang wrote:
> > The only remaining problem is that some files have occurrences of $Id$,
> > $Revision$ and $Date$, which SVN would replace on the fly but git does
> > not. Not sure what to do with them, replace them with something git
> > supports (not sure that exists?), or discard them.
> 
> Discard them, I'd say. You have all the history on your disk, so you
> have all the information from there.

For C source files, I agree, these keywords are useless.

The problem is for scripts, like decode-dimms (and sensors-detect, for
the lm-sensors part.) We can't "#include <version.h>" from these, and
my experience is that including a "manual" version string in such
scripts doesn't work because we tend to forget to update it (can
probably be addressed with some discipline.)

Also including the date turned out to be very convenient to figure out
quickly if a user report was from a recent enough version of the script
(particularly useful for sensors-detect, of which the latest snapshot
was available for direct download and in-place execution.)

-- 
Jean Delvare
SUSE L3 Support
