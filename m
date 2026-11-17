Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910435;
	b=xtfzgVP40+9+uhxaa3G96ayr7Hdl5fLZ+0qw8ofImQw7EXS/ec2/SB1YhObSpNdsN7Ys
	 efrXQSK78FjDggVO87xoA8/FsbJeSD0qyuPKuKmDqj9CY1v7Cz/fJXKDBM96vujyX4v8g
	 CEKem4WQxbElJZTjoD7CQ1fAOuzoRmBNKE/XV68GOI283rV8zMv0s5n7WXeNbnl4MlxGi
	 dvcWmENVGrQpaxyn3CXW5VwfS/RpX8XyM0xPfCjyUJ7eXcrotGto7PYT5G0lYDbI1AEwN
	 bUdLxUTEE6nI+9gK0+Rxrl3I7qQS6DmqbAmBBu5tLwl0lkDeeT48ZSbZdstHJw9xEtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910435;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+AvY6l4TVQAIrt+wlRFj1JYgfNH3aPt0auvD3+miYgA=;
	b=qYe85ZZXvDaqfJIUtgHTl7bgROlg8ckckp9DuGkHiIjJ4WyeAC3Wws7GbwEXlTe219xZ
	 fj9L4MZHwdpkIXEoBPkjcN+xZ0Vc7/wXwDzw93MuNSRyWY3LuN0oAgVQQ8r0/nd9mLOnv
	 E2nt5RQViSSGq2QNvjzozAjY0zZ3m/csz6NTVKFk7w4uo20w0RGoibcvwRDjJ4802iaVW
	 xn7StHtnxdrZNiOxqNTUJT9vVLKRwLUarGYNymB3otv70XtZ2mGsfRUtNRJw4h4g0DSrh
	 b9UuK7Z0skRwkGW26KwJVzYDdBQJjaoi6wMuL3kZ2Xw4HpgwJAfczJlGunBu0/oKQ2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aVaAus7a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5925A606A334;
	Tue, 17 Nov 2026 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aVaAus7a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4421F000CE;
	Tue, 17 Nov 2026 10:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794910435;
	bh=+AvY6l4TVQAIrt+wlRFj1JYgfNH3aPt0auvD3+miYgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aVaAus7akpb6X9I7BAoNUth/Ftw2HAz+8LdFx8GEUwH97KEnrGSfNo7Kv6e8RBf1m
	 auYkKOXllxswJ2V8VtQWn/W1hdGYwQLYkY4pqXFCbuDgw3wzl/4Hcas3maetKvvz5B
	 cmauZgABI8mYJKnBeZbqaMzH9dN24utdf6+DEVQMKlwdAmJmsghvobUwUyNRlApR7q
	 8XVG2gY+ZHyvXgq6te4YcOl+qKyT/KreszVOpps0XXahK+I21mEZKuCQy5JN1EIbK8
	 li+G3S5haflOBVl5rHf4aIB9hnIKE6Bf/VG3GoSYJVCWE5QSEfFRurtIxEc0ydNAx9
	 dDHlcVvKQi5Rw==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xTGCG-0000000470h-1EdT;
	Tue, 17 Nov 2026 11:13:52 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v3 6/8] driver core: platform: tests: fix swnode reuse test description
Date: Tue, 17 Nov 2026 11:13:34 +0100
Message-ID: <20261117101336.980216-7-johan@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117101336.980216-1-johan@kernel.org>
References: <20261117101336.980216-1-johan@kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The description of the software node reuse test is misleading as a
software node being registered does not prevent it from being reused
(e.g. as software nodes can be shared).

Fix the description by clarifying that the test would fail if the
secondary software node is not removed from the device so that the
reused primary firmware node still points to the software node.

Fixes: 397f0a3958c9 ("driver core: platform: tests: add test cases for correct swnode removal")
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/base/test/platform-device-test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/test/platform-device-test.c b/drivers/base/test/platform-device-test.c
index 9ce563f76aad..b0cc37d166ff 100644
--- a/drivers/base/test/platform-device-test.c
+++ b/drivers/base/test/platform-device-test.c
@@ -273,9 +273,10 @@ static const struct software_node platform_device_test_swnode = { };
 /*
  * Check that reusing a software node works correctly. If the call to
  * platform_device_register_full() fails after adding the secondary firmware
- * node, the software node must be unregistered in the device's release()
+ * node, the software node must be removed in the device's release()
  * callback or the subsequent call to platform_device_register_full() will fail
- * with -EBUSY due to the software node already having been registered.
+ * with -EBUSY due to the primary firmware node still pointing at the
+ * secondary software node.
  */
 static void platform_device_swnode_add_twice(struct kunit *test)
 {
-- 
2.56.1

