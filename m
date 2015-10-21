From: Dustin Byford <dustin@cumulusnetworks.com>
Subject: Re: [PATCH v3 1/1] i2c: add ACPI support for I2C mux ports
Date: Wed, 21 Oct 2015 02:25:08 -0700
Message-ID: <20151021092508.GB5949@cumulusnetworks.com>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
 <1445293740-28537-1-git-send-email-dustin@cumulusnetworks.com>
 <1445293740-28537-2-git-send-email-dustin@cumulusnetworks.com>
 <20151020125111.GJ1526@lahna.fi.intel.com>
 <20151020174959.GA14829@cumulusnetworks.com>
 <20151021081231.GQ1526@lahna.fi.intel.com>
 <20151021082116.GA5635@cumulusnetworks.com>
 <20151021083406.GU1526@lahna.fi.intel.com>
 <20151021085241.GA5949@cumulusnetworks.com>
 <20151021090849.GW1526@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34533 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733AbbJUJZK (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 21 Oct 2015 05:25:10 -0400
Received: by padhk11 with SMTP id hk11so49946427pad.1
        for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2015 02:25:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20151021090849.GW1526@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, andriy.shevchenko@linux.intel.com

On Wed Oct 21 12:08, Mika Westerberg wrote:
> I don't really have strong feelings whether it should be the I2C core or
> individual drivers setting the ACPI companion. However, it would be nice
> to match DT here and they assign their of_node per driver.

OK with me, if we can convince Rafael this is a good idea, I'll send a
new revision with drivers setting the companion.

		--Dustin
