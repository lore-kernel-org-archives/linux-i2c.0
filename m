Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E947139E6C7;
	Thu,  5 Mar 2026 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715174; cv=none; b=XC9kNBYyNW4rt5lQoDmyQYMak0Db6KJn8bUeelAgnksAlYNtZPW9h5aEvHdvtx1wB+SlY1/RjIXXVn9zSr3gd/sYAdTiZ52ItMnR75G15ACesjhTaeFHML1myynnhcsVEUky43kXlrDamLQNpGd2EX1yZsNKnP8eSBo2hSrtmss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715174; c=relaxed/simple;
	bh=xOL/rAl/uCuHho2CDxpnI0gMXRxrKE0bb+kNoRGcHbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WCI/nSCnSFzUJ5HEXrfXgOegieX6mSQmWcQGE8OFzpbuup0ArdKYe24ZwjYNTS2hWQCZJvsDOmoijBetP6ObBoGdVJyIQX4gOtl5N63PKXTG+bJMV59UIIWt3clQ3EgyTTfEAvKdsSinZq8kJbR/bml8s8HnRBkZcxZXIoGVWjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBddT9JI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBddT9JI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E78C116C6;
	Thu,  5 Mar 2026 12:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772715173;
	bh=xOL/rAl/uCuHho2CDxpnI0gMXRxrKE0bb+kNoRGcHbs=;
	h=From:To:Cc:Subject:Date:From;
	b=DBddT9JI1a8bz62qKvq1unutdOr8m8nTaTX8LFSJBBo2xYaZ7oOiesL/TFfBqBPdF
	 P556pqxLehtfemFn1S8PaGiOUbuXBXSG4n3sZzCuMo4i7FfFGEgxoDONlvfTlITKfp
	 Y0lMOR55/i5D2VNXcQP2W2D5CqzQpZiMvq2eBkT0on0nWeswS8s//SaaSn3Uud5hcq
	 nTWNQx5WzMvJGwahDsOVTGTdSwLIFNCFn6sI1keNZ1gt/SowiDA6PD+oU1ryCbGTE1
	 bc9iKdtymr78blc7nBTc71JTIbBONgxsvoUQNGOWvFjuAbr+mW+g0Bzfy7SLNKudB0
	 /SHSY6gt4yFRg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vy8CB-000000002sC-027j;
	Thu, 05 Mar 2026 13:52:51 +0100
From: Johan Hovold <johan@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] i2c: diolan-u2c: drop redundant device reference
Date: Thu,  5 Mar 2026 13:52:21 +0100
Message-ID: <20260305125221.11009-1-johan@kernel.org>
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
 drivers/i2c/busses/i2c-diolan-u2c.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-diolan-u2c.c b/drivers/i2c/busses/i2c-diolan-u2c.c
index 077b093ba834..d502f6e4732f 100644
--- a/drivers/i2c/busses/i2c-diolan-u2c.c
+++ b/drivers/i2c/busses/i2c-diolan-u2c.c
@@ -427,12 +427,6 @@ static const struct usb_device_id diolan_u2c_table[] = {
 
 MODULE_DEVICE_TABLE(usb, diolan_u2c_table);
 
-static void diolan_u2c_free(struct i2c_diolan_u2c *dev)
-{
-	usb_put_dev(dev->usb_dev);
-	kfree(dev);
-}
-
 static int diolan_u2c_probe(struct usb_interface *interface,
 			    const struct usb_device_id *id)
 {
@@ -453,7 +447,7 @@ static int diolan_u2c_probe(struct usb_interface *interface,
 	dev->ep_out = hostif->endpoint[0].desc.bEndpointAddress;
 	dev->ep_in = hostif->endpoint[1].desc.bEndpointAddress;
 
-	dev->usb_dev = usb_get_dev(interface_to_usbdev(interface));
+	dev->usb_dev = interface_to_usbdev(interface);
 	dev->interface = interface;
 
 	/* save our data pointer in this interface device */
@@ -488,7 +482,7 @@ static int diolan_u2c_probe(struct usb_interface *interface,
 
 error_free:
 	usb_set_intfdata(interface, NULL);
-	diolan_u2c_free(dev);
+	kfree(dev);
 error:
 	return ret;
 }
@@ -499,7 +493,7 @@ static void diolan_u2c_disconnect(struct usb_interface *interface)
 
 	i2c_del_adapter(&dev->adapter);
 	usb_set_intfdata(interface, NULL);
-	diolan_u2c_free(dev);
+	kfree(dev);
 
 	dev_dbg(&interface->dev, "disconnected\n");
 }
-- 
2.52.0

