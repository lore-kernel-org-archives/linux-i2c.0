From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: Issues with touchpad / touchscreen on yoga 900
Date: Tue, 3 Nov 2015 10:18:40 +0200
Message-ID: <20151103081840.GK1509@lahna.fi.intel.com>
References: <20151029112913.1036f00b@voldemort.scrye.com>
 <20151029183032.GA8992@katana>
 <56332316.90506@linux.intel.com>
 <20151030100442.50ac07bd@voldemort.scrye.com>
 <20151102124728.52e82bed@voldemort.scrye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23440 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528AbbKCITF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 3 Nov 2015 03:19:05 -0500
Content-Disposition: inline
In-Reply-To: <20151102124728.52e82bed@voldemort.scrye.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kevin Fenzi <kevin@scrye.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Mon, Nov 02, 2015 at 12:47:28PM -0700, Kevin Fenzi wrote:
> Any other ideas or things to try? 
> 
> It would be nice to have a working touchpad. ;)

Please attach acpidump of that machine to the bug (or send it directly
to me) and provide full dmesg with i2c_hid.debug=1.
