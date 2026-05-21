Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A5E352F87;
	Thu, 21 May 2026 04:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779339314; cv=none; b=lMH6kGRYCE83vGp+5ockyoVoxydGEXv/bvM2xRgjQqZeZ0+gAyB+HtxrYabzxCVmP5mLOu8AuFQUFkVhGjzeOnaaVQqcM/nBxq+n3nPeoJiNfzVdwfjqlsOYgoxVv9xdQVYIj0YtxuWGpdJ7HotQQFBkALmlaBAhbWWWISyvbNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779339314; c=relaxed/simple;
	bh=a3hTZuYGs4Hx9PRIW8SWWpRBNGI+VN4U3RIM3YaSOjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xx2F87A0Wz81Vvw20uPbRBkY4hz2oWWGsoK2NJuHoBSMVnBpi421oX6U7X/YtPLezWPUDuw+eG8sGCWSdQAB/L5u2l7kqpDb0Mvc4q3jt9wPsxuIjmCRjd0n1AKtmbzR0hW2nyRp+CMvBMBmBrcKAhR3ki/Ud+0U6l9F29qqYtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ftXT+ejr; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ftXT+ejr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779339313; x=1810875313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=a3hTZuYGs4Hx9PRIW8SWWpRBNGI+VN4U3RIM3YaSOjo=;
  b=ftXT+ejrdRBvUYW74hL46ciqfun6yu+eE2RtIIFpS2ndlUnN7GV+6iKA
   C2lnlmN+pxp0e41tS3i9ItGRi5fG73UKYuHCu23Jbb5Hf9Y6eWUpULIFT
   6UJhJQiSHOSLujg5HJ7zs1xwomf1RVbTURzFQ1O2ukfmVoo0/zZ2OGqNT
   WL5W1MzmkNv1Gt3rhNlQRColWgALrAg6FbNyMfr7pzJyWwb/09sl2e13w
   al46/tJjQioh7VbyUEs3aATjkRrHiNwPne9LNET5Km0Ty2IrRwdDxcKsW
   0P9tRUVVgEqQZ5ZP9o0yu1hP6lWSC6e+Q0QaMbSTXGvSLlxZfQrRNRPkE
   Q==;
X-CSE-ConnectionGUID: eN118laYSymrnvUYLX08EA==
X-CSE-MsgGUID: cQyvL5WzQfWEIGHz8Qwj0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="82830471"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="82830471"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 21:55:12 -0700
X-CSE-ConnectionGUID: /hZpi2cqS/qoC2NwbiDQxA==
X-CSE-MsgGUID: 0BEROaXqTGqSdmgWYCRC+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="237393566"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 20 May 2026 21:55:09 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 8717095; Thu, 21 May 2026 06:55:08 +0200 (CEST)
Date: Thu, 21 May 2026 06:55:08 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "lianfeng.ouyang" <lianfeng.ouyang@starfivetech.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] i2c: dwc: Add I2C DWC master/slave support for
 StarFive JHB100
Message-ID: <20260521045508.GF8580@black.igk.intel.com>
References: <20260521034340.27837-1-lianfeng.ouyang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521034340.27837-1-lianfeng.ouyang@starfivetech.com>

Hi,

On Thu, May 21, 2026 at 11:43:37AM +0800, lianfeng.ouyang wrote:
> From: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
> 
> The Synopsys DesignWare Core (DWC) I2C controller is a variant of the
> widely-used DesignWare I2C IP, with a distinct register layout and
> enhanced features such as SMBus Alert and programmable FIFO depths.

I wonder why they did shuffle the registers... :(

> This patch series introduces support for this controller as implemented
> on the StarFive JHB100 platform, which utilizes it for both master and
> slave operations (e.g., for MCTP over I2C).
> 
> The series is structured as follows:
> 1.  Adds the device tree binding document for the snps,dwc-i2c compatible.
> 2.  Prepares the existing i2c-designware-core by exporting and making
>     certain key functions overridable, allowing code reuse.
> 3.  Introduces the new i2c-dwc-core driver, with separate modules for
>     master and slave functionality, based on the 2023-07 revision of the
>     Synopsys IP manual.
> 
> Key differences from the Existing i2c-designware Driver
> 1.  The DWC IP's offsets for all key registers are redefined. The driver
>     maps to the correct addresses by overriding macros from the core
>     header file in a new header (i2c-dwc-core.h).

Instead of this, can you provide a regmap that internally maps to these
shuffled registers?

> 2.  The host and slave of DWC IP need to perform probe callbacks
>     separately, so they cannot be directly set through i2c_dew_set_mode
> 3.  Interrupts are cleared by writing​ to the corresponding bits in the
>     INTR_CLRregister (write-1-to-clear).
> 4.  The DWC controller's IC_ENABLEregister contains an additional
>     TX_CMD_BLOCKcontrol bit. When enabling the controller, the driver must
>     ensure this bit is cleared. When disabling, only the ENABLEbit is
>     cleared, preserving other configurations.
> 
> Lianfeng Ouyang (3):
>   dt-bindings: i2c: snps,dwc-i2c: Add StarFive JHB100 bindings
>   i2c: designware: Export symbols and add __weak for DWC I2C driver
>   i2c: dwc: Add StarFive JHB100 I2C master/slave support
> 
>  .../devicetree/bindings/i2c/snps,dwc-i2c.yaml | 120 +++++
>  MAINTAINERS                                   |   7 +
>  drivers/i2c/busses/Kconfig                    |  34 ++
>  drivers/i2c/busses/Makefile                   |   3 +
>  drivers/i2c/busses/i2c-designware-common.c    |  57 ++-
>  drivers/i2c/busses/i2c-designware-core.h      |  25 +
>  drivers/i2c/busses/i2c-designware-master.c    |  14 +-
>  drivers/i2c/busses/i2c-designware-platdrv.c   |   6 +
>  drivers/i2c/busses/i2c-designware-slave.c     |   4 +-
>  drivers/i2c/busses/i2c-dwc-core.h             | 192 ++++++++
>  drivers/i2c/busses/i2c-dwc-master.c           | 441 ++++++++++++++++++
>  drivers/i2c/busses/i2c-dwc-slave.c            | 180 +++++++

Also the naming is confusing so if you need any glue code I recommend
calling it i2c-starfive-* instead.

>  12 files changed, 1068 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/i2c/snps,dwc-i2c.yaml
>  create mode 100644 drivers/i2c/busses/i2c-dwc-core.h
>  create mode 100644 drivers/i2c/busses/i2c-dwc-master.c
>  create mode 100644 drivers/i2c/busses/i2c-dwc-slave.c
> 
> --
> 2.43.0
