From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c: ismt: Add Intel DNV PCI ID
Date: Fri, 4 Mar 2016 10:38:07 +0200
Message-ID: <20160304083807.GC9667@lahna.fi.intel.com>
References: <1455807273-133516-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160219083917.GE1491@lahna.fi.intel.com>
 <5B3EBE90AD716C428A6F03AC478C5406B6270015@ORSMSX105.amr.corp.intel.com>
 <20160303211538.GB1501@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:13179 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751489AbcCDIiO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 4 Mar 2016 03:38:14 -0500
Content-Disposition: inline
In-Reply-To: <20160303211538.GB1501@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "Yates, Alexandra" <alexandra.yates@intel.com>, "Heasley, Seth" <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Thu, Mar 03, 2016 at 10:15:38PM +0100, Wolfram Sang wrote:
> Mika,
> 
> > I go this device ID from the External Design Specification (EDS) document for DNV.  The EDS lists this as the SMBus Controller as follows: 
> >  Bus: 0 Device:18 Function:0 Device ID: 0x19AC Description:  SMBus Controller - Host  
> > 
> > In the same document there is a list of PCI IDs. 
> 
> Did this comment help?

Not really.

We are figuring out which one it is and will send a new patch as soon as
we know better :)
