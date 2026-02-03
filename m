Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E20431AA96;
	Tue,  3 Feb 2026 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770120124; cv=none; b=cHDLVtpfKxM8diwuBXmNFyxd3i6xWsx+y1ip9c46Gq5smtpTOaxjs/BEQS1WiojmQ3mvTJh10UpKj2eYNbCpkYbywp2NbDhn7ct8XK/N+pml42dR6ZtkRa49NrERn7IJNvaMHkKhvgt4Q6jxEJpCHigUUKEvE1cMSm8TS9gr3AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770120124; c=relaxed/simple;
	bh=uVUiJvsJ0ILKeh1NnP5l4+XmplibFdMh5gHlZAvJO90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuxQtbMEVm/DGMWTId5uwalIuvM+i29UZ3LGVfNr/mYLQzu8hrovgKn488StfvQH2L9iMs4lsLgz/m69szonFrAq6xpOEkRQoURSWLO66a/dQX104MKw+9MliIqkxqDNbWxY8lZg+5EMEVsy16RfhJx16wwNWgM/sdsmP3K3Ndc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rh8XQrOa; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rh8XQrOa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770120123; x=1801656123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uVUiJvsJ0ILKeh1NnP5l4+XmplibFdMh5gHlZAvJO90=;
  b=Rh8XQrOaQVnZnPzo0Ox9xVTdNJmc/5ij3S3wpqAQnJnUkyKtHmc2aWJV
   gANQ00krT5NCDeaBAwPKMxkAPmu87GrIARyekVM+/fn5obqbJODmpuu2q
   eEle0wlEuClQAsllHHBOGNztW0BBLNL3I1hNw96ZFTAYireFFkE7ZfXWk
   eSDJN7zpHWyQRcfpd47jPNWIQZ4G+q1udDXaUTH+R9nTtf1NTFRjBROZo
   osL3caWUNpT80tWWoPo6XkKil50EOp0ySLZVf6JFazUApswvEG/CnXTXu
   2ntc+fGc3xb93jvJ1K2JB5W25ItNAdVLpAi18TyVtpReTCqJjWtmNcbur
   g==;
X-CSE-ConnectionGUID: 6Tw7sv29SWSCY9sJ69iJJA==
X-CSE-MsgGUID: OZ4j8sE6RtuEqT3BWnfP5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="70306610"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="70306610"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 04:02:03 -0800
X-CSE-ConnectionGUID: GpAut//gRyCl+IhlaiXl2g==
X-CSE-MsgGUID: 8VnlLzk2Q+CTYQ7M1lg+kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="208934757"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 04:01:58 -0800
Date: Tue, 3 Feb 2026 14:01:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Dmitry Guzman <dmitry.guzman@mobileye.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v6 0/3] i2c: designware: Improve support of
 multi-messages transfer
Message-ID: <aYHjtLckF01dOX48@smile.fi.intel.com>
References: <20260130-i2c-dw-v6-0-08ca1e9ece07@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260130-i2c-dw-v6-0-08ca1e9ece07@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 30, 2026 at 04:52:28PM +0100, Benoît Monin wrote:
> Add support for the I2C_M_STOP flag to the .xfer() function of
> the designware driver. This allows grouping multiple accesses in a
> single call and changing the target address after a STOP flag. This is
> achieved by splitting i2c_dw_xfer_common() in two functions. The core
> logic handling the transaction is now in __i2c_dw_xfer_one_part(),
> while i2c_dw_xfer_common() loops over the messages to search for the
> I2C_M_STOP flag and calls __i2c_dw_xfer_one_part().
> 
> Handle controllers that lack the ability to emit a RESTART when two
> consecutive messages have the same address and direction by aborting
> transfers that contain such a sequence of messages. For those controllers,
> we also check that we do not get any unwanted STOP caused by a Tx FIFO
> underrun, as they lack the ability to hold the clock during a transaction.
> And we set the irq as non-threaded to prevent underrun on PREEMPT-RT
> kernel when filling the FIFO.
> 
> The I2C controllers found in the EyeQ6Lplus and EyeQ7H SoCs from Mobileye
> lack such capability, so a compatible string is added because this cannot
> be detected at runtime. The corresponding DT bindings has already been
> merged and is available in v6.19-rc2:
> 
>     d9b85d296f3a ("dt-bindings: i2c: dw: Add Mobileye I2C controllers")
> 
> This patch series also simplifies runtime PM handling in
> i2c_dw_xfer_common() and amd_i2c_dw_xfer_quirk() with PM_RUNTIME_* macros.
> 
> To test I2C_M_STOP and other message modifier flags, I posted a patch
> series for i2c-tools[1]. With it, i2cdetect shows the support of the
> protocol mangling and repeated start skipping functionalities, and
> i2ctransfer can set the modifier flags to the I2C messages.
> 
> The series is now based on i2c-host tree and only contains the last three
> patches that have not been merged yet. The first and last patches are
> functionally identical to the one posted in the previous revision. Only
> the second patch contains modified code to use PM_RUNTIME_* macros
> instead of ACQUIRE()/ACQUIRE_ERR(). Thus I let Mika's Acked-by on the
> first and third patch, and dropped it from the second patch. I hope it
> was the correct thing to do.

Looks good enough to me, and if anything, it may be fixed later on.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


