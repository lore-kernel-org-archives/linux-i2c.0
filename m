Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300727;
	b=d5yTGz+/XSC5nQ9ca1wPgv55xQw1wqd6I9lPxGuiNI/sN8pySfrEPvfreyVdogCaznK6
	 Zz+6qUM/ngkxjrtLvfL+z/rinRr0XnqEYone1e/LGdYSNZ8LiqxFGrB3kCnz6CWmbxevx
	 oEIfM3F+xIWwpESB5/OOnFMnkmGwUooM7En+NvgOTsSGI3Iv9Ae5MSyx+7W5YHTQqN+xa
	 zwvHQ1EZysJrSrRvQoY8nUxF78gtjjbu4pmMfrCkimEqN5AIgAqNyDg4BtweZbopiepAB
	 LQbhG23xSnXXbcJYfH5NMVVLGMjZbyKABX17R2RamfwUl1Ym1EebFm8NSsLxFym4Yiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300727;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Lp0SW5xrHs/eDGwsq61fIfxOKUA5MYfMP207ooVp0bI=;
	b=i/4iFWMtugxjyCbbxZ6DuvHnF9suhRFXsXFNw8ChlhqG8ODFdZ4P221mL8uOYE3JV6wK
	 OsPXv9v2jrkZHRkuQfklV8enXoQ41HCNhd9ZshN+r84FRoscRHml9qbNPc35/lflvCq8V
	 UJEE8Iy4EVYgaVAYRWLYIoevI79W8oBvlIC6E7+0LPYqPOOxuujdnF4nsKyrPc1RxBgXV
	 k0Rp2NWpHmNk1FUEVd76YF270dkAumXoqATpowbuDeNAJ57f7+ePYzKiPulwRu7LKYRSm
	 lfM14n7LukB1MUvocm2o5WhyxLmWh8DEzg8pz/Ky67wmL067uqz0aSCmkWItJzvnDxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIqzksC0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E87A606A334;
	Tue, 10 Nov 2026 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIqzksC0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92ACB1F008A3;
	Tue, 10 Nov 2026 08:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794300726;
	bh=Lp0SW5xrHs/eDGwsq61fIfxOKUA5MYfMP207ooVp0bI=;
	h=From:To:Cc:Subject:Date;
	b=mIqzksC0fLiGMhbr+BfEbtyqcHcr2bxF3oeb/Z5wEu4Er4PkfqcDwYDJd5M6MRH9A
	 4DtE3bm4Bx/DP1HZbOHww/SoSwhXaQf3j3H2jnBeneUiFWaAS3SK45KFyo9p7yXk6X
	 kC1Wbokf0CU1EY9mX0VJ89jMQ7qGvOTPrBpoWeObTHKSElbTSDeOYl2Pp50V08FLls
	 D3NkP7njO4t8TgbA2KlyVCtft5sm4656L7I3bTQk9hfU+//19vgu647j9lLF6qcqmj
	 wxY2ELrH1J9zPRahv9su2xfuNOTsuDDF4/yxT3UM5s7jEexZLGhYJbVHeX244FM6S8
	 FET31TcK33u4g==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xQhaF-0000000Adc4-49hu;
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] driver core: platform: fix swnode use-after-free on device release
Date: Tue, 10 Nov 2026 09:51:16 +0100
Message-ID: <20261110085125.2535508-1-johan@kernel.org>
X-Mailer: git-send-email 2.56.0
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

When fixing a use-after-free regression in 7.3, I noticed that the
software node implementation is internally inconsistent.

Specifically, the firmware node pointer of a struct device may point to
either a primary or secondary firmware node, but in several places
kernel-doc and comments suggests that the firmware node pointer always
points to a primary node (cf. [1][2]).

This series fixes the 7.3 regression along with a similar issue in i2c
core due which are both stem from the fact that
device_remove_software_node() happens to drop a reference to a primary
software node that was never added by device_add_software_node().

The next two patches clarify that device_remove_software_node() should
only be used to remove nodes added by device_add_software_node() and
stops touching primary nodes.

The rest of the series addresses further inconsistencies.

The first two fixes could go into 7.4 and the rest (which depends on the
fixes) into 7.5. And with an ack from the i2c maintainer for patches 2/8
and 4/8.

Johan


[1] 97badf873ab6 ("device property: Make it possible to use secondary firmware nodes")
[2] 3f7bddaf5d5a ("device property: add description of fwnode cases")


Changes in v2
 - rename temporary variable and amend comment as dev->fwnode is not
   always a primary node (patch 1/8)
 - fix related UAF in i2c core (patch 2/8, new)
 - fix inconsistencies in interfaces, kernel-doc, and comments (patches
   3-8, new).


Johan Hovold (8):
  driver core: platform: fix swnode use-after-free on device release
  i2c: core: fix swnode use-after-free on client deregistration
  swnode: fix device_add_of_node() kernel doc
  swnode: ignore primary nodes in device_remove_software_node()
  driver core: platform: warn on bad fwnode assignment
  driver core: platform: tests: fix swnode reuse test description
  swnode: fix software_node_notify() primary node comment
  device property: fix fwnode_get_next_child_node() comments

 drivers/base/core.c                      |  3 ++-
 drivers/base/platform.c                  | 32 +++++++++++-------------
 drivers/base/property.c                  |  6 ++---
 drivers/base/swnode.c                    | 20 ++++++++-------
 drivers/base/test/platform-device-test.c |  5 ++--
 drivers/i2c/i2c-core-base.c              | 10 +++-----
 include/linux/device.h                   |  1 +
 7 files changed, 39 insertions(+), 38 deletions(-)

-- 
2.56.0

