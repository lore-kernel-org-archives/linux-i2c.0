Received: from ms1.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A463DA7D2;
	Fri, 31 Jul 2026 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785492662; cv=none; b=Zlse5TtaaBnWqb2un3pBEqpYL28+OCZ6him4J7YsGmamjGS9gal1vS30/ErvZKd5B31JR/F5cIwYUUOexOLnZnx0zxtvlM8zs2NJ2cZRtp9wrRLVepNCYlLslse1eQP8JVAeGkL70eHcavRu+kYBz/f4gSR3oxn8ncTXjHRvKMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785492662; c=relaxed/simple;
	bh=XNX8WIdEwPt1FF9mrMNkeC34WAybH8CUD4SdbNjT2Jo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dwq1LM3haOmj1n1zVYZb/IWgyJz1aqc3qWqyQXRlat5W3JTZUQ61ddJTOHLoGZu6NvTU/ZNuLc9wnvZTzCItKbSJ4xsQnI57sbJawjrw36QdB5eriGURluor2th7BsjWOXREW1omrP7YrnB/e0AXzsORMreS0OWk4X7CgXMNDDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=brKn7XiL; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="brKn7XiL"
X-UUID: 18b4be188cc811f181a149c3f3c08161-20260731
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=XNX8WIdEwPt1FF9mrMNkeC34WAybH8CUD4SdbNjT2Jo=;
	b=brKn7XiLH0DyGL//YiKKou/kNysqhgHE0ddn39IWugApyFVOA2rNqTsRmRMWDlMTUAy8QcJZ3ThovAGh9jT/CFoSXnphOr20mw1QKUUeAJTTYkzirei9m05NUYnEw1inbVchFR3ugGMbFw/eNHERYLyLGcpEpXabMIKgn2JbtMQ=;
X-UUID: 18b4be188cc811f181a149c3f3c08161-20260731
Received: from spmgt1 [(172.20.13.10)] by ms1.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 1495471596; Fri, 31 Jul 2026 18:10:46 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.13.160])
	by spmgt1 (Postfix) with ESMTP id 0E55B1A1E1C;
	Fri, 31 Jul 2026 18:10:46 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id F27C1C600CF; Fri, 31 Jul 2026 18:10:45 +0800 (CST)
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
Subject: Re: [PATCH v4 1/3] dt-bindings: i2c: Add Novatek NT72676 I2C controller
Date: Fri, 31 Jul 2026 18:10:36 +0800
Message-Id: <20260731101035.599828-1-nina_kuo@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20260731-caped-miraculous-quetzal-1fffb7@quoll>
References: <20260731-caped-miraculous-quetzal-1fffb7@quoll>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ben Huang <Ben_Huang@novatek.com.tw>

On Friday, July 31, 2026 5:34 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> +description: |
>
> Do not need '|' unless you need to preserve formatting.

'|' will be removed for the next iteration.

> You miss clocks.
Currently, the I2C input clock rates are hard-coded in i2c-nt72676.c, which is
not ideal.
 
I will check the proper way to model the input clocks in the DT binding and
update the driver accordingly.

Thank you!

Sincerely,
Ben Huang
