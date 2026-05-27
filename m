Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17785354AE3;
	Wed, 27 May 2026 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779885385; cv=none; b=fLRpQIZoTXuusdGAs2r1e75ghbYRpb7LSeltQVVr2qemJ9UNfs1l69TWD/dR4kntUjf+C7dVJafGygOtCi0qfE9yS0TbkpqzqX13D9R2UgeAF/Tn9HlUsCCDTjmnLGwLRhHi8qokeUlbD9ZAL0U9PwcNoS9LTPpQ74mOg4EHMWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779885385; c=relaxed/simple;
	bh=pnVCDz07x9Vth109X5vAaSuDKks11Pzst/9ZQ1IoMYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyqZAxi/Jtza57rr8VTZi6ORv+V9hMse81gBsU3IEmrfriT4YM3Pg60fjR4OJGPGhNYOzU1y8ujvkDdpcxsFQK46duX5zGoAs4drr0CuxDAASLyC7kPFFAY+/2sgOFKcaalrdVpEn5m/DnGIN7/VcegO1wuF+z1V7mYSC5qNK+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UZ/ZIBlV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UZ/ZIBlV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779885384; x=1811421384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pnVCDz07x9Vth109X5vAaSuDKks11Pzst/9ZQ1IoMYQ=;
  b=UZ/ZIBlVvZWDUMcEN7BT+RiHCUZHjOUqwd2WXm3dVL5kA/3x3VOzBJRZ
   4kDCYTmp/1ljnJDSd4+2O+79qcpAWD7MNbjQXeoN8AUTLDiRgNCnk5VbQ
   zHiBIDDaV9iIC0k2cKYZ0owUWx47wNIl4C7ao73jjOOS9iSSh4FR1wmpS
   VylCmcCYx3MqzxYsxcQ/1VUWpz1nARMVfjcDtrtuxjQ9+v/Cf3tS+Ykos
   FGWHCrByW2pQN9MqzEcUKXij+fZ+w5ZdH50y6dRrEv3N79N795ftsnkxV
   1C/5kp9EvU/QUW3/fhyCuNqfKqxUFxDILsOFlQalP5kABUJMJRcSCGhzX
   Q==;
X-CSE-ConnectionGUID: iun0HzcPRweGl6idLfiu2w==
X-CSE-MsgGUID: IjBQbFcFSSK3gsQ446VbGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="91284899"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="91284899"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 05:36:23 -0700
X-CSE-ConnectionGUID: R5AEwubTQDuxgeEghe/lfg==
X-CSE-MsgGUID: GJlFilVaRzOq6xR6MBEldQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="235851340"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 27 May 2026 05:36:21 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 97D1295; Wed, 27 May 2026 14:36:20 +0200 (CEST)
Date: Wed, 27 May 2026 14:36:20 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "lianfeng.ouyang" <lianfeng.ouyang@starfivetech.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] i2c: Add Starfive JHB100 I2C master/slave support
Message-ID: <20260527123620.GD3102@black.igk.intel.com>
References: <20260527085039.44435-1-lianfeng.ouyang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260527085039.44435-1-lianfeng.ouyang@starfivetech.com>

Hi,

On Wed, May 27, 2026 at 04:50:36PM +0800, lianfeng.ouyang wrote:
> From: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
> 
> The Starfive JHB100 I2C controller is a variant of the widely-used
> DesignWare I2C IP, with a distinct register layout and enhanced features
> such as SMBus Alert and programmable FIFO depths.
> 
> The series is structured as follows:
> 1.  Adds the device tree binding document for the starfive,jhb100-i2c
>         compatible.
> 2.  Prepares the existing i2c-designware-core by exporting and making
>         certain key functions overridable, allowing code reuse.
> 3.  Introduces the new i2c-starfive-* driver, with separate modules for
>         master and slave functionality, based on the 2023-07 revision of
> 	the Synopsys IP manual.
> 
> Currently, due to the following differences, i2c designware cannot be
> fully reused
> 1.  For high and low level counting settings at different rates, i2c
>         starfive can use IC_SCL-H/LCNT to set SS, FM, FM+, UFM
> 2.  Interrupt clearing is achieved by writing 1 to the corresponding
>         bit of INTR_CLR, while designware reads different clearing
> 	registers
> 3.  Master and slave require separate probe callbacks and cannot rely
>         solely on the runtime mode switching provided by i2c_dw_set_mode()
> 4.  The value of FIFO depth is not obtained through registers, but
>         written through DTS
> 
> I have written some poorly styled code to reduce changes to i2c designware
> and reuse its functions by keeping aa always true, for example
> 1.  the implementation of i2c-d w_probe_master() differs only for the two
>         IPs in i2c_dw_set_timits_master(). In order to reuse
> 	i2c_dw_probe_master(), i2c_dw_set_timits_master is declared as
> 	__weak. A better approach is to use a callback function, but using
> 	a callback function requires changing more i2c designware files.
> 	I don't know what the attitude of the community is
> 2.  For the operation of clearing interrupt flags, i2c designware reads
>         and i2c starfive writes. Therefore, in order not to modify the
> 	relevant logic of i2c designware, I added a write operation to
> 	sf_reg_read()
> So I think this version of the code is not allowed to merge, but I don't
> know how to handle this situation because if i2c designware is not changed
>  at all, we will have to write code that is similar to i2c designware.
>  Will this type of IP not be allowed to merge?

It's not that you are not allowed to change the existing driver. It is
definitely encouraged to avoid unnecessary duplication. If possible think
of the core parts as library that your glue driver can call and if
something is missing you can always add (or modify).

Also while there, let's start by adding support for the master operations
first and then later on you can add the slave bits.

Hope this helps.
