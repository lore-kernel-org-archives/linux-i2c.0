From: Valentino <valentino@valkad.com>
Subject: Re: Issues with touchpad / touchscreen on yoga 900
Date: Sat, 5 Mar 2016 14:56:26 +0000 (UTC)
Message-ID: <loom.20160305T155302-687@post.gmane.org>
References: <20151029112913.1036f00b@voldemort.scrye.com> <20151029183032.GA8992@katana> <56332316.90506@linux.intel.com> <20151030100442.50ac07bd@voldemort.scrye.com> <20151102124728.52e82bed@voldemort.scrye.com> <20151103081840.GK1509@lahna.fi.intel.com> <20151104075143.44053d44@sheelba.scrye.com> <20151201003553.GB1517@katana> <20151201075015.GC7422@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44927 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804AbcCEPAH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 5 Mar 2016 10:00:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gldi-i2c-1@m.gmane.org>)
	id 1acDga-0005Uh-W5
	for linux-i2c@vger.kernel.org; Sat, 05 Mar 2016 16:00:05 +0100
Received: from ersin68.plus.com ([80.229.7.48])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-i2c@vger.kernel.org>; Sat, 05 Mar 2016 16:00:04 +0100
Received: from valentino by ersin68.plus.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-i2c@vger.kernel.org>; Sat, 05 Mar 2016 16:00:04 +0100
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

Mika Westerberg <mika.westerberg <at> linux.intel.com> writes:

> 
> On Tue, Dec 01, 2015 at 01:35:54AM +0100, Wolfram Sang wrote:
> > I didn't find any patch coming out of this? Mika, did I miss something?
> 
> The fix is included in the "intel-lpss: support for non-ACPI platforms"
> series by Andy [1]. You and Kevin are both Cc'd.
> 
> https://lkml.org/lkml/2015/11/30/441
> 
> The patch solving this issue is "[14/16] mfd: intel-lpss: Pass SDA hold
> time to I2C host controller driver".
> 

Can someone pls give me an idiots guide on how to apply the patch to get the 
trackpad and touchscreen working on kali yoga 900.
Really beyond me so a little ( ALOT) help appreciated .
email is valentino@valkad.com

Thanks Guys
