Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568676;
	b=wfFsw6Pib4PC3veOPWJgC6/bCWeJ/bdFbi8lBDS7RQrnPNR0IeZIFIcS6BkVGvHimFd7
	 i5hE1wI8NeZvYXReQog5lg5GSM1JL3n7tgX31uG5UthtnZnfUlU3Y0/4ETD9u64pQ8Xvv
	 +e4aeRLpLLS8XFNdCfKFOjy/uPhmNx4IDcjGCIOebo7W4R7nB3qkmW+ZEBSryNZj1FGkH
	 0eNhbBzgSNzrRjbmizkf/jd6FzU9wahbHO8yfcTlE0+eKViOpbgtJUcR2QLFyoJQ6y6g8
	 gq/UDk06d29kgQXH1Kf+wAtCSFDHGMtYPQBlxKeWpTow1bS2RbE3aJj1pQFOXLIzyfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568676;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=e3vkd0LoqHP/Fs97PmOzot6zfXKBzyHOj1Xrx4U1Yg0=;
	b=SAcA3PZGsdM6xhsgMDb4BVt93nG9r7vi3LfvOahITK1fgNCa0plknfgE/BISJNpC2ZzD
	 BYgWfmqet7sQrIcutsmB4v87u+XMRmW2cGjhS55Tr9Wnp93mfgvAXTk3SLRBrPHwzvIFS
	 6fPtDh5R/VcO4kjSAsKQobqZPrDxCtnMzii4ItznATjC+BYIO3yUxhTs7awKnarZOVTXX
	 s8XrWv8goVaPMBq0O0OA/Xg/ANCBFiRs5O1dCNTwN8GVBwwSBHql7AgSZq9DAvc/hfyxF
	 t5mOFuaeW6YYEgE3TYrACwmYchV2nhxOJMVbR7LpACfKFIOAYJluBbc0VNw4RVDH3DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F8tWy5J1;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B75606A31C;
	Fri, 13 Nov 2026 11:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19B75606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F8tWy5J1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794568676; x=1826104676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kK8vLvJqU7y2J1PAYMjV1Io9/rALIf9hcDnjRm0rYBw=;
  b=F8tWy5J10s4PAcll9513mykQCHWLBRU1bT0TjEvOujYyLTdvNlcCUcVx
   shwbdOrjqwJRQIT4aChipcIjZNv8cCsgrvIa0YELLnRZXeEMvL5LxeXnm
   rpYNhagJq27QFp6bOcM3NaJpxtpeH2OVwQ84CjioIh0zi9vfsUGOTyjEc
   Nt/1DD3G2GGRezwb3q1hhjdaChKMJCZpl1QqqWLBlFpfuHAornK5jT7Ip
   EHHthOmYuKX8sz28Xm0lH8QhWthndeJNqC8UGkocmD4Yp8JmRIfD8ZyKX
   gkrJY89++sKu5r+oErIP25xPd62K3L4wqZpMPY9OYjasZE5vTTmmbUez4
   g==;
X-CSE-ConnectionGUID: kWto84LERBW6/IGJK0lCFw==
X-CSE-MsgGUID: 4eUCWP6LQGaKxq5d/jkimw==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3382331"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3382331"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 03:17:55 -0800
X-CSE-ConnectionGUID: 4oJaS+svSMWcrEUfOlB50Q==
X-CSE-MsgGUID: 7DH7wN4wQ3iUSzTDlUdjRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="8996572"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 13 Nov 2026 03:17:54 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id F19C099; Fri, 13 Nov 2026 12:17:52 +0100 (CET)
Date: Fri, 13 Nov 2026 12:17:52 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	penhouse24@proton.me, linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH] i2c: acpi: Force Dell XPS 17 9720 touchpad to 100 kHz
Message-ID: <20261113111752.GR259790@black.igk.intel.com>
References: <20261113083940.2583439-1-mika.westerberg@linux.intel.com>
 <b47bcc52-b969-4337-bd86-890b9cd80c3d@oss.qualcomm.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b47bcc52-b969-4337-bd86-890b9cd80c3d@oss.qualcomm.com>

Hi,

On Fri, Nov 13, 2026 at 10:52:09AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 13-Nov-26 09:39, Mika Westerberg wrote:
> > The Dell XPS 17 9720 touchpad has the same lagging issue as with others
> > when run at 400 kHz as the ACPI tables describe. This particular system
> > does not use standard ACPI ID but it seems to use "Windows Device ID"
> > VEN_04F3 for whatever reason. Add this one to the 100 kHz quirk list as
> > well but since this is not a standard ACPI ID match it also via DMI
> > strings just to be on the safe side.
> > 
> > Reported-by: penhouse24@proton.me
> > Link: https://lore.kernel.org/linux-i2c/20261109104542.GL176724@black.igk.intel.com/
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Thank you for your patch.
> 
> > ---
> >  drivers/i2c/i2c-core-acpi.c | 24 +++++++++++++++++++++++-
> >  1 file changed, 23 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> > index 84841ed13487..98a8d63e3fb8 100644
> > --- a/drivers/i2c/i2c-core-acpi.c
> > +++ b/drivers/i2c/i2c-core-acpi.c
> > @@ -7,6 +7,7 @@
> >  
> >  #include <linux/acpi.h>
> >  #include <linux/device.h>
> > +#include <linux/dmi.h>
> >  #include <linux/err.h>
> >  #include <linux/i2c.h>
> >  #include <linux/list.h>
> > @@ -356,6 +357,16 @@ static const struct acpi_device_id i2c_acpi_force_400khz_device_ids[] = {
> >  	{ }
> >  };
> >  
> > +static const struct dmi_system_id i2c_acpi_dell_xps_17_9720_dmi_ids[] = {
> > +	{
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 17 9720"),
> > +		},
> > +	},
> > +	{ }
> > +};
> > +
> >  static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
> >  	/*
> >  	 * When a 400KHz freq is used on this model of ELAN touchpad in Linux,
> > @@ -377,6 +388,14 @@ static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
> >  	{ .id = "ELAN0678" },
> >  	{ .id = "ELAN06FA" },
> >  	{ .id = "ELAN1300" },
> > +	{
> > +		/*
> > +		 * Some Dell XPS 17 9720 systems do not use standard
> > +		 * ACPI IDs so we need to match also via DMI strings.
> > +		 */
> > +		.id = "VEN_04F3",
> 
> 04F3 is ELAN's USB/I2C-HID vendor ID and the commonality between all touchpads
> with needs this seems to be them being from ELAN.
> 
> Also a quick grep through my DSDT collection shows 0 uses of VEN_04F3,
> which makes me think this is pretty unique.
> 
> So all in all I think we can just add a match on "VEN_04F3" without
> requiring / adding DMI matching ?

Works for me. I'll do that in v2.
