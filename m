Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39919423172;
	Mon,  2 Mar 2026 17:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772471939; cv=none; b=Flfyd0AriJ/yMeE7o0dY5fK+5ut/EntSTpx47sF+1HIhAwTH1dRCAf+I0AgNIofbH6LTDHN6UP71TX9Rek0TAHg19YfkPncehoSe7wCqR+wlmlK4aifFm50B5k2IfSJcMD7bEUPwSh4mr0gEYnqOZLBNCfHlK4BjyNdvwPM5dfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772471939; c=relaxed/simple;
	bh=g1vqFUt1Z9IpI4yyJnkzfJf8OPvVe4uRQcvXwVjgK3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=anMMtNFyIsBq1qboXL9kUMxzw1/uZw6W1lbne16LY+/OQq75jnjX+prT8RF4BkN91hNc08mjCWHCNtih7cqjnNAqn+uLgvRGqR3wJ5nhHcBR90k+m2U40MWUZgB967HF4UQ9V8IZqA+lZnd8V3ZRyigDWLuF1w8JJEloT+tNSeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=enRKCzLU; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="enRKCzLU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=1/PFKsC3x2rQIjazTw4u7Nrje/IHAGLQnp+rVOfH0BI=; b=enRKCzLUB6sTPlMYulXCAVQ0jL
	8PR/G12yiMyXgVzCmvNg8ITa45Kg6Pb8LN1UC33U5YU9QIfE+b2ScZU15GB8B1toPZzGPqAi4XbIp
	jl63PivxUcv3rPZAAcNr4BHCFpHt7BOOV9ZQpfzfduz/aLflwdLaeezcWW2IKWymYHqrxeyLqORDn
	rgCajzVYD3M5nGdDD58Ze5jf0a+UTBeKJ+cDRl5y7+M233kgnplPPVIjsHKvoGYAsumt2xWS4Hvee
	EnJjpx69fo721dZ1n6Az1ska9I3a4AqipCNOC1J4r2LHOHe5kCkpIRNeb/HiK1Gegiu2fEShjJ9Xg
	X9YonGmQ==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Mon, 02 Mar 2026 18:04:42 +0100
Subject: [PATCH] i2c: i2c-core-base: fix devicetree alias handling
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-i2cfix-v1-1-a95418e9217e@kemnade.info>
X-B4-Tracking: v=1; b=H4sIACnDpWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwMj3Uyj5LTMCl1Ts9Rk4+S01JS0NDMloOKColSgMNig6NjaWgA+WsK
 CWAAAAA==
X-Change-ID: 20260302-i2cfix-56ec3cfedff6
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Frank Li <Frank.Li@nxp.com>, Linus Walleij <linusw@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1208; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=g1vqFUt1Z9IpI4yyJnkzfJf8OPvVe4uRQcvXwVjgK3U=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDJlLj2Uemyf68UhxYM/JrSmXE758/6ws5fJv3gufNwJFf
 yUObq3O6ihlYRDjYpAVU2T5Za3g9knlWW7w1Ah7mDmsTCBDGLg4BWAii9cy/K+7a3HwwgOhn0L1
 Jzt28ecI7j/5x+nPbLeTHQYNDyoXa15kZLjuJc+6NTZO19o12Ovf5g+vsn9PmG8l4maZM6XcYhW
 vBi8A
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Parent device is not set up there, so use the new of_node pointer to
handle aliases.

Fixes: 0ab80451c70f ("i2c: allow setting the parent device and OF node through the adapter struct")
Reported-by: Kalle Niemi <kaleposti@gmail.com>
Closes: https://lore.kernel.org/lkml/EDF3FB58-4747-442E-8463-6F1C6E568962@gmail.com/
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/i2c/i2c-core-base.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index dd8cec9b04c6..e22d784202b8 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1657,10 +1657,9 @@ static int __i2c_add_numbered_adapter(struct i2c_adapter *adap)
  */
 int i2c_add_adapter(struct i2c_adapter *adapter)
 {
-	struct device *dev = &adapter->dev;
 	int id;
 
-	id = of_alias_get_id(dev->of_node, "i2c");
+	id = of_alias_get_id(adapter->of_node, "i2c");
 	if (id >= 0) {
 		adapter->nr = id;
 		return __i2c_add_numbered_adapter(adapter);

---
base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
change-id: 20260302-i2cfix-56ec3cfedff6

Best regards,
--  
Andreas Kemnade <andreas@kemnade.info>

