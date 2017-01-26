From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH 4/4] i2c: octeon: thunderx: Add I2C_CLASS_HWMON
Date: Thu, 26 Jan 2017 07:10:30 +0100
Message-ID: <20170126061030.GA2827@hardcore>
References: <20161209093158.3161-1-jglauber@cavium.com>
 <20161209093158.3161-5-jglauber@cavium.com>
 <20161211220434.GH2552@katana>
 <20170125204923.2mxtlszvco6wxjok@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-co1nam03on0060.outbound.protection.outlook.com ([104.47.40.60]:12872
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752544AbdAZGKs (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 26 Jan 2017 01:10:48 -0500
Content-Disposition: inline
In-Reply-To: <20170125204923.2mxtlszvco6wxjok@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>, Paul Burton <paul.burton@imgtec.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>

On Wed, Jan 25, 2017 at 09:49:23PM +0100, Wolfram Sang wrote:
> On Sun, Dec 11, 2016 at 11:04:35PM +0100, Wolfram Sang wrote:
> > On Fri, Dec 09, 2016 at 10:31:58AM +0100, Jan Glauber wrote:
> > > It was reported that ipmi_ssif fails to create the
> > > ipmi device on some systems if the adapter class is not containing
> > > I2C_CLASS_HWMON. Fix it by setting the class.
> > > 
> > > Reported-by: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
> > > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> > 
> > The intention of adapter classes is to *limit* probing to a certain
> > class of devices. If a class is needed to *enable* probing, then
> > something there looks wrong. From the details given, this must be solved
> > elsewhere I'd say.
> 
> Makes sense?
> 

Yes, perfectly, the patch can be dropped.

thanks,
Jan
