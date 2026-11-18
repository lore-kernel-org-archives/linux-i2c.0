Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991699;
	b=2xEECGuQtpJo7Y4zG/IRWGecXZC3VVYimfxElqbk8P5GAc2rokN8NnKuaUszG2hC3bn0
	 sTEoUEwCZ/XOnoRLCq7tSl+CnOZlIBtJsRKYXyvtBsWWEinKY7OoENcpuohxECaSMorKB
	 AYVX8+ztrzhVRQU8sjli5v0m5WAGZTENn1fl5bTfdNaoI9J+xZ7MFv4xlh7w9R0dFdXBc
	 J5oesA0xNoxs58jyitFxnvCwz8TVxZZZL7d28cG1rX3L6A+cI/nWnCbp+Twu5dthRe2by
	 0im15ZjO3g7v/HRgful/DiTMWv4OiGO+Yxi3pkx5F8f9mNsseAI2NeI21f+uSnbhwwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991699;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=vJGcGSSjcKVHc6b8pVWGQNzThgXfLhxChnkSyknWbOs=;
	b=S40muIj386MFmaK11+NcMvcYSthAGjW2U+ZuPdoNpop6BMJE98M4JM7OefoF8thfNk2O
	 ebpIj6CsCwFDdkOt9QgcfPmMiTtVYKDXzt+Tl34H0eJZ5IfpU3XQMf+hzaF0KU5vKkty7
	 QiOjIvI+v8SfQTf3B+5trdXV3pHb+09JRghwwZ5rqsOx8LaXXh3zwwhKT7hKaPg61ybXk
	 Utdr/RXH9AH+7lOB6NIEIWMp1OHqKv28hLbirUR0Pap1d15xzgnW0OWKbWa/qizI2Hj3E
	 gqfcqwute2yRO9WA0cayRBmUJKzEqaf0wHugBKXU1QBoSxI9AtuRFbrSrA1WXNgS4hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ysm2arwL;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62D5606A31C;
	Wed, 18 Nov 2026 08:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B62D5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ysm2arwL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794991699; x=1826527699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=69uAnuF7duZcZRgShYJQb+omDDGQbvMHTSaXAjeuHeM=;
  b=Ysm2arwLc4yWJtrS3jJm8EPD7bXmdSsJ3l2Tn4yOSCuOBh28Kgm7s3py
   ChZKKirumDYCbXQU+QVeXVE/4Dm5n8q1mBFasAfJSAGUryjGSL5nwDvr6
   CExDUXQdSJTg1l82RRiJHnfx/262f/HA85g9dq4e5IJXdz3LSyR25uZPo
   /XlqXTYGEBV+nrfYzPKXBQgaAEdjM/TtW8IGTk2WFFopmN2nnq1MoXWPC
   JIl585spQE4kr0IfWMbAYgeI8+Wo9ez3vKwM21K5gpHAKH0FS0Vhj9Pxi
   HFUvJNLb/7Ye0Fzrjlzi0kS95zL4WfLhLz7z5YModvt7JptQAczZSsavq
   Q==;
X-CSE-ConnectionGUID: r5F1zIk0SxO9q8kw28rdBw==
X-CSE-MsgGUID: 1ATpYjD2Sm2esOOfVuS1Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3816789"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3816789"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 00:48:19 -0800
X-CSE-ConnectionGUID: 7OikgetmSnmgLK4gxGWkzg==
X-CSE-MsgGUID: wD5IT/7YQQWIqN7+H0Q0Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10097320"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.157])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 00:48:14 -0800
Date: Wed, 18 Nov 2026 10:48:12 +0200
From: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: "jk@codeconstruct.com.au" <jk@codeconstruct.com.au>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v33 0/5] Add ASPEED AST2600 I2C controller driver
Message-ID: <av1mTEtWCf8zFbjp@ashevche-desk.local>
References: <20260623-upstream_i2c-v33-0-6d5338fc56ed@aspeedtech.com>
 <TYZPR06MB79202A00572E81CBC29399F4F27A2@TYZPR06MB7920.apcprd06.prod.outlook.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYZPR06MB79202A00572E81CBC29399F4F27A2@TYZPR06MB7920.apcprd06.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 18, 2026 at 08:14:51AM +0000, Ryan Chen wrote:
> Hi Andy,
> 
> This patch series has been stable in our testing on AST2600 hardware,
> and we have also received positive feedback from customer testing.
> The issues identified by Sashiko have also been addressed.
> I plan to rebase the series onto the latest upstream kernel and submit v34.
> Before doing so, I would appreciate your feedback on whether there are any
> remaining concerns or blockers that we should address.
> 
> If there are no outstanding issues, I hope the series can be considered for
> merging after the next review.
> 
> Thanks for your time and support.

Are you asking me or Andi Shyti?
If it was to me, I have no time for this right now, sorry.

> > Subject: [PATCH v33 0/5] Add ASPEED AST2600 I2C controller driver
> > 
> > This series adds support for the AST2600 I2C controller “new register set”
> > implementation.
> > 
> > The AST2600 I2C controller introduces a revised register layout which
> > separates controller and target functionality into distinct register blocks, and
> > extends clock divider configuration and packet-based transfer support
> > compared to the legacy mixed register layout used on earlier ASPEED SoCs.
> > 
> > The current driver implementation for the AST2600 I2C peripheral is through
> > the hardware's "compatibility mode", which exposes a register set that
> > matches the previous generation hardware (AST2500 and earlier).
> > 
> > Instead, add a driver that works in new-register-set mode, to allow the new
> > features, and will provide support for future hardware that will not implement
> > compatibility mode.
> > 
> > In order to support the new mode, we need a DT binding change to reflect the
> > reference to the global register set. Since the binding still represents the same
> > (AST2600 SoC) physical hardware, we continue to use the existing compatible
> > string of "aspeed,ast2600-i2c-bus".
> > 
> > However: since we're changing semantics for an existing binding, we allow
> > backwards compatibility by selecting on presence/absence of the newly-added
> > properties, and fall back to the old driver (ie., in compatibility mode) when we
> > detect a DT using the old binding spec.
> > 
> > Specifically:
> > 
> > - ast2600-i2c-bus nodes that provide the `aspeed,global-regs` property
> >   (present in the new binding and absent in the legacy binding) will be
> >   successfully probed by the new driver
> > 
> > - ast2600-i2c-bus nodes without `aspeed,global-regs` continue to use the
> >   existing driver (in legacy register mode), ensuring that platforms
> >   with the current DTBs remain functional

-- 
With Best Regards,
Andy Shevchenko


