Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2069F2DF701;
	Mon, 16 Mar 2026 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773672315; cv=none; b=uBuJWFB68ukQrPiNR66WaIUxWLfh9TKL+kDTEPzkSLU8F3EQoS+Pl7xTajkLQlrtYLU50BZkIwwtHJ0i3VrSxMW0OCv19QmWoyZ0SU96fnlNtq+QNwImn5u98WSmQLOZuQJX86x/lL4id0AXDFhTbDtsm2qZPzuEOHcuxEn4pi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773672315; c=relaxed/simple;
	bh=og9BD3TryGJSPc8bT2MFJlHrohgQUVEIJVI7Bh7zAAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ks056vrFVLOShuht4tWEIh+JyqRQxCbvq/j/UdxU3EKGhx7y65h2skLXGSChXHI49d5I8fAyiMFII/crTpSq4h7cM0lSO6m1+UVVuAAzWL3qKgHlCtU7hIGtRT91Uuymq9hqVIYR3I12qg+zaTMm64HvBC3Vizzwqg0UpN9f3/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z08dYTxp; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z08dYTxp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773672314; x=1805208314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=og9BD3TryGJSPc8bT2MFJlHrohgQUVEIJVI7Bh7zAAI=;
  b=Z08dYTxpXjp6UkuuekSxi4FauXXJkM9FhD0WCHW5U1jNLLfawx1hVxg9
   y5O/vK+uLsSI/OWsgO+68xnEuCjX3bTl3oBHeWtQ+rBsgFKdYb7O1wRe2
   d32y+TeZ/RocNn0gskTbCM1j3cZCmddb7yUVqQW+e/2hxGPujJAAa+Sze
   2Rj2dg6Ai35VUra/u4daIdDZXR2pOUDb+KwpDLziCkgNXta4j2QUn3E5m
   PSBrqHO1cuRyFv63Gcoqis3/60RgLy6mxrueC1qy6Hj+9MVeozUivh44f
   cmN5UxIODiFsR6v2FGtaOpRPQYWxfY8z2oAWXY/zjCauVoJsZ6FR91DZl
   w==;
X-CSE-ConnectionGUID: 4COnaSD3REmA2b+LEFcrzQ==
X-CSE-MsgGUID: 3WSVWNWnRRyN/mHqz5m/Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="77298267"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="77298267"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 07:45:14 -0700
X-CSE-ConnectionGUID: 6ZjyMMHHSfOvX8L4r3tqfQ==
X-CSE-MsgGUID: kCsKpV1CSUSxeX7ST+nAxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="220979760"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 16 Mar 2026 07:45:12 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id BBF2E98; Mon, 16 Mar 2026 15:45:10 +0100 (CET)
Date: Mon, 16 Mar 2026 15:45:10 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Edward Blair <edward.blair@gmail.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/2] i2c: acpi: skip generic I2C device when
 vendor-specific sibling exists
Message-ID: <20260316144510.GE2275908@black.igk.intel.com>
References: <20260316131219.GD2275908@black.igk.intel.com>
 <20260316143242.24248-1-edward.blair@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260316143242.24248-1-edward.blair@gmail.com>

On Mon, Mar 16, 2026 at 02:32:42PM +0000, Edward Blair wrote:
> On Sun, 16 Mar 2026 at 13:12, Mika Westerberg wrote:
> > Are they both 'present'? I mean their _STA() returns 0xF for both?
> 
> MSFT8000:00 has no _STA method at all. The sysfs status attribute is
> absent, which only happens when acpi_has_method(handle, "_STA")
> returns false (device_sysfs.c line 591). So it defaults to present per
> the ACPI spec. ITE8853:00 has _STA returning 0xF.

Okay.

> As Heikki pointed out, MSFT8000 is the RhProxy device, not UCSI. My
> mistake in the commit message.
> 
> > We have a quirk table already in drivers/acpi/x86/utils.c that I
> > think could be used to mark the other one being not present.
> 
> That would work. acpi_device_override_status() runs before _STA
> evaluation so it can force status=0 even without a _STA method.
> 
> My concern is scope. MSFT8000 is a Windows-only Resource Hub Proxy
> (RhProxy) device with no Linux driver, no module binding, and no
> in-kernel consumer. It's a static ACPI node with no _STA, so the
> BIOS exports it unconditionally. Skipping it during I2C client
> enumeration would have zero functional impact on Linux while avoiding
> a quirk table entry that needs duplicating per board.

Well it needs to be somewhere unfortunately :( Gathering these into one
file at least makes it sligthly more maintainable IMHO. I think the
override_status_ids could be made to use only the HID so no need to add DMI
strings. Of course if we ever want to bind a driver to it then it needs to
be exposed again (but that sounds unlikely since we already have a real
device that a driver could bind to).

Just my 2 cents.
