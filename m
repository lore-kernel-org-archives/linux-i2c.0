Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D1C3F58E9;
	Mon, 27 Jul 2026 10:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147728; cv=none; b=Ngc+UYqqn19XHRt8ejhl42vdfYwl5whqy81hydVGE9Xg30t41h+918txik1UzkitQaPNf+/aqrMguuAV/1KAP8UBxYO7lC9Oc5Y7jJ9ZyyEQK9aM4UqHP8lkloStM0BX8bcmCtfbLVObiKRaBPO9JzXvjH48Pnb4ld7+5cJEb9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147728; c=relaxed/simple;
	bh=C9HJ6eByHTY2KuMJ+CkOIFHan4gnKHBTRtyYpX5oLUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIF/95YpYjZ8Mnrg5fmqxn/wTHp6DBxKDh86OMYLxYrsIkn2LMNhZA+H68YCqGurE8tiU2p2E6QBm3aFNXorPYS+7nzjdZP/oqij0xhUwzS3k0Hec1dxeRRcrVxJCoJZS4bABvA1bCcX+NzvPkKyffA81nkohpXjbdUR0+CaWGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aZHsMSUG; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aZHsMSUG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785147727; x=1816683727;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C9HJ6eByHTY2KuMJ+CkOIFHan4gnKHBTRtyYpX5oLUg=;
  b=aZHsMSUG0VRu/DDjfvD5yPYUtQ/k5YHFDrCjMgKu5VPRA8k3xF+i7MPP
   wSulSMMEYqfHEb/XsgICmaHR5fPA9gaeNoRa3LnsiWfYQ3Ykbl9yZ73x/
   WgU4wgtV3JXa+kh84/N5zagk6QbL3u0GQZM+FWfET6tvbQBHiAsq/x+BN
   lGxBj/+8l9B1lD5aTcVNKVhN271LOVfteYZuZ2lmBCL0SNyzrc7vsPu1Q
   YKwv7FiybTA/c5RIgtxjOUB9BsqT66JKX/iybD/i6OCVovGPZeObyzKwH
   c4Pd3CHsf+7xwos2F5d/80ojD3F4M7XoJCfP0ppZ/Mm0L/2sHC2nm+sbZ
   Q==;
X-CSE-ConnectionGUID: ckPXfH+8RECm0RScJ/ERKA==
X-CSE-MsgGUID: BP6pImRWQrql6gmMXRCoJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="84688987"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="84688987"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 03:22:06 -0700
X-CSE-ConnectionGUID: I3ZfdP2yT/6Pa21cwl7qqQ==
X-CSE-MsgGUID: lKFaiLkqRBenZu0qW7lcmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="257591228"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 27 Jul 2026 03:22:02 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 6069E99; Mon, 27 Jul 2026 12:22:01 +0200 (CEST)
Date: Mon, 27 Jul 2026 12:22:01 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Min Lin <linmin@eswincomputing.com>,
	Yulin Lu <luyulin@eswincomputing.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>
Subject: Re: [PATCH v2 6/8] dt-bindings: i2c: dw: add ESWIN EIC7700 SoC I2C
 controller
Message-ID: <20260727102201.GD2365036@black.igk.intel.com>
References: <20260706081055.1126275-1-pinkesh.vaghela@einfochips.com>
 <20260706081055.1126275-7-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260706081055.1126275-7-pinkesh.vaghela@einfochips.com>

On Mon, Jul 06, 2026 at 01:40:53PM +0530, Pinkesh Vaghela wrote:
> From: Pritesh Patel <pritesh.patel@einfochips.com>
> 
> Add compatible string for the DesignWare-based I2C controllers present
> in ESWIN EIC7700 SoC.
> 
> Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
> Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
