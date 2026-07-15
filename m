Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7823731197C;
	Wed, 15 Jul 2026 06:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784098264; cv=none; b=MOg0liWiuSVjjKmlzn1bW8wbxqCOE/ihaymxIcOOEMYHSC0k4eU+zmJyGuppyhEVeUw/fz093ve9B9InTQHAyG4Zu70mukyw+AAEYOCiyXXmNd56oL/l/70o2u4DYXIASjEGbW2OgW7N6URcvoTg5GyiIKTQ9Ix/FbkzC3BDzuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784098264; c=relaxed/simple;
	bh=Kf5iFx/H7Oqazj4You+NJk5Cr462LYWEnHLr3t8qGJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nsGze9jpfX58d9p9UDH3cS4NdU9XhNNj3twBbbtYVRtgXbXN3vMmgmI8rMEOjUA/Bo8mCyT8FJfStOMjx9XUax9ay1bgSTiDqfw8fKUjlRQROG9W/bFKicm+C8z+ddH8Ulx9NyhLC6pI4qRtqXrTL58ut5U35X4MgvSVMyAZPIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=TCsrQf0f; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="TCsrQf0f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784098244; x=1784703044; i=markus.elfring@web.de;
	bh=Kf5iFx/H7Oqazj4You+NJk5Cr462LYWEnHLr3t8qGJY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TCsrQf0fFPX2M9ALbL5aomS8Af4Hf10o/wgA54obukIniIS4fhElF1Igu7vgDfs/
	 dm34CxBXWmj+63tA+4RLWYyEqdEMdZWO4Eg/lJFxTxXYZTPurkenHsGoTlLKj4SaF
	 5PGXAEo4KfxA048MwXc04fVL8Ne0uMb3RG/bPlrGUjm4TSBWjrVSyd7Wt1XvroCfo
	 fwnvKBgH5Zy3dkiuUw3A1ZPEcMYBeSxlXGNsGRvNviuJ5OlID5X21SZKCgMwZdQ6p
	 skx8W1pMcmzGatjhNOjZav6SMAnuUO9z/f3DvFPOIiXe9ou5rFR8uVxb31xshlI8O
	 iXoEOpOK9gIpFIgckQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MF2gW-1wqT2h3KOm-00EK3m; Wed, 15
 Jul 2026 08:50:43 +0200
Message-ID: <693e0bee-6522-4d6a-803f-3bbd0ea2243b@web.de>
Date: Wed, 15 Jul 2026 08:50:41 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 1/2] i2c: imx-lpi2c: properly unwind resources on probe
 failure
To: Carlos Song <carlos.song@oss.nxp.com>, imx@lists.linux.dev,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@pengutronix.de
Cc: Carlos Song <carlos.song@nxp.com>, Andi Shyti <andi.shyti@kernel.org>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 LKML <linux-kernel@vger.kernel.org>
References: <20260630105223.3687516-2-carlos.song@oss.nxp.com>
 <f6284d81-75fa-4418-b4f6-531163bd02cb@web.de>
 <5fp45u3yuwz73nk6eeofx5fp5drvaqxp435mithslttb73zylb@t2s3se5a4qux>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <5fp45u3yuwz73nk6eeofx5fp5drvaqxp435mithslttb73zylb@t2s3se5a4qux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:5g9+4PnFGin4TKW+0JEB+INZPsUEFxIwpEmldkaL1xfEUP/4ulb
 bvcZJ/7/74/u85Op7aEo5pagcD/8sYhWit7fpfbb1aGaKFuo3EP3SpiCFTxaT/favL4ZlLk
 50DgqwDYkMrXJYjFrc3z6MVJAoz8N/MNdh4bCFRFkukC7Msa8SijRljsJfs04K7eC3Bz4AV
 eZ28hKBy8yFE0C3ejlkXw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AVNG5ggCihc=;HUFFSq5Wvt0QAXZ7ps+YXqdAvSa
 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
 =

> Does it look better?

I suggest to reconsider missing tab characters in the indentation.


https://elixir.bootlin.com/linux/v7.2-rc3/source/drivers/i2c/busses/i2c-imx-lpi2c.c#L1471-L1583

Regards,
Markus
