Received: from Atcsqr.andestech.com (exmail.andestech.com [60.248.187.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE19A2F547F
	for <linux-i2c@vger.kernel.org>; Fri, 24 Apr 2026 03:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.187.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776999819; cv=none; b=LfYLn9FiiXxmuXhnjabAJTu+UteQAwduC3FV3n5BuV8TZ1R7NR3jmvPRYNg/suhdHXkIlhNy0TjNdStqS92DHnXtfsQfsZrxsYVa71d5fy+kmA8lzlOWG9s2woWJ4mDH6fmTDhqfMojV9uDwdobxpxtyTQZM8xEV1XOnNinJRxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776999819; c=relaxed/simple;
	bh=DpdF7i7RIdpYC9jJYdUnk7bPBgKHzUfgMtUSkivqVp4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bN1CcKDNBF0tVXji+x9w3IjISMgMwnm64jUnxZrNskKTBNe/8y/fvi7Q73m86c/7+kVadVNydcy7e4G/yEHifKVQCxxKpBCHyPbrqR8Uaxz0YYiJZfKY6SN+PzGQpQxFPzWOQnPNF2rXofMPfH1bUr/AphVxF5yetxWdJSuZeT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.187.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 63O2bDET060499
	for <linux-i2c@vger.kernel.org>; Fri, 24 Apr 2026 10:37:13 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 63O2axDs060195
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Apr 2026 10:36:59 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS31.andestech.com (10.0.1.89)
 with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 24 Apr 2026 10:36:59
 +0800
Date: Fri, 24 Apr 2026 10:36:58 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert
 Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Conor
 Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 0/4] i2c: add support for Andes platform
Message-ID: <aerXSoA5JZKr7d6n@swlinux02>
References: <20260330-atciic100-v4-0-d40822f63e4e@andestech.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260330-atciic100-v4-0-d40822f63e4e@andestech.com>
User-Agent: Mutt/2.3.0 (2026-01-25)
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 63O2bDET060499

Hi all,

Gentle ping on this series — it's been ~4 weeks with no review on the
I2C side. Patch 1 (binding) has Conor's ack; patch 2 (driver) has not
received any feedback yet.

If there's something specific in the driver I should address, I'm happy
to spin a v5. Otherwise, would appreciate a look when you have a moment.

Thanks,
Ben
