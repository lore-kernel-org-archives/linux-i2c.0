Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BB013C83A;
	Sat, 10 Aug 2024 21:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723324498; cv=none; b=V/2DDNl2ued1XehdlIgTMpHjQJB0N1/XEg3GksFgA2JGrD8iyFRPbMA7xZ1x7/whZlxApMUdWbumvF/B/wc7l1lod0hlOl7z98PltphNgu28oZxuZVJGhWY0z5IvbAwd0bknVo0wBGRzvqnkpuQkUyDWZEFzLNrEynxW9f5ULcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723324498; c=relaxed/simple;
	bh=Mmz5bDfV++7x8DjfC84OFSyZbA0Kvlcrx5bqBGBxYfI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K8GgEA7G9tJgDzTCkCOOeE5S3zOFouuJz8PPKdA8Ve9o1NNdYY+fawrw8JQdInb3CN6ALjARVjVP7dMnfTL9kmFe6J6CyYtkvt1GXbyztkpa2ynYhF74UFTW9NHuQtXLLDEY1l/ew5m3yMeWjJGSS5iJdpo4owiDT8DfFYj17U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b02.versanet.de ([83.135.91.2] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sctQH-0007Ui-4H; Sat, 10 Aug 2024 23:14:49 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: brgl@bgdev.pl
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	ukleinek@debian.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 0/2] giantec,gt24c04a eeproms for qnap ts433
Date: Sat, 10 Aug 2024 23:14:36 +0200
Message-Id: <20240810211438.286441-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the binding and dt-nodes for the product-data eeproms on the TS433.

Heiko Stuebner (2):
  dt-bindings: eeprom: at24: Add compatible for Giantec GT24C04A
  arm64: dts: rockchip: add product-data eeproms to QNAP TS433

 .../devicetree/bindings/eeprom/at24.yaml      |  1 +
 .../boot/dts/rockchip/rk3568-qnap-ts433.dts   | 20 +++++++++++++++++++
 2 files changed, 21 insertions(+)

-- 
2.39.2

