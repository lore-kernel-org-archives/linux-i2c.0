Received: from ns1.suksangroup.com (ns1.suksangroup.com [103.13.31.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342E32EEE7B
	for <linux-i2c@vger.kernel.org>; Tue, 14 Jul 2026 05:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.13.31.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784005449; cv=none; b=lf68dvolwhwi0OBVoB2w/x41O4IF5uxfrPw02Z7nVHqxdZrHWi3oMB2mx3lA5XcdOl2L5deXhTQWP5zBWcUA7/NqXKaWpmkCDa0C3FbI2sPq+mLNgD8GfZwGPigxJZzFMYBOXBQ52Fo98fEBHqI1TsAJtrXfRL5K7Sy2QIFh3eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784005449; c=relaxed/simple;
	bh=x59rmfF4vpVjk44F9ruZYhc9IQI0zu3U7VgP2+azhgg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UAfArkwM6D15BzyhU0dQ4HTKJkpLfzl02eubWnnkwUAXU5LOVR2nVp4x4j+fGtT6HC8BrgTFhR2fVVeKshr8DVfm/eil+sEmyg7cGRNn8IVfFtd/dyqNb247zkIczR8wIecPKTmIfwg19mhvUqe8iab662aajQ0tFbJOh5XrHgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=inbox.org; spf=fail smtp.mailfrom=inbox.org; dkim=pass (2048-bit key) header.d=suksangroup.co.th header.i=@suksangroup.co.th header.b=x8uygTLp; arc=none smtp.client-ip=103.13.31.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=inbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=inbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suksangroup.co.th header.i=@suksangroup.co.th header.b="x8uygTLp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=suksangroup.co.th; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=x59rmfF4vpVjk44F9ruZYhc9IQI0zu3U7VgP2+azhgg=; b=x8uygTLp/wAfBX1rM3VD1Q+2TU
	ehKd4isFwVY2vZeUvOfsx4Iyh1k4zlBPFErtFGUdrUA2TW4lKSWpumZGuHacptp3TRimhvkC4o9Ui
	xMGg+Nt0OKzISAouMELZN9F+OU2Sw513vxY/gYBD10oGpyudB8qILfnrCW57f3CvqAjtxKyLWt6l5
	rKGGORSvVUeLwM5KoMBYBP9v3dVWRGMQRMEdnqHjsJAAAwdCPyl99zKqauoagRmZF3vQRCmW3GMnb
	58Nl56vqAZI/g6zKBNg6NVtiflRgkXXL1+t8z4NQKiaqquq32i5ziJhaYpbVEDxZZ+AGB0AeFzmAM
	hCho4DvQ==;
Received: from [207.189.26.187] (port=57336)
	by ns1.suksangroup.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <info@inbox.org>)
	id 1wjVJG-0000000FjxW-36Q9
	for linux-i2c@vger.kernel.org;
	Tue, 14 Jul 2026 12:03:57 +0700
Reply-To: hanns.schofield@lexcapitalgrowth.com
From: Harry Schofield ESQ <info@inbox.org>
To: linux-i2c@vger.kernel.org
Subject: Dear linux-i2c@vger.kernel.org, 
Date: 14 Jul 2026 00:03:54 -0500
Message-ID: <20260714000354.F471E5C3D2F0F57F@inbox.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns1.suksangroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - inbox.org
X-Get-Message-Sender-Via: ns1.suksangroup.com: authenticated_id: smtp@suksangroup.co.th
X-Authenticated-Sender: ns1.suksangroup.com: smtp@suksangroup.co.th
X-Source: 
X-Source-Args: 
X-Source-Dir: 


Re:Good day linux-i2c,

Please let me know if this is best email to send you the project=20
info.

Kind regards,

Harry Schofield, ceMBA


