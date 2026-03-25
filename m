Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1581359A8C;
	Wed, 25 Mar 2026 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774432196; cv=none; b=neEBSz19YH1EGMFFd3H3+zU1RXpFd10BHfVTiUlTiM1NXesPwu3p0oRrildV5q68nUcffW5ZkgMjErxPzs0MJZMzloX4YDAwboilmGI496Hd1d1YoTHVnoOM656iuqkR1mJ8o+6lAwkgisUamVAtn6YTrPcEyszXyJMEOdJOjc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774432196; c=relaxed/simple;
	bh=1ZsXwm+Op5iFipFI8/QQfKgdrFhLhFWt7blrSXCfKs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KEYfyhjiEIrJ1eXN0Sz9rga8TZmojpyItURMkbRHnOQr5tlyPGPwQDP0rLHwa7zolHd+sCidcaXlvJd0aoW4x9pagSMVWXh7XvnGb3D2NKStW8B+XNie2v7EkaYfuHhR+Zx01yCeQ83Z725bcvjlhHmlt1CD2CGXkju2evyO8SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LI04H5B4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LI04H5B4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AEFC4AF09;
	Wed, 25 Mar 2026 09:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774432196;
	bh=1ZsXwm+Op5iFipFI8/QQfKgdrFhLhFWt7blrSXCfKs4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LI04H5B4OLjbNI316d113ouXDXc4p2JSeJdUpHnJARvHVgKvVfpzNRzmOUn8yyLNx
	 5LxheBkEl6oOY3bWjhNsstoqbQF745C1PMVfzPLZZwYSDrG5Kw239QZugEVZZZex91
	 kiOfB3l0PZC9pcUl15fAmPTddF0sC3b8gBlmyQGZwh2NQmx8JcJn8eRS+bbQJtlsIr
	 I2FpW25YpLW7KoMYmw4KoPBQfWxRYnbjwbJO5fxb8PSYmTgBSfHJFlg2cL1m4paMPu
	 1KV+RpilqnB5B17iItL9sD5wZZR29myq1eeeRygpdR/461cnPauNW+JiCKBCEBZoXM
	 XdRVwveyxufTA==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 25 Mar 2026 09:49:24 +0000
Subject: [PATCH 1/2] dt-bindings: i2c: spacemit: k3: Add compatible
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-02-k3-i2c-v1-1-78f29c83d9ac@kernel.org>
References: <20260325-02-k3-i2c-v1-0-78f29c83d9ac@kernel.org>
In-Reply-To: <20260325-02-k3-i2c-v1-0-78f29c83d9ac@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=893; i=dlan@kernel.org;
 h=from:subject:message-id; bh=1ZsXwm+Op5iFipFI8/QQfKgdrFhLhFWt7blrSXCfKs4=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBpw6+3rCUaqYSbMo4VAbPQ2ITNvl+9aS3yUMo0C
 cW5wHMbDheJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCacOvtxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3iZhAAjOZ38CoS0qv87NSSvhiXhL0hrSdfaJnUOhoQaCE0wb5aashLbu0Qz
 0+lGlqMs6+h0JftTW897UReeE9WzVZZJtvq3SqUTDTTyzWEcwDagwI52yKkEsxx38PfUK/1G9Jt
 LS1CXsX81AohVOyr4VU+qqvlhxK853akkpQL/fepK5jg6fuGpHqKf75n5vxaO/RiHRehF8hN7yJ
 maHI0pjWNcuxWGXs8gXjSCeuDf4lHz9r80pcV0X2VEAvcO1hKvnTYkM9oLWYngHTE3rFKPQSQz+
 fHLzL4qOuPoeisYXEh6Ok7dTzwM0j5EyM1llFt23ipu1uYI+GV/k14geBTUM6v/HL+unwxgX6Dg
 M4WxgkWcuZ09VDSXwgHx15OdDgv0hgerU5ftvWyaE5FY+Z+vYCXnYJZVI0h95Phzr6/4E99JCZW
 0sTauJFzrxjqy/JtKD1aIHMPtvDck2okCPy98Gsrnyx59FKYwR6GVn1UNG1uRQx4bG4cu2CBI+0
 M1xYei0Wl6MhVOoFzKzVVD8aWAoJhF6X9Czy1/HaHxgsMjKh1RXkldmOkJkBSAX+mYh3nEW0dui
 OEkFD3EkLk4MAkc2YLqdvvcqlvtodXt+THo7dcq5/wjWsJJgq2JdrVc4p/Xc0WvaWDuPaxq/lCe
 IMW0AeR6ENZ12CivWBT0BM2g3p96ik=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Add a compatible string for the I2C controller found in SpacemiT K3 SoC
which use same I2C IP as K1, so make it fallback to K1 compatible.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml b/Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml
index 5896fb120501..8c04c675b25e 100644
--- a/Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml
@@ -14,7 +14,11 @@ allOf:
 
 properties:
   compatible:
-    const: spacemit,k1-i2c
+    oneOf:
+      - items:
+          - const: spacemit,k3-i2c
+          - const: spacemit,k1-i2c
+      - const: spacemit,k1-i2c
 
   reg:
     maxItems: 1

-- 
2.53.0

