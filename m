From: Dustin Byford <dustin@cumulusnetworks.com>
Subject: Re: [PATCH v5 0/2] i2c: acpi: scan ACPI enumerated I2C mux channels
Date: Sun, 25 Oct 2015 08:15:25 -0700
Message-ID: <20151025151525.GA14546@cumulusnetworks.com>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
 <1445628427-29244-1-git-send-email-dustin@cumulusnetworks.com>
 <20151025145307.GA9701@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34271 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbbJYPP0 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 25 Oct 2015 11:15:26 -0400
Received: by padhk11 with SMTP id hk11so162429196pad.1
        for <linux-i2c@vger.kernel.org>; Sun, 25 Oct 2015 08:15:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20151025145307.GA9701@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, rjw@rjwysocki.net, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Puustinen, Ismo" <ismo.puustinen@intel.com>

On Sun Oct 25 15:53, Wolfram Sang wrote:
> On Fri, Oct 23, 2015 at 12:27:05PM -0700, Dustin Byford wrote:
> > v5:
> > - rebased on i2c/for-next (Jarkko, Wolfram)
> > - include acpi.h in designware drivers (Mika)
> > - remove return from void stub function (Mika)
> > - add acks and tested-by from Mika
> 
> Applied to for-next, thanks!

Thanks for the reviews everyone.

> In the future, when you send new versions, please don't set In-Reply-To
> to the old version, just leave it empty. I (and most maintainers I know)
> find it easier to work when patches arrive chronologically.

OK, will do.

		--Dustin
