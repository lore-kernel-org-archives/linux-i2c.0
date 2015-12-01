From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: Issues with touchpad / touchscreen on yoga 900
Date: Tue, 1 Dec 2015 09:50:15 +0200
Message-ID: <20151201075015.GC7422@lahna.fi.intel.com>
References: <20151029112913.1036f00b@voldemort.scrye.com>
 <20151029183032.GA8992@katana>
 <56332316.90506@linux.intel.com>
 <20151030100442.50ac07bd@voldemort.scrye.com>
 <20151102124728.52e82bed@voldemort.scrye.com>
 <20151103081840.GK1509@lahna.fi.intel.com>
 <20151104075143.44053d44@sheelba.scrye.com>
 <20151201003553.GB1517@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:56429 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752636AbbLAHw1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 1 Dec 2015 02:52:27 -0500
Content-Disposition: inline
In-Reply-To: <20151201003553.GB1517@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Kevin Fenzi <kevin@scrye.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Tue, Dec 01, 2015 at 01:35:54AM +0100, Wolfram Sang wrote:
> I didn't find any patch coming out of this? Mika, did I miss something?

The fix is included in the "intel-lpss: support for non-ACPI platforms"
series by Andy [1]. You and Kevin are both Cc'd.

https://lkml.org/lkml/2015/11/30/441

The patch solving this issue is "[14/16] mfd: intel-lpss: Pass SDA hold
time to I2C host controller driver".
