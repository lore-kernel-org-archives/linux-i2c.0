From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 09/24] macintosh: fix dangling pointers
Date: Sat, 20 Mar 2010 15:12:50 +0100
Message-ID: <1269094385-16114-10-git-send-email-w.sang@pengutronix.de>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
To: kernel-janitors@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org, Colin Leroy <colin@colino.net>
List-Id: linux-i2c@vger.kernel.org

Fix I2C-drivers which missed setting clientdata to NULL before freeing the
structure it points to. Also fix drivers which do this _after_ the structure
was freed already.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Colin Leroy <colin@colino.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Found using coccinelle, then reviewed. Full patchset is available via
kernel-janitors, linux-i2c, and LKML.
---
 drivers/macintosh/therm_adt746x.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index c42eeb4..16d82f1 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -182,6 +182,7 @@ remove_thermostat(struct i2c_client *client)
 
 	thermostat = NULL;
 
+	i2c_set_clientdata(client, NULL);
 	kfree(th);
 
 	return 0;
@@ -399,6 +400,7 @@ static int probe_thermostat(struct i2c_client *client,
 	rc = read_reg(th, CONFIG_REG);
 	if (rc < 0) {
 		dev_err(&client->dev, "Thermostat failed to read config!\n");
+		i2c_set_clientdata(client, NULL);
 		kfree(th);
 		return -ENODEV;
 	}
-- 
1.7.0
