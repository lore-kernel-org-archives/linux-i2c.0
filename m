From: Aleksei Mamlin <mamlinav@gmail.com>
Subject: Re: State of the i2c-piix4 driver
Date: Thu, 12 May 2016 07:53:25 +0000 (UTC)
Message-ID: <loom.20160512T094247-214@post.gmane.org>
References: <20160308151341.48eb3f41@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:58570 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752083AbcELHzI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 12 May 2016 03:55:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gldi-i2c-1@m.gmane.org>)
	id 1b0lSb-0005sf-To
	for linux-i2c@vger.kernel.org; Thu, 12 May 2016 09:55:06 +0200
Received: from mail2.teploobmennik.ru ([95.79.26.27])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-i2c@vger.kernel.org>; Thu, 12 May 2016 09:55:05 +0200
Received: from mamlinav by mail2.teploobmennik.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-i2c@vger.kernel.org>; Thu, 12 May 2016 09:55:05 +0200
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

Jean Delvare <jdelvare <at> suse.de> writes:

> 
> 5* The I/O ports used for SMBus configuration and port switching are
> also needed by a watchdog driver, sp5100_tco. Both drivers request the
> region, so the first one wins, and the other driver can't be loaded.
> sp5100_tco was there first, so the changes done to the i2c-piix4 driver
> recently will cause a regression for some users by preventing them
> from using the sp5100_tco and i2c-piix4 drivers at the same time. In
> the long run I guess we will need a helper module to handle this shared
> resource. Unless IORESOURCE_MUXED can be used for that. Either way,
> that's more work than I can put into this before kernel v4.5 is
> released. For the time being, I think we should simply make it
> non-fatal if the I/O ports can't be requested, and continue without
> multiplexing (as before.)
> 

Hi Jean
Have you any progress with 5*?
I have the same HP MicroServer G7 as Christian and it would be nice to have 
both i2c and watchdog working at same time.
