Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A7637FF5B;
	Thu,  5 Mar 2026 10:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772706612; cv=none; b=CArRWgqg3QWa4trXNdXioIF+rp0FGHc84CnR+slKlVFTKa65xGoLV8Rjw6RvOaHPKYLHFOwmIAEkCElspiDHWavZH3smbz4BLVBiNBNXBxyD/bkQUML+42O6BIJZIjNUhoUNLcxpumr2aYA7/CtelkqbpJRqNOAMP1XwW1OYzCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772706612; c=relaxed/simple;
	bh=BFNKN9v4k5Rw3ARFvmyP6/Rc0ntOa6ng6yphjuGdAbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tZdEf/WB3rz+SXWm+IPs0MXYYu/513XwFiW7Z6lTUvT8EI+Q3lVTh5XKcodrTRyGSrArPg/wodkVgkXNEDNU0eA2SYJMK/n63A5xzNGC9nyXEPpUBZypBpc5GJVQ/9mSRlsD1hmKKV91RXqUwASVRT974Pq+3XMrAtu8toQoJqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBRHAyNv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBRHAyNv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B664C116C6;
	Thu,  5 Mar 2026 10:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772706612;
	bh=BFNKN9v4k5Rw3ARFvmyP6/Rc0ntOa6ng6yphjuGdAbE=;
	h=From:To:Cc:Subject:Date:From;
	b=GBRHAyNvf6cdD30kttKL/rPCJAWK3QgyK5if+K01yFO+EdPdPxBl0KwqtZM3gSWF6
	 udJoWLgOe1VhsxI1r8wUZp3nJSB6ZxX9O9opXJKgBqJIS59y4O+squd7qdVHmuglQo
	 l5wr/nlxtVNEu5A1lq5mRyT6Vt/tmX9ooOTaVjlrGBi6CC2Yzi1AqvwhgJ2cCKrkxu
	 bEuTt/V5013jaT8v8r6jRFGFks3XUWH0rhgW4f0RoTZYkVkZdfh1hwh3eJGgw5W+dE
	 vSzUYAFSFvN5CeebgsMPHPtRlU1ObdheRt9sPenyumCpFqy+DHiJaIUQ+eZKofgY70
	 /4EIb+4Qp0jJQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vy5y5-000000003DR-42Pj;
	Thu, 05 Mar 2026 11:30:09 +0100
From: Johan Hovold <johan@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] i2c: robotfuzz-osif: drop redundant device reference
Date: Thu,  5 Mar 2026 11:29:55 +0100
Message-ID: <20260305102955.12340-1-johan@kernel.org>
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
 drivers/i2c/busses/i2c-robotfuzz-osif.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-robotfuzz-osif.c b/drivers/i2c/busses/i2c-robotfuzz-osif.c
index e0a76fb5bc31..412fa8e37f69 100644
--- a/drivers/i2c/busses/i2c-robotfuzz-osif.c
+++ b/drivers/i2c/busses/i2c-robotfuzz-osif.c
@@ -141,7 +141,7 @@ static int osif_probe(struct usb_interface *interface,
 	if (!priv)
 		return -ENOMEM;
 
-	priv->usb_dev = usb_get_dev(interface_to_usbdev(interface));
+	priv->usb_dev = interface_to_usbdev(interface);
 	priv->interface = interface;
 
 	usb_set_intfdata(interface, priv);
@@ -163,7 +163,6 @@ static int osif_probe(struct usb_interface *interface,
 			    NULL, 0);
 	if (ret) {
 		dev_err(&interface->dev, "failure sending bit rate");
-		usb_put_dev(priv->usb_dev);
 		return ret;
 	}
 
@@ -184,7 +183,6 @@ static void osif_disconnect(struct usb_interface *interface)
 
 	i2c_del_adapter(&(priv->adapter));
 	usb_set_intfdata(interface, NULL);
-	usb_put_dev(priv->usb_dev);
 }
 
 static struct usb_driver osif_driver = {
-- 
2.52.0

