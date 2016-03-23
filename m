From: Pavel Machek <pavel@ucw.cz>
Subject: Re: spurious warning from of_i2c_register_device with
 fixed_regulator?
Date: Wed, 23 Mar 2016 12:34:51 +0100
Message-ID: <20160323113451.GA25989@amd>
References: <20160316110156.GC21259@amd>
 <20160316112016.GC1542@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39552 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbcCWLey (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 23 Mar 2016 07:34:54 -0400
Content-Disposition: inline
In-Reply-To: <20160316112016.GC1542@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, pantelis.antoniou@konsulko.com, grant.likely@linaro.org, robh+dt@kernel.org

Hi!

> > But we have fixed regulator there, it does not have "reg" property.
> 
> The fixed regulator doesn't even use I2C. So, you need to debug why it
> calls I2C. Your information given is not enough for me.

Thanks for the help. It seems to have been mismerge on my dts.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
