Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E246830595B;
	Thu, 22 Jan 2026 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769091519; cv=none; b=fv+6wr8xGy74c336WNgLOUb6QVujyh/FBQDFimAhgq4JcHCvtMIXfsfKGeOwq7UyKrtFQRCL05ZQVyJ2ffa1k8lTdrzqT+KLGMlOaWt7CNPMxPpAwV+YPVjng9cF5zQl3L9cbK4IrsYqhrK/VpnhmWrVrCK8VswH9/8kwAJGlXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769091519; c=relaxed/simple;
	bh=xHyoy3gOZ3D9x2lDxIGnNg30+Y9jPnz3tKr7/dQ28d4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxTgngXvvfVyH6Y4kYK2WixaTqQUPoJfagnUTNd8gEqGX03hohYngM8OSmT1sJSWDS597F2p/UeT5jM8eT9bYVsEH7LPjyIpeSK3meJ2rY4VD5FWkgFo8tdlDVoJOemzGyRGhLdXigJGKsclHxT5B5hdRDC5qp54STlqfoAcgWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTP id 60MEEGmV004846;
	Thu, 22 Jan 2026 22:14:16 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from ANB420.andestech.com (10.0.12.111) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 22 Jan 2026
 22:14:21 +0800
Date: Thu, 22 Jan 2026 22:14:20 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To: <andi.shyti@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-i2c@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <alex@ghiti.fr>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 0/4] Add I2C support for QiLai SoC
Message-ID: <aXIwvACl3sQuYLE0@ANB420.andestech.com>
References: <20260115145244.435890-1-ben717@andestech.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260115145244.435890-1-ben717@andestech.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 60MEEGmV004846

Hi all,

As Krzysztof said in patch 1, this series should be the version 2 of
[1] with detailed changelog, not a new series. Thus, please ignore this
series, and review [2]. Sorry for the confusion.

[1] https://lore.kernel.org/all/20250207021923.2912373-1-ben717@andestech.com/
[2] https://lore.kernel.org/linux-i2c/20260122-atciic100-v2-0-7559136d07cf@andestech.com

Thanks,
Ben
