Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910435;
	b=TMIj6dwFVrpDf+9XrUHs9l94pmLdwU1NUv55NKCS9WsBE48vbwV8vebe6180wnM0Sl64
	 hyntXXW2CtWflPecUxdvhPFYSAd9+TUU9+R/MJUIsV4bQdBOaYTxAFbOBTzdsOs1jR3H2
	 jMK9lz22fvsMuCfrayRE801ImjS5rJ2bXYcEwuRHZ93VcZVuFr6x2VBl7LbC9CIN+MAt/
	 BBV07N3dgp8+CMD/W5TOayDgcYPyCvAuNAHvszKw6ZwrRowP2N9iq0/E7gYw37M7MjMvH
	 gCNKmiwRLRNNk9o5LcMuOBOHayueu5HLvTQ7YzfL6IAOpriuwsqO46rsnF/Lvx2jUCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910435;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Fo0XF0newenNrHkiKKm/rDRfqSG0WG+QfFfm36qHM84=;
	b=HHCAhbtCv9/lwuQbgU/1BJyNnAI9VrVb2mUPECYijCqyT0yMfNGGlB7E0hBjYgx3FXel
	 wy05h77EDB/R9C/0fM9JcCz33Wh54zBGfkogi/J2MItGs8RunPcQriOX0NCfu6FW273qM
	 NOAKwp/1wdB/p4nJDsgCtpkcTOevWaVNXPILuYSH8L9cIhW8aZFKDb74kuSUnDuHbeB+E
	 YcMaoss8Xy9hVJJWgSFeV30RVbxFJtMW+pxDIz6KaG9VIsfninzbXeCMzjuC5ODMIeEGD
	 WJ+9QlZbjGmjyAc/LmqXL9oYOBcFC4bX2t91lWnLOlLk+92lzQ/RSU81UYEF4OTwfGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g1u7TCEy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366EC606A32A;
	Tue, 17 Nov 2026 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g1u7TCEy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D412E1F000C5;
	Tue, 17 Nov 2026 10:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794910434;
	bh=Fo0XF0newenNrHkiKKm/rDRfqSG0WG+QfFfm36qHM84=;
	h=From:To:Cc:Subject:Date;
	b=g1u7TCEy8PSoXcdVa84JPniQD0DeNAZH04ePddkWlzckb06yxcUSwx0Qm8v3q/R4R
	 tpe6Fo6m0ocpVh2Z94hYpROq1AwfEDeOrgG/nYEVf0Rm0AydI7iGHompnAIsn2KTnP
	 1RL2yMccChW4HrEJkG3yjxmHt2PpXNzmxt9W7zGg+4uabU+JtEMHK+yLscFw7TiNr6
	 lOKnKg9q/c7reyx28cQJfG+tHsnAMcIEjMwBbC6SQ/T1ByoPq13vwd33Usbt6UEZg0
	 dXa4WQfQM10+yoGPS4N0+hNwy2DCEK17ghOMO9/LZl8flSiFH8cZcDdSPW/BskPRzc
	 Gcsp8GGYUhzaA==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xTGCG-0000000470V-0se6;
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/8] driver core: platform: fix swnode use-after-free on device release
Date: Tue, 17 Nov 2026 11:13:28 +0100
Message-ID: <20261117101336.980216-1-johan@kernel.org>
X-Mailer: git-send-email 2.56.1
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
fixes) into 7.5. And preferably with an ack from the i2c maintainer for
patches 2/8 and 4/8.

Johan


[1] 97badf873ab6 ("device property: Make it possible to use secondary firmware nodes")
[2] 3f7bddaf5d5a ("device property: add description of fwnode cases")


Changes in v3
 - drop stray "the" in commit message (1/8)
 - refer to device_add_software_node() in summary (3/8)
 - use "software node:" as patch summary prefix (3,4,7/8)
 - don't export fwnode_is_primary() (4/8)
 - only warn when assigning a firmware node to a device which already has a
   software node or secondary firmware node assigned (5/8)
 - fix "at" typo in commit message (8/8)
 - drop one comment instead of updating, and rephrase the other (8/8)

Changes in v2
 - rename temporary variable and amend comment as dev->fwnode is not
   always a primary node (patch 1/8)
 - fix related UAF in i2c core (patch 2/8, new)
 - fix inconsistencies in interfaces, kernel-doc, and comments (patches
   3-8, new).


Johan Hovold (8):
  driver core: platform: fix swnode use-after-free on device release
  i2c: core: fix swnode use-after-free on client deregistration
  software node: fix device_add_software_node() kernel doc
  software node: ignore primary nodes in device_remove_software_node()
  driver core: platform: warn on bad fwnode assignment
  driver core: platform: tests: fix swnode reuse test description
  software node: fix software_node_notify() primary node comment
  device property: fix fwnode_get_next_child_node() comments

 drivers/base/base.h                      |  2 +
 drivers/base/core.c                      |  2 +-
 drivers/base/platform.c                  | 48 ++++++++++++++----------
 drivers/base/property.c                  |  5 +--
 drivers/base/swnode.c                    | 20 +++++-----
 drivers/base/test/platform-device-test.c |  5 ++-
 drivers/i2c/i2c-core-base.c              | 10 ++---
 7 files changed, 51 insertions(+), 41 deletions(-)

-- 
2.56.1

