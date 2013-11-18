From: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v4 2/3] i2c: xilinx: Do not enable irq before irq handler
Date: Mon, 18 Nov 2013 13:13:08 +0100
Message-ID: <bd1e63067664dc83400fa9749da21a2bbd09639c.1384776761.git.michal.simek@xilinx.com>
References: <04a1a7e01e2f3ff132658b7246ef32e74c73aa29.1384776761.git.michal.simek@xilinx.com>
Content-Type: multipart/signed;
    boundary="=_mimegpg-monstr-desktop-25641-1384776801-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <04a1a7e01e2f3ff132658b7246ef32e74c73aa29.1384776761.git.michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
In-Reply-To: <04a1a7e01e2f3ff132658b7246ef32e74c73aa29.1384776761.git.michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
References: <04a1a7e01e2f3ff132658b7246ef32e74c73aa29.1384776761.git.michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Kedareswara rao Appana <appanad-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.
The Internet standard for MIME PGP messages, RFC 2015, was published in 1996.
To open this message correctly you will need to install E-mail or Usenet
software that supports modern Internet standards.

--=_mimegpg-monstr-desktop-25641-1384776801-0001

IRQ handler has to be register first before IRQ
is enabled in xiic_reinit().

Signed-off-by: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>

---
Changes in v4: None
Changes in v3:
- New patch in this patchset based on my discussion with Wolfram
  https://lkml.org/lkml/2013/10/4/148

Changes in v2: None

 drivers/i2c/busses/i2c-xiic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 4d5c79e..1ded456b 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -730,8 +730,6 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	i2c->adap.dev.parent = &pdev->dev;
 	i2c->adap.dev.of_node = pdev->dev.of_node;

-	xiic_reinit(i2c);
-
 	spin_lock_init(&i2c->lock);
 	init_waitqueue_head(&i2c->wait);
 	ret = request_irq(irq, xiic_isr, 0, pdev->name, i2c);
@@ -740,6 +738,8 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 		goto request_irq_failed;
 	}

+	xiic_reinit(i2c);
+
 	/* add i2c adapter to i2c tree */
 	ret = i2c_add_adapter(&i2c->adap);
 	if (ret) {
--
1.8.2.3


--=_mimegpg-monstr-desktop-25641-1384776801-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlKKBGEACgkQykllyylKDCG7mACfXy+h8z1oa2+L8E2qRpCW7Xmd
O44AoJLRiQ2J8ke1wapIM0yOmEh+KErE
=gyW0
-----END PGP SIGNATURE-----

--=_mimegpg-monstr-desktop-25641-1384776801-0001--
