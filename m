Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7843E37C0E5;
	Wed, 15 Apr 2026 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257932; cv=none; b=UwoexN4SYKUySC0FIPjxWiNOVaRh9W80QnxalOT4FOFMTD58jJpxkWR+vTwhuTDtG1fF7JnIbUeGIOkj1fKy9epO8e3rSL7wFMumhqiagJ8kKu3eKmJqVTDodoBEvzxMDYL7LTjE605Uqdv6IAgYnotTctNiCK8F3bzHojKdopk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257932; c=relaxed/simple;
	bh=MQYgVFhYG/avcSqZoRiPFb57/f6xcQJ69RySC7jdhVQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SQaZHms510ubcbODZKFuFFOf91VC/xZKUz5bmqn6srvvS72bXKsesuSd3T3Wq8NyU4l7OCiQkiAFolvPMd4ts00gJcUcZZYdN3Im387b6NStLWPhuoQKwJWd2yJher0P0nOTPB1+dqB2BTeketQv+9c/KPA/QqW+RXTRwHwRTAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=CfI+CMqJ; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CfI+CMqJ"
X-UUID: cfb2de9e38ca11f1ae70033691e9ac7d-20260415
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=MQYgVFhYG/avcSqZoRiPFb57/f6xcQJ69RySC7jdhVQ=;
	b=CfI+CMqJw0u4NY2RulnJwfFwk+jcyRy6ZN/zg44N/rokGaLx3fAn0Q4lbbl2N7hf5IBQILqr7oh711+t56H/q01wU9SabDyj0Mt91EOWONYYy4H48Vi3kjApN9zAjADA/VsDyYFQVGRtX3sOiOxEzvNib21hnaactdO3g1JnEdc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:0df25f3e-5b90-438a-b26e-13d892e9983d,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:9022758f-6df4-4a3d-a7a4-fbdc42d669ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:83|102|836|865|888|898,TC:-5,Content
	:0|15|50,EDM:40,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cfb2de9e38ca11f1ae70033691e9ac7d-20260415
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <adlavinitha.reddy@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1739490256; Wed, 15 Apr 2026 20:58:34 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 15 Apr 2026 20:58:33 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 15 Apr 2026 20:58:33 +0800
From: adlavinitha reddy <adlavinitha.reddy@mediatek.com>
To: Andi Shyti <andi.shyti@kernel.org>
CC: Qii Wang <qii.wang@mediatek.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <linux-i2c@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v1 1/1] i2c: mediatek: add bus regulator control for power saving
Date: Wed, 15 Apr 2026 20:58:32 +0800
Message-ID: <20260415125833.2579133-1-adlavinitha.reddy@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Hi Andi Shyti,

Thank you for your guidance on formatting and submission rules. I will study
the documentation carefully and ensure I properly send patches in the future.

Regarding the multiple submissions, I sincerely apologize for the confusion.
As an intern here, I encountered some unexpected internal email permission
issues when trying to send the patch. In an attempt to double-check whether
the email successfully went through the server, I mistakenly re-sent it a
couple of times. I will be much more careful next time.

Thank you,
Adlavinitha Reddy
