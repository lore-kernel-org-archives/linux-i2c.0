Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AF130C163
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783509056; cv=none; b=jWax+MhlwLPA1YnNPVZEGsxSmvvQyogoLBGxM1kZU1DZHzcnJAlIHP9JskCbQfYcpkBH5eu+Z3g8ebqW2ee8nCrHPNiZ7ov7eznbzYH9N5oprY/sEiMY83wFLxyXZq9JV2ts13WSNGKNrsdfm5UMea2caZD7YtBo5gvdkoRG7FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783509056; c=relaxed/simple;
	bh=B6vPooewm8t5jBY377SKnoJbzpldo2PFcXpvGbdXeRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6cbx+Z7+1hxn98zXyxn3fF05ObqnfOn5wpvic1RGDq1zSiNZVImJLOkPH8WEpjHZRuTI0nkQVT9tGzFpxFIYnsyxjB4AaRYGiiKFZVTKgPfXI+6oVm3LC7SDac4CfdVFIFXGzaEf44CVyDL1ZlfPjNQbDcxWZrpwy9+ls4plUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EqQl9ohd; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EqQl9ohd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783509056; x=1815045056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=B6vPooewm8t5jBY377SKnoJbzpldo2PFcXpvGbdXeRE=;
  b=EqQl9ohdg8+DT/aoXkZQOp5DoqvnDiRAB6/fe/mGhiqD+IMCLvpeWWGB
   BlL81zBdjv8WY6gKKcJeEqENXpWKMmI+9U3tlUa76F/cLSn76ejCnaH2N
   FHgmu6vY/GgsdldNil4S8q7Wy1bBhK3QXRAE5kMpOzHwJZ82r4l5AfGMc
   UroLX7TXOqeyzpXuRqHnDQ4o9yh0vPUrZ9A2ABWritdifGQSZkz6pItFO
   AYPW9yGQ5AunOebRSP/40mkmKoL21p9WMvkUFlDnEVa7Hgcp3lZlQ1D9C
   TZb9hnrFQVLNVu12iyhTTUNyzWmxg/eB5P0Z3765diFWslZ6Qv9C0zP2l
   Q==;
X-CSE-ConnectionGUID: rclHWzloTb6YDQmJDqZhjw==
X-CSE-MsgGUID: A3rygB2/QReqb43xm19Ksg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="101591439"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="101591439"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 04:10:55 -0700
X-CSE-ConnectionGUID: QASahE8xSF2LxFg6nj8iKg==
X-CSE-MsgGUID: um2egYfWQR2jIq4xUDAF8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="257844826"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 04:10:53 -0700
Date: Wed, 8 Jul 2026 14:10:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Brigham Campbell <me@brighamcampbell.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Stephen Horvath <s.horvath@outlook.com.au>,
	linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
	=?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>
Subject: Re: [PATCH i2c-tools] TODO: add file and describe items for the 4.5
 release
Message-ID: <ak4wOvE_0anM4NIs@ashevche-desk.local>
References: <20260705181043.3757-1-wsa+renesas@sang-engineering.com>
 <DJR7QS1LOHU0.2PNA54ULDF2PF@brighamcampbell.com>
 <SYBPR01MB4586AD69D431CAD2D26ADD68C5F12@SYBPR01MB4586.ausprd01.prod.outlook.com>
 <DJRA1PB8LKKJ.2RTZWEP2LVRFF@brighamcampbell.com>
 <akzuG3VpcoUWRhUr@shikoro>
 <DJSVN4OMOMB7.EBB9SV2PLWTR@brighamcampbell.com>
 <ak4Mn4NOfIqCQTO3@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ak4Mn4NOfIqCQTO3@shikoro>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

+Cc: Heikki, who is involved in i2c more than me these days.

On Wed, Jul 08, 2026 at 10:38:55AM +0200, Wolfram Sang wrote:
> 
> @Andy: you know more about laptops and I2C than I do. The initial issue
> was reported here:
> 
> https://lore.kernel.org/all/DJRA1PB8LKKJ.2RTZWEP2LVRFF@brighamcampbell.com/

I read the thread in full. Without laptop schematics (and usually this is
the biggest obstacle to understand things clearly) it's just a guesswork.

With information given in the thread I think the actual connection of the
thermal sensors (and I don't believe they are absent or not connected) does
not go to the SoC. It's most likely (taking into account that this is laptop)
connected to EC or other separate MCU on the board.

There is still a quite little chance that they are connected to the SoC pins
but pin muxing done in a way that they are hidden from the host SMBus controller.

Have to state again, without schematics it's a guesswork. One may also reverse
engineer BIOS, but it's quite out of scope of this.

As per I²C HID. You can run

	grep -H 15 /sys/bus/acpi/devices/*/status

and I believe one of them can be touchpad. Also

	cat /proc/interrups

may lead to that device as it's usually the most appearing consumer of GPIO
interrupts and I²C host controller. Hope this helps.

> It would be great to get that bus working because Brigham likely could
> then test the new DDR5 patches for decode-dimms.
> 
> > It looks like it's bound to i2c_hid_acpi. No ddr5 temperature sensors in
> > sight...
> 
> Well, it was worth a try. Thanks.
> 
> > > How many? If it is in the 120 range, then every access from i2cdetect
> > > fails with it.
> > 
> > When I run i2cdetect on the i801 controller, on one invocation I count
> > 111 repetitions of the "SMBus is busy, can't use it!" error once, then
> > on another invocation I count 112 repetitions.
> 
> Okay, as expected, this is more or less one BUSY condition per address
> scanned.
> 
> > When the kernel's i2c bus arbitration retry logic kicks in, it appears
> > to be able to eventually complete the operation successfully before the
> > i2c core driver code gives up because otherwise I would expect i2cdetect
> > to exit prematurely and report an error.
> 
> It would mark that address as "XX" if there was an error. As it prints
> "--", it indeed indicates that the retry could have succeeded.
> 
> > Wolfram, if you or any other kernel developers think this may be
> > indicative of some underlying issue, I'm happy to investigate further
> > and report back. I'm using a Dell XPS 14 DA14260 laptop.
> 
> Thank you, but sadly I am not the right person to ask. My expertise is
> the embedded sector. I don't know much about laptops, ACPI, and how the
> management processors play in the game. My assumption would be that the
> BUSY state has something to do with the latter. But maybe Andy knows?

ACPI should have nothing to do with DDR5 sensors. Otherwise it is something
new to me.

-- 
With Best Regards,
Andy Shevchenko


