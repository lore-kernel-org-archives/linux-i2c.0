From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Date: Wed, 4 Jan 2017 10:45:08 +0100
Message-ID: <20170104104508.4afbc9f7@endymion>
References: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com>
        <21e8453f9ebd2955b2c5e499dc51efb0@the-dreams.de>
        <201612271451.01505@pali>
        <6acf42bfb16eaa0e69ca322eb0c0853d@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54608 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753455AbdADJpP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 4 Jan 2017 04:45:15 -0500
In-Reply-To: <6acf42bfb16eaa0e69ca322eb0c0853d@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Pali =?UTF-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Steven Honeyman <stevenhoneyman@gmail.com>, valdis.kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, mario_limonciello@dell.com, Alex Hung <alex.hung@canonical.com>, kernel@kempniu.pl, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org

On Wed, 28 Dec 2016 15:02:52 +0100, Wolfram Sang wrote:
> On Tue, Dec 27, 2016 at 02:51:01PM +0100, Pali Rohár wrote:
> > i2c_new_device() with lis3lv02d for i801 i2c bus needs to be called
> > after initializing i2c-i801 bus driver.
> >
> > I have no idea how to do it (properly) outside of i2c-i801.c file.
> 
> I once used bus_notifiers to achieve something similar. You could check
> arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c to see an action
> triggered once a client device got added, but you could act on another
> action like BUS_NOTIFY_BOUND_DRIVER. I used exactly that, too, somewhen
> somewhere.  Haven't checked if that helps here, too. And since we have 
> a
> precedence (Fujitsu case), I'll leave it to Jean who is the maintainer
> of this driver.

I don't have a strong opinion on the matter, whatever works is fine
with me.

-- 
Jean Delvare
SUSE L3 Support
