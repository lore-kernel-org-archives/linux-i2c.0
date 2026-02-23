Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB7930C37A;
	Mon, 23 Feb 2026 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862360; cv=none; b=SrE9O4/isLnal1TJuCea7PmeBmuJVQgBWliVwtX8r5tfToytgYXeoHd0ymOZHF7bmFAPX+vB6eNzT4Q/0ahTlbEpAKhyc/K+0wXl9FUS5//eUXLBjiNVGkpM5ieCOe0dzq3Uo2JOYgS040aRbo7Jm1JwRheH98+NLLI3AJlGp9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862360; c=relaxed/simple;
	bh=aS/ZRjoiK2LzRii4KCSPVSdnQuMx4YxvC8udAKmML9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b4s4aFI1y+EeRPBpFqNuodHjbs7+8FWfbRBRx6Lmwg9+gPJ5rWWE6oqW9+3I4AoBMhE+6UTPk4MbxYM8rT8j1QO9xk/cJ3O91+Wm0qKjHRylTeQrht+nhXNUZO1h4cRrKQ6HRIdTq5jFUtQHtSy5PjWCwk2Cid6S8eUJRp0PoIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5U9TMfZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5U9TMfZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19893C116C6;
	Mon, 23 Feb 2026 15:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771862360;
	bh=aS/ZRjoiK2LzRii4KCSPVSdnQuMx4YxvC8udAKmML9g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=W5U9TMfZ8C4iTzgII0YR77aGQJuM2HtuY435Wtadkk9e54++orTtoYC2nuKyOiWVm
	 T/TzbWmn0dSA+tZjdZ3BzmbDO2ZQS0zNYUpTontpQJ3IAiN9VkGLsFTzX8vskfPYiy
	 kwh3QmK0PwqlBcU1/CVjZGrZbGs7xESbxxV0NJf+WRm8MZGOE+MWs8uN7sIJZfLboX
	 xnDjj8tYAkBODhm17NLSIIi6dW7DnNdk/JOoxhILc1S8oTNs26xL7p9c4h08qcvnWx
	 NBJ2jPVhyBWQ6WmVr2WQRJoqN4YdKn1TLvPfS35N/cvSBe5GCXRxVlrnkhrQoJnze3
	 fkUkE8/oOFB+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120CEEA4FD8;
	Mon, 23 Feb 2026 15:59:20 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Mon, 23 Feb 2026 15:59:21 +0000
Subject: [PATCH v12 6/7] i2c: xiic: use numbered adapter registration
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-xiic-v12-6-b6c9ce4e4f3c@nexthop.ai>
References: <20260223-i2c-xiic-v12-0-b6c9ce4e4f3c@nexthop.ai>
In-Reply-To: <20260223-i2c-xiic-v12-0-b6c9ce4e4f3c@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771862359; l=1439;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=eIOcBblyySq1mWQBgk0IUkRMweSQ1d65J0ODZqXKZI4=;
 b=8vXZvuulE0Ks2TJqBEbHU1I2pgJzSoKrG5A9J4ziNYQpK8nUXdD/nDJb++lwHJPY4QS14WxP6
 xrf+lRysHq4Czbe7iFhHw55RRUixYkxmiA+Q7LmrknD47zXdjw/f4KK
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

Switch from i2c_add_adapter() to i2c_add_numbered_adapter() to enable
platforms to specify fixed I2C bus numbers via the platform device ID.

This allows systems to maintain consistent bus numbering across reboots.
On platforms where the device ID is PLATFORM_DEVID_NONE (the default),
the adapter falls back to dynamic allocation, preserving backward
compatibility.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 80e183b6e4f1..6eb0c6a2618a 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1451,6 +1451,7 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	/* hook up driver to tree */
 	platform_set_drvdata(pdev, i2c);
 	i2c->adap = xiic_adapter;
+	i2c->adap.nr = pdev->id;
 	i2c_set_adapdata(&i2c->adap, i2c);
 	i2c->adap.dev.parent = &pdev->dev;
 	device_set_node(&i2c->adap.dev, fwnode);
@@ -1507,7 +1508,7 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret, "Cannot xiic_reinit\n");
 
 	/* add i2c adapter to i2c tree */
-	ret = i2c_add_adapter(&i2c->adap);
+	ret = i2c_add_numbered_adapter(&i2c->adap);
 	if (ret) {
 		xiic_deinit(i2c);
 		return ret;

-- 
2.52.0


