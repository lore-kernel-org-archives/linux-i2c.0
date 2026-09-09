Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD493AC0C2;
	Wed,  9 Sep 2026 08:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788942091; cv=none; b=MAvJnQKWa/ns6xRt/chWgbU4g1KN/kDXy64h4hRKL3UAN5N559uETgQ0l4t2Ipx9xyc8QSCiBIooxlzrePJ7t/ogP6tthcasFMZ9aNy3Kh8aDjVF/yk2v6rseXBxk4enhjKa/r7+n+3S774GOW0dTcvL8JPuY0KZgmvo7lbaZME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788942091; c=relaxed/simple;
	bh=xfb0Wzew+R7zeB/yi0ZYgBmPemtk8sPpgjFzx6ncOs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHfa2URIlu9+72qzEXzRCPcPA0qPoTkJ0Qij8iU2ALMowk4OsoEro4O1OrIsPqh0ggHCpvjwAsbWEV0j7IpObBkEORzWtOiR6cbZ8PqrOQaZbso5iOWdKUMW6SaN7WFuq3XJt4odHJ4a0hTuuCDoLyJexVzhr4NGp1eft5o+JNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8CpD/eD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8CpD/eD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05BA1F00A3D;
	Wed,  9 Sep 2026 08:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788942089;
	bh=htpSjkXY6vojAXd63F4/3HumHgDzCLRSNWNnl4AdJTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I8CpD/eDkyw/BDcPDKAI1JvO7dgdGy5Ppv93Y3ztOmnDDZCDHuJUwG9rUt8GQXcpb
	 zRQUeQtP9KbJzSPn10+nbVswAd+2HpNBifrqcSQq2DAwNxgk2ppa2Q+16fshh/o+46
	 HmNckY56VujToRUjYe4/8xTB9GIUqlSHk2mEkBF36FFb/ysPWoAcupDCoezp+XfCCV
	 qicDsPVocMvmz3K6kjcWl0KYq36IOMnnZJsuKJ1Dqq8FIBFg9/KwQR2DqeNVwCoSLF
	 0AlgnfLocb2SCHtK9UfER6zuoo6y6dAGVpAkffQQcIZX0sCvE/omy8+oiWBTAsWb59
	 gRaEH+vi0SbiA==
From: Thorsten Blum <blum@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <blum@kernel.org>,
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Subject: [PATCH RESEND 2/2] i2c: Change return type to bool for i2c_check_functionality()
Date: Wed,  9 Sep 2026 10:20:56 +0200
Message-ID: <20260909082053.410739-5-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909082053.410739-4-blum@kernel.org>
References: <20260909082053.410739-4-blum@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=981; i=blum@kernel.org; h=from:subject; bh=xfb0Wzew+R7zeB/yi0ZYgBmPemtk8sPpgjFzx6ncOs4=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkLxZ7dDStyiWFrm5zrbq8wpSGDOaU8sm9WY8SLuf/ei c58pFzVUcrCIMbFICumyPJg1o8ZvqU1lZtMInbCzGFlAhnCwMUpABNZwMbw38nU9+bGH2ppd5az M2xkSZ7xWbyk49Vxzvm7rOfPm/z+4jNGhkbXBw/fK11+6F0gv8NTxkMiYkm7bNOjq5fel8/UNOZ S4gAA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

i2c_check_functionality() returns a bool - change the return type from
int to bool and update the comment accordingly.

Signed-off-by: Thorsten Blum <blum@kernel.org>
Acked-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
---
 include/linux/i2c.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 14ab4d3055af..4af2df969a05 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -919,8 +919,8 @@ static inline u32 i2c_get_functionality(struct i2c_adapter *adap)
 	return adap->algo->functionality(adap);
 }
 
-/* Return 1 if adapter supports everything we need, 0 if not. */
-static inline int i2c_check_functionality(struct i2c_adapter *adap, u32 func)
+/* Return true if adapter supports everything we need, false if not. */
+static inline bool i2c_check_functionality(struct i2c_adapter *adap, u32 func)
 {
 	return (func & i2c_get_functionality(adap)) == func;
 }
