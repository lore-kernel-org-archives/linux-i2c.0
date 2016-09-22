From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] i2c / ACPI: Do not touch an I2C device if it belongs
 to another adapter
Date: Thu, 22 Sep 2016 12:25:08 +0300
Message-ID: <20160922092508.GJ1218@lahna.fi.intel.com>
References: <874m5ax3o4.fsf@gmail.com>
 <20160920135925.45450-1-mika.westerberg@linux.intel.com>
 <20160921054834.GC1484@katana>
 <20160921084502.GV1811@lahna.fi.intel.com>
 <20160921161435.GA1432@katana>
 <20160922084930.GI1218@lahna.fi.intel.com>
 <20160922085924.GB1433@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44066 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753183AbcIVJZV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 22 Sep 2016 05:25:21 -0400
Content-Disposition: inline
In-Reply-To: <20160922085924.GB1433@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Nicolai Stange <nicstange@gmail.com>, Octavian Purdila <octavian.purdila@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Sep 22, 2016 at 10:59:24AM +0200, Wolfram Sang wrote:
> 
> > > Huh? It doesn't apply on top of rc7 here? What did you base it on?
> > 
> > It is based on linux-next as it is on top of Jarkko's I2C ACPI namespace
> > cleanup patches. I'm wondering if I make an updated patch on top of
> > v4.8-rc7 does it conflict with the I2C stuff in linux-next? What's your
> > preference?
> 
> I see. I'll add it to for-next, then. If someone wants it backported, it
> needs to be rewritten and re-tested.

OK, thanks.
