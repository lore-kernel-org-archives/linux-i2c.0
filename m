From: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 2/3] i2c: xilinx: Do not enable irq before irq handler
Date: Thu, 10 Oct 2013 12:39:37 +0200
Message-ID: <f683c0ac09887de60f72f7a936797385a6fa0c46.1381401561.git.michal.simek@xilinx.com>
References: <f3fd6f38d2553e59b077edff1969f4d07f8aa811.1381401561.git.michal.simek@xilinx.com>
Content-Type: multipart/signed;
    boundary="=_mimegpg-monstr-desktop-11222-1381401580-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f3fd6f38d2553e59b077edff1969f4d07f8aa811.1381401561.git.michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
In-Reply-To: <f3fd6f38d2553e59b077edff1969f4d07f8aa811.1381401561.git.michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
References: <f3fd6f38d2553e59b077edff1969f4d07f8aa811.1381401561.git.michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Kedareswara rao Appana <appanad-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.
The Internet standard for MIME PGP messages, RFC 2015, was published in 1996.
To open this message correctly you will need to install E-mail or Usenet
software that supports modern Internet standards.

--=_mimegpg-monstr-desktop-11222-1381401580-0001

IRQ handler has to be register first before IRQ
is enabled in xiic_reinit().

Signed-off-by: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>

---
Changes in v3:
- New patch in this patchset based on my discussion with Wolfram
  https://lkml.org/lkml/2013/10/4/148

Changes in v2: None

 drivers/i2c/busses/i2c-xiic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 5eb0a8b..183fea4 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -727,8 +727,6 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	i2c->adap.dev.parent = &pdev->dev;
 	i2c->adap.dev.of_node = pdev->dev.of_node;

-	xiic_reinit(i2c);
-
 	spin_lock_init(&i2c->lock);
 	init_waitqueue_head(&i2c->wait);
 	ret = request_irq(irq, xiic_isr, 0, pdev->name, i2c);
@@ -737,6 +735,8 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 		goto request_irq_failed;
 	}

+	xiic_reinit(i2c);
+
 	/* add i2c adapter to i2c tree */
 	ret = i2c_add_adapter(&i2c->adap);
 	if (ret) {
--
1.8.2.3


--=_mimegpg-monstr-desktop-11222-1381401580-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlJWg+wACgkQykllyylKDCEMwQCgmoo6DNAUbxDSHQIAmupyaFLD
uRcAn30dMGYDduJMeWUJUSWb/zN+r9yI
=ZK/g
-----END PGP SIGNATURE-----

--=_mimegpg-monstr-desktop-11222-1381401580-0001--
