From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] i2c: piix4: Fix SMBus port selection for AMD Family 17h
 chips
Date: Thu, 5 Oct 2017 10:43:41 -0700
Message-ID: <20171005174341.GA8369@roeck-us.net>
References: <1500162686-21682-1-git-send-email-linux@roeck-us.net>
 <20170812113357.ijna5riha7uechja@ninjato>
 <20171005163350.54ac3b96@endymion>
 <20171005151115.GA6129@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:52624 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbdJERno (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 5 Oct 2017 13:43:44 -0400
Content-Disposition: inline
In-Reply-To: <20171005151115.GA6129@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Oct 05, 2017 at 05:11:15PM +0200, Wolfram Sang wrote:
> 
> > Sorry for the delay. Looks all good to me (as I'd expect from Gunter...)
> > 
> > Reviewed-by: Jean Delvare <jdelvare@suse.de>
> 
> Thanks, Jean!
> 
> Guenter: I will queue it to for-current, when I am back home. Does it
> need a stable tag?
> 
I would suggest yes, since otherwise anyone using a Ryzen or Threadripper CPU
will see duplicate i2c controllers and devices. Some DDR4 chips have temperature
sensors, so this becomes easily visible (this is how I found the problem).

Thanks,
Guenter
