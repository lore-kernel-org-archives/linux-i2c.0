From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH 4/5] i2c: octeon,thunderx: Check bus state before
 starting a transaction
Date: Thu, 22 Sep 2016 18:08:32 +0200
Message-ID: <20160922160832.GA2734@hardcore>
References: <cover.1474439371.git.jglauber@cavium.com>
 <21b1db0af4c62a53dc2fcec1e0b1f7b412e6f1be.1474439371.git.jglauber@cavium.com>
 <20160921205540.GC1513@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-sn1nam01on0076.outbound.protection.outlook.com ([104.47.32.76]:50614
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754510AbcIVQIq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 22 Sep 2016 12:08:46 -0400
Content-Disposition: inline
In-Reply-To: <20160921205540.GC1513@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, "Bazhenov, Dmitry" <dmitry.bazhenov@auriga.com>

On Wed, Sep 21, 2016 at 10:55:41PM +0200, Wolfram Sang wrote:
> On Wed, Sep 21, 2016 at 08:51:05AM +0200, Jan Glauber wrote:
> > Add an additional status check before starting a transaction and,
> > if required, trigger the recovery if the check fails.
> > 
> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> 
> Won't this break multi-master setups?
> 

I'm afraid yes. I don't have a multi-master setup, but agree that we
should not break it.

How about re-checking if the bus is idle until a timeout
(i2c->adap.timeout ?) happens and only then recover?

Additionaly we can check for arbitration loss as Dmitry did in his
original patch.

--Jan
