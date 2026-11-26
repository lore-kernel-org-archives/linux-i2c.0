Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795720284;
	b=bzpPM2Gs3fYHRm4eIkoaiWJ3cbt1rylg3oimUlFXpyX5yr+1muf6BRqB3xPUasPIle0p
	 jTpyt+jAEFohMKNm2/q6yPTaQJWK52lDR/ZNawuEeVCDK3tilNUil70uU0f9Pc0U16Fml
	 rjstrizgfF4/2NZp6hUjjFMIkJw1SNXDH7vQqd5u85B0csnr9m45VDVC/wpIfXAshg0YR
	 I/LvN0tQtihZmlJrJJVEjVC+joQgfX+TNo4O+3UelUtmu/y7N6ZS7EjpDEp/Xr9w7DQ5i
	 K9Cv3+yTmrE132YnTm498bh33bTbqG74vDC4tgPpA2eAQNIGfixhXuCLXN+TPT/+LVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795720284;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient;
	bh=JHGRDn/8bxdu8Q7MlAIdJZiertZfRgfnbgTJpxe2NsQ=;
	b=TRyoP6UQZi0QLz5Ku2yQ5mRkQtBrODq5KeGk5Yl/ZmNDYiAoc1pklOd25X8trwdsxPmK
	 qM1cav+0L7EgIJfFiIlrixKhgP9EzGtxEfwQjwdiRlmpP5CHMZSIGn5RdoXvTEXzA3Yvq
	 vkZRKp/puJFB1sNBxXxXRkE+vo0ZataDoFMhJ2mvEdU42KOGoZUyNtUTcPOa4zGxj13HX
	 sjUu230u7s2j9N3slgzdiMqda+16cMcTRw4fYp1V5BnK17N5NgdFj7wy2IEELw/jziwq1
	 cGAQyT5s2zJgtr8PDwWhAnDeLha7xr0dGiCrr8rnE3SaIiBA4Gu+N0ChNY9Cwy9r9oQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=betterinternet.ltd;
	spf=pass smtp.mailfrom=betterinternet.ltd;
	dkim=pass header.d=betterinternet.ltd header.i=@betterinternet.ltd header.a=rsa-sha256 header.s=zmail header.b=Soqjbwe5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.50
Received: from sender-of-o50.zoho.eu (sender-of-o50.zoho.eu [136.143.169.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008ED606A321;
	Thu, 26 Nov 2026 19:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 008ED606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=betterinternet.ltd
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=betterinternet.ltd
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=betterinternet.ltd header.i=@betterinternet.ltd header.a=rsa-sha256 header.s=zmail header.b=Soqjbwe5
ARC-Seal: i=1; a=rsa-sha256; t=1795720253; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=hbU+2x+rU1lRdZ5wYibYLkcuT0PXtDIpF4YaVwJs/5EV4cmb4N/lpBzgim0WGigBGKPnIaBNFJbbFJ7vP1+IvqjVqRT7Xh+cYoi7jmGnN/JWY5QlMS3ZAzYTA74L/U4P1w1rA7CRFqkmqAQDPJ+rpFbM+61z9Eez6+AZ9RSg0gk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1795720253; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JHGRDn/8bxdu8Q7MlAIdJZiertZfRgfnbgTJpxe2NsQ=; 
	b=DTrU/7zE9GCbpharNJCCYV5kqKBMc2xFJQlzDhvrwOviSW6aAkH8c85KZUJzucav2KopquJTL6yT2n205QRMcqrst1+iC5BKiomL4Wly3e4PAYknawWXmCkvmvIW/XOD70iH5zJH5ceF3qDYcufh8oRF14Izv5KQPAmQT5uOv4U=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=betterinternet.ltd;
	spf=pass  smtp.mailfrom=marcus.hughes@betterinternet.ltd;
	dmarc=pass header.from=<marcus.hughes@betterinternet.ltd>
DKIM-Signature: a=rsa-sha256; b=Soqjbwe5RBjzlUVZpaycgFx9g+77EvLd5Nk7rs01ENNvYEw6o4cUN8vm3hvgQE869Yc0kAuir9Lh7t1dMUDi3w9Y27nT9SE+hXCXZ1tHCyAIihFjODQaXHb7g8H6RL41v4V/C3loMNlfNneLS8iTn3Yrg3raqAI1BQTmG/uBuNk=; c=relaxed/relaxed; s=zmail; d=betterinternet.ltd; v=1; bh=JHGRDn/8bxdu8Q7MlAIdJZiertZfRgfnbgTJpxe2NsQ=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1795720252325146.98026767649048;
	Thu, 26 Nov 2026 20:10:52 +0100 (CET)
From: Marcus Hughes <marcus.hughes@betterinternet.ltd>
To: Till Harbaum <till@harbaum.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: tiny-usb: Add Better Internet SFPdebug
Date: Thu, 26 Nov 2026 19:10:37 +0000
Message-ID: <20261126191037.65238-1-marcus.hughes@betterinternet.ltd>
X-Mailer: git-send-email 2.53.0
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
X-ZohoMailClient: External

The Better Internet SFPdebug is a USB bench tool for SFP and SFP+
modules. One of its interfaces is an I2C adapter for the module's bus
that speaks the i2c-tiny-usb protocol.

The board has its own USB ID, 16d0:15ba, from MCS Electronics.
Besides the I2C adapter, it has a second interface that its web
manager uses from the browser. Today the driver can only be bound to
the board with new_id, which takes both interfaces, so the web manager
can't connect while the driver is loaded.

Match only the I2C interface (ff/01/01). The driver then binds by
itself, with no new_id step, so the board's I2C bus is ready as soon
as it is plugged in, as the board was designed to work. The web
manager's interface stays free.

Signed-off-by: Marcus Hughes <marcus.hughes@betterinternet.ltd>
---

Notes:
    systemd's hwdb lists the same USB ID since its commit ba9122914f06
    ("hwdb: add Better Internet SFPdebug (#45063)"), which gives the
    logged-in user access to the board.
    
    Tested on Ubuntu 26.04 (Linux 7.0), with the driver built from v7.0
    plus this change and installed in place of the stock module:
    
    - Without the change, the driver binds none of the board's interfaces.
      Bound with new_id, it takes both, and Chrome can't claim the web
      manager's interface ("Unable to claim interface") until the driver is
      unloaded.
    - With the change, plugging the board in loads the driver through the
      new alias. It binds the I2C interface alone, leaving the web
      manager's interface unbound, and registers one adapter.
    - i2cdetect -r finds 0x50 and 0x51 on a fitted SFP+ module, and i2cdump
      reads its identity EEPROM. With the module unpowered, reads NAK as
      expected, and they work again once it is powered.
    - The web manager stays connected in Chrome throughout. After a replug,
      the driver binds the I2C interface again by itself.
    
    Our automated hardware tests also use this driver, bound with new_id,
    on Linux 6.18. They read and write SFP modules with i2cdetect,
    i2cdump, i2cget, i2cset and i2ctransfer, and compare every byte with
    what the board itself reads.

 drivers/i2c/busses/i2c-tiny-usb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
index 73355a56a..a4ac9f2d1 100644
--- a/drivers/i2c/busses/i2c-tiny-usb.c
+++ b/drivers/i2c/busses/i2c-tiny-usb.c
@@ -162,6 +162,9 @@ static const struct i2c_algorithm usb_algorithm = {
 static const struct usb_device_id i2c_tiny_usb_table[] = {
 	{ USB_DEVICE(0x0403, 0xc631) },   /* FTDI */
 	{ USB_DEVICE(0x1c40, 0x0534) },   /* EZPrototypes */
+	/* Better Internet SFPdebug: its I2C interface only */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x16d0, 0x15ba,
+					USB_CLASS_VENDOR_SPEC, 0x01, 0x01) },
 	{ }                               /* Terminating entry */
 };
 

base-commit: 04e9bf1648f846976b543e91c1838a712433772a
-- 
2.53.0

