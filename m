Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453243F4102
	for <linux-i2c@vger.kernel.org>; Tue, 30 Jun 2026 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782811540; cv=none; b=B99IgqT/Qc4SbD/whww9EKjbxXM3H8PUZrSiTAgNwCnfB78+WL9uM8Rult/6OBlMtwqOjfnvKDOGTVD4iP6iIgC22vmBMPX8ZBc/ebfBSWGPvmLOPnAAEMEE29BnxfI/mQXx5PsRtOhdVVJphQriyVEJvXvEEOzgeoVSMKZUeZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782811540; c=relaxed/simple;
	bh=NAtrWD+d4P0TMFU9DluvY8cQ9Bodo12E/8l8UGetdYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qEfxJpCZVpZVHMx17yj6sMKede+uTPXfVh3KWhicIfsNcrwx7zIj3a2liDbf0XVhlVuX+BOezJA1JMy4VYOKfczeysIR9mE4SynE/aRbRLTulZskkbYfGFLQTew7MIOba/omZUsTVkR/rGzam84BSMAHSBLrF4S64BXeiC3ZGYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=jf2hwzyq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="jf2hwzyq"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4939a809b24so27381335e9.1
        for <linux-i2c@vger.kernel.org>; Tue, 30 Jun 2026 02:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782811537; x=1783416337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bj6VKsBeadn9yUFsVdXEYzz0RYtZkQbeSiFf6Tl0PfI=;
        b=jf2hwzyqW0FQag9EkUYS46LTwxg+UXMMM5zHbmC2OEoErDpDff6+50F7GL9zhLPfAu
         Zl6RYyzw9ZIBUsleJbs3Evx/fyFVp8RjrO2Htv0Ue9XlzOzFdXJ6yKIPRFd30QuHO7qt
         pSt1HtYhDVXmKTsZUoYghmDZLsHbaOpkEAgWaqwiBQton/FCX2mkvtWsuzjFRPlf2xio
         Mqm11uwYjAXShv62+eEBLdAX8X5FeJDV7BYlF3wPijIfIQriYmmI7jqwB+8ONslG5A1V
         b+9KMHbs5ECWlGqZZhdlCLeVrwzMChatIJMpoFGkOR7TdkZ417VSqP84WSFiMxXT67rJ
         xo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782811537; x=1783416337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bj6VKsBeadn9yUFsVdXEYzz0RYtZkQbeSiFf6Tl0PfI=;
        b=iYtKfLriA4yby3aZUdBoEJYN3scFy/EJy7pJ1qpCAI3Mgws0va+wHU4lKKToQz1lH/
         OyqIYhm3nqvOXA+H6gVHqXgREYH+/H3UuWgiZYJRBTSWm/9o4nffw8EsVclc+C0oP5wA
         jYiZHNrsEpZPQu6zwIDSRtslpyikcGslwxg7bZGD93S4srVZnvxU3slRvbOVmXYgzSEd
         effxHj7TKtlxk89JlMXhSlePOH6UUrz2J8W1kqfCGUjoRFgxC6oIbjgfAYEJ/5WVL5mA
         wdLlJc4/35OMuhuKYk/wON0cQAieQG636Oe/YXHtIXWs9ajLtQ3EMAf67arHe0gqkUHD
         6QDA==
X-Forwarded-Encrypted: i=1; AFNElJ/qdyUAjGHCj0iKgrw8Fb1LaRCPEba/eURJmwfQWJQ9pcNI//IgPhXd6TBLkZO42He25J0w5M7wvng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5CVomau0qZS0rR3ZQ6K8oTKfIZVmk4DD17GDFol/xfVUCeEWd
	+0MKyWc4UAu1nYs9oLrN4nBmZ2C88n7cB7+B6jZPNq03CBycEZsT/5lIm5dbdC8NG50=
X-Gm-Gg: AfdE7cktlccba86AHwGjPmUOgLJDqqBslHbpKDcKTNiOhEus0aaUS0e/TyoabYfbigw
	KKqEVTuCDMqCv0dNuuw11IBPvY82ky7L1C7XcOfcRHT2d31bVPX74nJAFnoEpccDsTczl6yAdZc
	5Qjd4SDgUDCpVO4A5MOqXweHyuk6fKdWi14T0Qg68BFJjlcoDtXs7eZvyMPusLDA4mnX28WpxK1
	5b9yiZoyIVhQcDUHa1hR+4wis6BQ+8czn3JXGJyMxCZ9OJBOKrSLIq2VUAA0X6HTNcn14sSHlMq
	nncL67sKdE0iEF1berBFv4AokvjiXiizM2GqrdawuJnTxRUbYJFvrKCHenuae++AoCZtY+kxe+a
	HHh02CNJMTxhOzCk15r350hLyQAJiWxRmSe8bgqKBlIlFMZttWK3fql5KRXQ7ZSIdBVgmEch3wp
	D0zhPlgDGjOg/mJI4mFM0i0ifhhZZdpA0Ce0Pz7+9yATF+V5P20whT9/Dl+cosbuAQX1Q+LEsiG
	W/Q
X-Received: by 2002:a05:600c:354e:b0:493:b6e2:1b0f with SMTP id 5b1f17b1804b1-493b82c4a28mr40295625e9.33.1782811536844;
        Tue, 30 Jun 2026 02:25:36 -0700 (PDT)
Received: from localhost (p200300f65f47db042c439d749f38355a.dip0.t-ipconnect.de. [2003:f6:5f47:db04:2c43:9d74:9f38:355a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47563d195besm5705097f8f.2.2026.06.30.02.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 02:25:36 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v4 08/17] i2c: Let i2c-core.h include <linux/i2c.h>
Date: Tue, 30 Jun 2026 11:24:27 +0200
Message-ID: <46aa85ab3dc4e63bfb5bd8ff1fd212a3d0e31f58.1782808461.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1782808460.git.u.kleine-koenig@baylibre.com>
References: <cover.1782808460.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1125; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=NAtrWD+d4P0TMFU9DluvY8cQ9Bodo12E/8l8UGetdYw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqQ4tcNILET7C0OEuw6doSv0hlBvtyWRxeQrIOF 7a5LQ1O3iCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCakOLXAAKCRCPgPtYfRL+ Tn6sCACfKgqs+XWZe9/SrPMerZ+Xqh8lptH8PXGAoNuSC7EOYcuqY7ADcb1NeBmTu8sLjviSWXq 2BsQiXeBY7g0qL2kHnd2svYhTRdxIVDIj6Em0pUPobHGNmNZ926gMkfUDK9kApYYI02akQahuZd vpEOHvbXFX5AkI/dwg3S7nvhns1c/Yj8JUBZ5WOcwUsWdcINYkT3vXI7TKYs1/cXAeQ+QK/dMeS f2Yx1SNUaPJTgEYY+erGpgTPUWisOq1/4Gp8KFMLiY7qiShr1Ok73ZkgKkvwB5LdcR+Xlu3tOjZ W14wenqHmyKLy75WjV7/ux9nFNsGF8XQg84Cgj8u1t385PLx
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The subsystem private header i2c-core.h uses several symbols defined in
<linux/i2c.h>, e.g. struct i2c_board_info and i2c_lock_bus()). This
doesn't pose a problem in practise because all files including
"i2c-core.h" also include <linux/i2c.h>.

To make this more robust add an include statement for <linux/i2c.h>
making the header self-contained.

Acked-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Link: https://patch.msgid.link/c176fb7e8503d61e08f055a5bb1ba4989aba6ffc.1782682124.git.ukleinek@kernel.org
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/i2c/i2c-core.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
index 4797ba88331c..c519da536647 100644
--- a/drivers/i2c/i2c-core.h
+++ b/drivers/i2c/i2c-core.h
@@ -3,6 +3,7 @@
  * i2c-core.h - interfaces internal to the I2C framework
  */
 
+#include <linux/i2c.h>
 #include <linux/kconfig.h>
 #include <linux/rwsem.h>
 
-- 
2.47.3

