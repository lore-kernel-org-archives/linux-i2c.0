Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1828191F94;
	Mon,  7 Sep 2026 07:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764835; cv=none; b=cbgh5/ldXiFit21zwfAsjlxHSWMF5b4IIQPL/EY8l75NyCSoEynnvWAslNRj7VzJw+qIfECFgQNxBeoN1O/zsLH08kbegrmARZd7LXp04YupWnSBsDOGVJtXjWzoD9Bdn937htej1VRvfWFOli79iSovXyw1yZLWrWFxfoysF+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764835; c=relaxed/simple;
	bh=jUpI8QmY2zt09p7fJfntjnzIJU02xge66mO+Uvr+eHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nJuBZUGiHlLGRv5ZYn4TQbE8dQ9UEks5aGR0PACXlYylut7ybkihauz6tA0oS+Nl/d4xVVhsPdzPrBFP5KRjUs9WMDK9KSV7mDBYZR0BBGhGV4nEv/OLnsgrwzpJirN1xIhHy3eYWsCgVhT3K+gLk52xwKMnwZVOPc7OYmX/194=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: bc285a7aaa8a11f19a56ed5b684f684d-20260907
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:7ee0efd5-45c7-43e6-8cec-54db9a498778,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:4e9c6f7c6b1d8e5d02603cb27829e052,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|136|850|865|898,TC:nil,Content:0|1
	5|50|99,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bc285a7aaa8a11f19a56ed5b684f684d-20260907
X-User: gonglinkai@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <gonglinkai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2007751916; Mon, 07 Sep 2026 15:07:06 +0800
From: Linkai Gong <gonglinkai@kylinos.cn>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: atr: fix dangling adapter pointer on add failure
Date: Mon,  7 Sep 2026 15:07:03 +0800
Message-Id: <20260907070703.1021671-1-gonglinkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <anszXdhlAJk7p7ts@ashevche-desk.local>
References: <20260806073545.2071006-1-gonglinkai@kylinos.cn> <anszXdhlAJk7p7ts@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 11, 2026 at 05:36:13PM +0300, Andy Shevchenko wrote:
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> ...
>
> >  	if (ret) {
> >  		dev_err(dev, "failed to add atr-adapter %u (error=%d)\n",
> >  			chan_id, ret);
> > +		atr->adapter[chan_id] = NULL;
>
> It's better to NULLify first and print after. This will reduce the window of
> possible calls with the stale pointer.

Agreed. I will send a v2 that clears the slot before the error print.

Thanks,
Linkai
