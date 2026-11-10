Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300727;
	b=2yItPcXNeakSG1nHKksU33dEbnerd96Xfx9rAgisUokLcD0cMJMyFgxoD8p61/Fqu4M0
	 826lprXlD7XCGy+CCzLlC98i95442PNr9uJDXr2Tl9j7XsNsThoPbLowFrOq3m01+dNgj
	 JHKpKb8RK6PQQigSHtBmA+QJaSoheZygKk1LgDhys1Bmipg/Fy7xGub+FQ305p6InruW4
	 7NdkcsITTENBIjaUvv3cPfG/weOsfd9q1AL8zX7y+vOJznoMmQPvuWdnBVEIwKfxE6xTm
	 /jefISxoqH/5S2v4dUSS3hVkHoQ9zF1gqwybRCRomxpdQ6OLextj3NAQ9JVfz+sQBtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300727;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9t/1gR8KavWYeBWqAJEIDuTt1eoBfUo24N/S3F7N+WY=;
	b=dXUHwHw94Y+Z3/D8TpP8Gok1Wrjo+MO5kv8uk2YaVmgQgdt71fGGlYMX9n0sE++yOpZ8
	 aNo1+/MxC99nliOB+syHu1xrnkbN9Yo/ykLTtFzaRgYqnIciAWzqEFbHdGJT0hhXhrNZM
	 3bbeJ0K6XrYv0+Xo8SBqjplO37+JXByqqqKWZOUT6dALwiQx/z0E8HM8dUr6KRQie4TfL
	 LDbuW1TmIL/deblM3aJjINS9QOwowoFS2lr8BXcXvAxsbtw2Ct7f32894ZE+HkYoi4E77
	 zBcf/xiZhzd7giJ/m2aXywBz4AZUdZYLipS8HagrZjwuRxeSgzz1vFTyvAaN5XK0yjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BHhFmKkQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E76F606A331;
	Tue, 10 Nov 2026 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BHhFmKkQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996921F008A5;
	Tue, 10 Nov 2026 08:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794300726;
	bh=9t/1gR8KavWYeBWqAJEIDuTt1eoBfUo24N/S3F7N+WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BHhFmKkQPZ5XOH29Z74GRI5SzGLDvQ/rqidJtt21tT4ZkPPi3iCI73CKy5yB8UFLz
	 XlcU7ZVOd9G5wKC2VPSnjGMj6LgzmmyUJByqC9Lb5jz16r0B6W6o9GCF1oDlBC+H/D
	 GfJzcaca4jR8elAjcc8TZMkrZJU0vlayORL8+lKLbki+tLGR2AQwigegTm0QNr8DLr
	 Nq8MEcfMgTjvHnFpqwUPDFICNtr3l7/3bqLHEreBQYqxKXB4xSek8ZMOmMt3IcN30N
	 8w8KWA+PJPli2+7i/WEKDEJ7StVSXZavnnEb7foNEIzuXZ7Ubh17dpbleG04o0Bct5
	 H0Hoy+20RScUg==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xQhaG-0000000AdcG-0KTT;
	Tue, 10 Nov 2026 09:52:04 +0100
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
	driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2 6/8] driver core: platform: tests: fix swnode reuse test description
Date: Tue, 10 Nov 2026 09:51:22 +0100
Message-ID: <20261110085125.2535508-7-johan@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110085125.2535508-1-johan@kernel.org>
References: <20261110085125.2535508-1-johan@kernel.org>
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
2.56.0

