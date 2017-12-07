From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: piix4: Fix port number check on release
Date: Thu, 7 Dec 2017 16:08:50 +0100
Message-ID: <20171207160850.7f70f48b@endymion>
References: <20171207122545.1b8e17c6@endymion>
        <20171207143348.tvxvzehzf3b7cgmv@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45242 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754412AbdLGPIx (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 7 Dec 2017 10:08:53 -0500
In-Reply-To: <20171207143348.tvxvzehzf3b7cgmv@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>

On Thu, 7 Dec 2017 15:33:48 +0100, Wolfram Sang wrote:
> > Thankfully 0 is always 0 no matter how you shift it, so this was a
> > bug without consequences.  
> 
> So, why do we shift at all?

You are joking, right?

-- 
Jean Delvare
SUSE L3 Support
