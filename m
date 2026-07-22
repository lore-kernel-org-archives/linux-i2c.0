Received: from ms2.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438F51A3166;
	Wed, 22 Jul 2026 01:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784684574; cv=none; b=CnRxKwOJfbWuEfVZsnDjOs8+V9lb+LBqQAL9d9LWxmjKnfEw1EVLq0KaqoM+CXi/33PUXMfMWpn3Fh75yt69vS/Qp1TEaKaHgyn9u7hqiE0A0Z1APYhIjiziHfFWoXGE0zXvyo0OvGGie6jMlBPDxlmjobPUNyLR88yd+437sjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784684574; c=relaxed/simple;
	bh=KHXNBa2UYoPJtdSyKMFEcXggwzX77eVeH4VKKGrOksA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dcWKmIxtXyCS++MZw6YsetVIDTXapRmm1BRd5PBp2+Hp2jHB10h7Did+IVPIUv44PYxL4hnUA55VqDm/iRv7iUeDuBH7I21tO+Lh1yjxYIRzK0Y46MNAfQ1GQnx+tX0R61IOR2dOPrSBXH1CF57nNp96ejV5gUcShjCENOAciLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=MAuZAVdV; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="MAuZAVdV"
X-UUID: a4678f50856e11f1b694ffd7d3467620-20260722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=KHXNBa2UYoPJtdSyKMFEcXggwzX77eVeH4VKKGrOksA=;
	b=MAuZAVdVwcy0mcVwn6bgMVX3Yi670iZVTM3Rn53T/uOjqazkFNv+GNgOXh6JQzvb9dNXmxwv8jTFMp+RduldEfPoumTiMXKgOagKGD7XQBuR6D9Wj2T06ua14cSCV4+FuIb+TZfdbE326lVCjshviy1Iz/+R7Kx4P9G+G96cH3s=;
X-UUID: a4678f50856e11f1b694ffd7d3467620-20260722
Received: from spmgt1 [(172.20.13.10)] by ms2.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 427451413; Wed, 22 Jul 2026 09:42:47 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.13.160])
	by spmgt1 (Postfix) with ESMTP id A29831A1E1C;
	Wed, 22 Jul 2026 09:42:47 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id 9D2F2C600CC; Wed, 22 Jul 2026 09:42:46 +0800 (CST)
From: nina_kuo@novatek.com.tw
To: krzk@kernel.org
Cc: andi.shyti@kernel.org,
	ben_huang@novatek.com.tw,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	shihpei_hsu@novatek.com.tw,
	toby_chui@novatek.com.tw,
	Ben Huang <Ben_Huang@novatek.com.tw>
Subject: Re: [PATCH v3 1/3] MAINTAINERS: Add entry for Novatek NT726xx SoC I2C controller driver
Date: Wed, 22 Jul 2026 09:42:35 +0800
Message-Id: <20260722014235.522348-1-nina_kuo@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <25ae1ecc-b7f1-4132-81f9-7bb91f1a5d3d@kernel.org>
References: <25ae1ecc-b7f1-4132-81f9-7bb91f1a5d3d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Huang <Ben_Huang@novatek.com.tw>

On Tue, July 21, 2026 at 4:09 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Please do not top post or remove context you are replying to. I have
> like 200+ emails per day, so what is this about?

Apologies for removing the contents of reply mails.
Quotation of replied contents would be added in further reply and patch
mails.

> Please learn how Git works, how its history is organized, how commits
> link to each other. This is nothing specific to submitting patches or
> kernel development - this is basics of Git with combination of
> bisectability of software development cycles.

The organization of these patch series will be adjusted for next
submission.

Sincerely,
Ben Huang
