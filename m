Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBD1322C73;
	Wed, 12 Aug 2026 08:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522456; cv=none; b=EGo3hZxdi2nshFsHDpjOWZtH/Z1MejFJQ+Id1JWB24jZqSbkcsVQwmhSg6Nj5Zc3hpUnQPIKeKu2U2rcWns7K1BeT4ELJkpStHjdujFglOc5If45hxC510dOtK7qRqSSsh14V0BRPL7asaFpAx9fd50R20F/ntMmgTczidJK3Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522456; c=relaxed/simple;
	bh=HvQX/2Rs5cWjOSR2OA0sfGHcFc/E/NEVlRNuoNJTMvA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dWRvhK5pOF50ywVcBEI3DEyA1gLjFEAQ3wMPIlFydEUMlnco1ANE0ik8JvO4Hc9FdSlPrdrtC3KAerZtdTMf2etfENWLQLfi+IQvFsTrai7WBdn4ZEf8KU/bNp8HUZEqixnR8y1A1XMoR6Lb4dv0DNIZtR58j6r4Ddvszt97ufM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4H4xvsb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4H4xvsb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFCF1F000E9;
	Wed, 12 Aug 2026 08:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786522455;
	bh=CfRowpTKWivqNOVD0wmF3ZNKzhjEZpNIgeQTNYVCSLs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=n4H4xvsbIqPb+e35D6mMMVzNZkzuE1LgSmtDq+xcLOgbUu6Mp2iZkRx0jRcQckcqu
	 pEk79ElOzV0MnLBbgqG76IIAIB2ulx3RRqc2zAvIxWuNuxpRH+g5xHyN+jYrCHKJIU
	 qE66rv2o+kcLqcT8UIAD6Mmsjun2+twXamDLlOPwtzcPnNAcQtk9ULMo2Feb2RiJi5
	 G4cisuXsT1VfXBjj29VBD2vGPQuMV+nsZPsxtdjmp0KHAq57iiGiPQP/NRvQBu0CZT
	 Axjl0XLxTC+M0FTTT33SHJMwzSHy3pIdPVD9/vuWRPIlb4/wO0e2vt24q4UBoS99GI
	 okI5fRp2ToOYw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Andi Shyti <andi.shyti@kernel.org>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Min Lin <linmin@eswincomputing.com>, 
 Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
Cc: Yulin Lu <luyulin@eswincomputing.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Darshan Prajapati <darshan.prajapati@einfochips.com>, 
 Pritesh Patel <pritesh.patel@einfochips.com>
In-Reply-To: <20260804104431.1391839-5-pinkesh.vaghela@einfochips.com>
References: <20260804104431.1391839-5-pinkesh.vaghela@einfochips.com>
Subject: Re: (subset) [PATCH v3 4/8] dt-bindings: mfd: syscon: add ESWIN
 EIC7700 compatible
Message-Id: <178652245137.1296549.3383858473929288179.b4-ty@b4>
Date: Wed, 12 Aug 2026 09:14:11 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Tue, 04 Aug 2026 16:14:27 +0530, Pinkesh Vaghela wrote:
> Document ESWIN EIC7700 SoC compatible for syscon registers.

Applied, thanks!

[4/8] dt-bindings: mfd: syscon: add ESWIN EIC7700 compatible
      commit: d86dadc6feeaa86b6a29db5509bfe8c65b66c7b2

--
Lee Jones [李琼斯]

