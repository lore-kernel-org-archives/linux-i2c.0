Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B058D3033CD
	for <linux-i2c@vger.kernel.org>; Wed, 18 Feb 2026 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771427386; cv=none; b=PCu1MZemeICXU9WFUwH5Ai6rFW6yU/lANEvhLPpDbA5+Y/kH7A+IIk8KuZvvn94g8px1srYIyOVjoPjSawozYQhRdOQlczyiEJgcht6bry4aaRl2VHtYa+80dNDZI9aHJRrtXtc2FjPuS8kCyiBsdeReTrodAgNeG5pep7PSTdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771427386; c=relaxed/simple;
	bh=59k6AAUQAcMyQRtWHtilwXm0Zvem5eHHNDBv4NZviqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jMJ5kN4D0Tdb1/yvo069O3Lvmor1rMljKXk7IBkloCfVBUK9xAuCVBE/LNutjqZYVlEApHH5RY8f07xvjV7MjCivtjF/g7hUHT/HmMR6WZK5Vd2e5v4ZaSPKX2GHi5TBnUwyOqZViMiJV1egwULEwjqxCD3que1d/NmoC/Q9vGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5sXE8YH; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5sXE8YH"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-436263e31abso5174386f8f.1
        for <linux-i2c@vger.kernel.org>; Wed, 18 Feb 2026 07:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771427382; x=1772032182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=37iDQjIpWJV9G//cF72AU0D/7XMD1Sk3hL7SaalPYgs=;
        b=H5sXE8YHNyHATKxE2WGNFl5BWlFgpJxX4wuDC9Vo0/lw4GnupNjEy4AY1zYKCldhSf
         LzIyXZhp3WgrjWxqqWFWbnaFPpMs7Na7uU+gQvBNwtobTBXSHyxRLok9ly+/bAwRvhLE
         NnRmTUSb1y0oHXAl5L00csL+xOCBtO2be864WhurAt13Vxb53iRrfdPVUuztzPZxTKAT
         EPfCxexl1vtSR8LBiNfLrDAGOQDJnLGspntM5PlbD+0hx0aMjmfCSYM6ccKvCsXPDPAq
         fZuvmInzl7f0jEsi1cl0OQ6RRmo/pjk6yeh05xgp0CKnxMns5/0Lfejwny3vgwaYUKRz
         2hKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771427382; x=1772032182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37iDQjIpWJV9G//cF72AU0D/7XMD1Sk3hL7SaalPYgs=;
        b=C+/swo9/cUyBeBZIe74xAFXIOxkfRlR3N1ZLxswuMnZSWH8ubmm+SJUhraZh7RbDHO
         DjBmYU4jAKQc3pe7sP91vUP9o0RlpO+7FrUnE+U0x5qwxcUzUc7yJVb8KzRSfqzcXLbR
         7l9dFyNXBEtCAmfy0Knx/YXdfpONTQab3CVRhCq52DhSj1YB4XLfAuIgyU1NVzD2CMOT
         AsWS4LE9Pvrkin8b1dfSU48RX/zlqvuR3KHBxQOGlYit7pHfhNch2FBCPsH+qkINLvSR
         fwJD8qewsVPBnSCYNXIbuz7y1+AzCwJVV/ypZ9aNIsBnBooP7wtA5HYGBHkkCRJel0/p
         WmFg==
X-Gm-Message-State: AOJu0YzZqiZ7uzfa6eqVfLU1WDMNP/ABd9sGMHq9iL7gFUxe6SYYH8ke
	70EJBlS4xrg7nDE6IzD2dQngCMmIzxOwo9VbZFZKPsEyE9zf0EG98IR8BVKW2w==
X-Gm-Gg: AZuq6aJ/TXkVxgrGTu9opRya4VTAV+dLfZ4jDUtMUEd/CmJ/wItsOlZ/DTeUScvuf3U
	7WKtRVCWay47vp633A6sSyvfCrEXta47zshfK/iPzA7Mu+jw5w1ytuDVbEdXpn0yk4ClZrP/yd5
	sCsEKC8MmSA8EkwNtDYPLP7OtmL46knQrMu93nCrDyfyP5WRXY3mhVIQrhxvq/sn/USWWgDceGC
	Y7/Dh28v4Ry+bb7QRg5Rf9NyUDGYlCXrXBFZUzlVW9U6InYa3TICSyqJbRJy2g0056YHioT7J+P
	ei/dAlgBh/JMj4Pa170dFtT7PsHliRbel2w27yvTtOtpHv7GnvxJ1UhB2vIij5WxN0przM7xqKD
	2l1+OdI4ujoongAw2QT28DzxBW6XxPwPzfa3ZN7/aAtXX4QYmXrjb6okzF+ukldLNe/oE6Cu0Q3
	5fMnwP6fUShMPGoPvpyVXIX+/LpfssQcTU2dVOViQrWTpF8O65xbb2qOg21Sa7VpHbAI+jpbdlJ
	w9e3xl1mzdIcrYWIXrrnSINFmo4BxMQ4XTh
X-Received: by 2002:a05:6000:22c1:b0:436:18d3:25 with SMTP id ffacd0b85a97d-437978c99d8mr31041272f8f.10.1771427381872;
        Wed, 18 Feb 2026 07:09:41 -0800 (PST)
Received: from eichest-laptop.corp.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac7d91sm44333116f8f.26.2026.02.18.07.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 07:09:41 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	andi.shyti@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	stefan.eichenberger@toradex.com,
	francesco.dolcini@toradex.com
Cc: linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] i2c: imx: fix i2c issues when reading messages
Date: Wed, 18 Feb 2026 16:08:48 +0100
Message-ID: <20260218150940.131354-1-eichest@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes two issues with the imx i2c driver when reading
messages. 

The first issue is that after a repeated start the bus is still busy. If
the driver polls for that bus busy bit, the driver will timeout and fail
to read.

The second issue is that after the last message the driver should not
immediately read the data from the data register or an additional clock
will be generated. This can cause devices that react to that clock to
misbehave which will also lead to a timeout.

Stefan Eichenberger (2):
  i2c: imx: fix i2c issue when reading multiple messages
  i2c: imx: ensure no clock is generated after last read

 drivers/i2c/busses/i2c-imx.c | 51 ++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 19 deletions(-)

-- 
2.51.0

