Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F27A376BD7
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 03:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769051382; cv=none; b=qHFSEUxO5dRhRjDueQr/7kFAy7Wfszbr77ApYZdrJ9ceFYo4n3RgPLGeLhktuVq5VJjrS/yepW6bNp/SgdX4CKG4EgT0/4rFmbfh6slr+0ULUwrLxGHRBVb8c7CqxuO2MYuuVGHF3WNoBF4ULfAmkDteQLncrnEprDoVBDA7ET8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769051382; c=relaxed/simple;
	bh=Z6aritqo/qFOafguf8ca1A0ks9hmI7a+qZZHVW2b87Y=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=syittNYSnE0nG5YkGonElr4TwQ4VFVIZNKedmdVKysrDFpx3NiV6o2VA6i8mzEF0C3FrYEk0eXydlH71cIk6ipzgJ2P+TOeHId6IHAujOBBg28dmU0TnzgouA3koWJDXSSbgm2hDryPHAmM3zcONNqGsdt/aeqrHbykEIY45JYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BWtQQdrY; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BWtQQdrY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=Z6aritqo/qFOafguf8ca1A0ks9hmI7a+qZZHVW2b87Y=; b=B
	WtQQdrYA4t60wQI8J3PzivMdUg9XOi0U5RGK5h6YI2reYYVJXplP7pCHqRYU8ZUZ
	WlTH1Ce0sqV4+vCpjHL3foo4AfgB+x6GJN6h4airJtsyGcucR9Aj13Umg0jonQEJ
	uk+DEqUTp767yfeaYSCmXalaQ1IyZOTOJ8MTFSEE+U=
Received: from junan76$163.com ( [182.148.52.15] ) by
 ajax-webmail-wmsvr-40-141 (Coremail) ; Thu, 22 Jan 2026 11:09:36 +0800
 (CST)
Date: Thu, 22 Jan 2026 11:09:36 +0800 (CST)
From: junan <junan76@163.com>
To: linux-i2c@vger.kernel.org
Subject: unsubscribe
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2dC/yevkss4CKeY+kfn0gRhuY2UMays/0k2YJTc+sGtRjT/gIlcHZIF2PK/t6GOyuojha6TSNJ1MJxV5la8gCIjnQu88FlAqT2rcNUsQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5bdc4c4e.2f27.19be3adca95.Coremail.junan76@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jSgvCgDnxyHwlHFpW75cAA--.55560W
X-CM-SenderInfo: pmxqt0ixw6il2tof0z/xtbC9RAYyWlxlPAGpwAA3p
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CnVuc3Vic2NyaWJl
