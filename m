Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81727366075;
	Thu,  5 Mar 2026 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715251; cv=none; b=lFSOW+9NDmL/LghHQKADY0D+h5+x2BIlSlH/kslCJPrFi7T4gzI8y8VFRwgYR5C1/yDeFA5hNvUr5OhxpUkwZWiZuQJfeDKr27SIRnna9F6wwkOgk1WNWoYWG49Ud5AAhAWUJS/B7/Sm4BtP8sbqiuyUzySfU9OsQi/1D9wkoBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715251; c=relaxed/simple;
	bh=txrPg4XsAYJXs/oAEYHqH+/gYk2I2YfZy/PgGm7UwUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Avoa/8W6a7Rgewp7raOP1iuxg7IK7tccsWHM6E49cRzjxgeIByh1HTRBBfmaPxm/EpcQHzN63559z5Qej6/KsmA8bMqT1T9pXE1yFESzb5qjmrVY9NK3QDIUQ7NhD2qZyo12Iowwwq4SxPLFflHpP5RKonj7dGgzwgH2d6IC42c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZQk+tna; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZQk+tna"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF21C116C6;
	Thu,  5 Mar 2026 12:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772715251;
	bh=txrPg4XsAYJXs/oAEYHqH+/gYk2I2YfZy/PgGm7UwUQ=;
	h=From:To:Cc:Subject:Date:From;
	b=bZQk+tnazYPgwvl3hZoTVLrTscLQph1jLtzdhR5rkziUd18LUZj2NnaRQirjnnQ/V
	 ML9ygP/yRvTZsr6CSiDGck1tes9jkk5GlS5RBW1jtscVjmGVTT+x5faU/vhRpvlxiP
	 HvmUn1oFpQZTAt8JrzsUmhiz8Ik+QD9/De0tX9mXaZUnwfcR6cruw4o4Aocxt84adD
	 oBb0NvxfVpel11NBIUUntfRhoFXoFARIOWSjxr4aisqnISJrlK9eleOS8xoThEpKi+
	 F3L9XakOfnVud2ZSXyUs0ZR8bsVRjCQELZVEQ3+qR/+WbyuZGmPcIZlDpQlIdr9zHC
	 FSfeIYpfBDvsg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vy8DQ-000000002ty-3bMo;
	Thu, 05 Mar 2026 13:54:08 +0100
From: Johan Hovold <johan@kernel.org>
To: Till Harbaum <till@harbaum.org>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] i2c: tiny-usb: drop redundant device reference
Date: Thu,  5 Mar 2026 13:54:03 +0100
Message-ID: <20260305125403.11132-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver core holds a reference to the USB interface and its parent USB
device while the interface is bound to a driver and there is no need to
take additional references unless the structures are needed after
disconnect.

Drop the redundant device reference to reduce cargo culting, make it
easier to spot drivers where an extra reference is needed, and reduce
the risk of memory leaks when drivers fail to release it.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/i2c/busses/i2c-tiny-usb.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
index 9ef495f88ef2..88d66593d9fc 100644
--- a/drivers/i2c/busses/i2c-tiny-usb.c
+++ b/drivers/i2c/busses/i2c-tiny-usb.c
@@ -213,12 +213,6 @@ static int usb_write(struct i2c_adapter *adapter, int cmd,
 	return ret;
 }
 
-static void i2c_tiny_usb_free(struct i2c_tiny_usb *dev)
-{
-	usb_put_dev(dev->usb_dev);
-	kfree(dev);
-}
-
 static int i2c_tiny_usb_probe(struct usb_interface *interface,
 			      const struct usb_device_id *id)
 {
@@ -237,7 +231,7 @@ static int i2c_tiny_usb_probe(struct usb_interface *interface,
 	if (!dev)
 		goto error;
 
-	dev->usb_dev = usb_get_dev(interface_to_usbdev(interface));
+	dev->usb_dev = interface_to_usbdev(interface);
 	dev->interface = interface;
 
 	/* save our data pointer in this interface device */
@@ -277,8 +271,7 @@ static int i2c_tiny_usb_probe(struct usb_interface *interface,
 	return 0;
 
  error:
-	if (dev)
-		i2c_tiny_usb_free(dev);
+	kfree(dev);
 
 	return retval;
 }
@@ -289,7 +282,7 @@ static void i2c_tiny_usb_disconnect(struct usb_interface *interface)
 
 	i2c_del_adapter(&dev->adapter);
 	usb_set_intfdata(interface, NULL);
-	i2c_tiny_usb_free(dev);
+	kfree(dev);
 
 	dev_dbg(&interface->dev, "disconnected\n");
 }
-- 
2.52.0

