From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/8] [media] s5c73m3: Don't use
	i2c_client->driver
Date: Sun, 29 Sep 2013 10:50:59 +0200
Message-ID: <1380444666-12019-2-git-send-email-lars@metafoo.de>
References: <1380444666-12019-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1380444666-12019-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <wsa@the-dreams.de>, David Airlie <airlied@linux.ie>, Mauro Carvalho Chehab <m.chehab@samsung.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Andrzej Hajda <a.hajda@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-i2c@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The 'driver' field of the i2c_client struct is redundant and is going to be
removed. The results of the expressions 'client->driver.driver->field' and
'client->dev.driver->field' are identical, so replace all occurrences of the
former with the later.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/media/i2c/s5c73m3/s5c73m3-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/s5c73m3/s5c73m3-core.c b/drivers/media/i2c/s5c73m3/s5c73m3-core.c
index b76ec0e..1083890 100644
--- a/drivers/media/i2c/s5c73m3/s5c73m3-core.c
+++ b/drivers/media/i2c/s5c73m3/s5c73m3-core.c
@@ -1581,7 +1581,7 @@ static int s5c73m3_probe(struct i2c_client *client,
 	oif_sd = &state->oif_sd;
 
 	v4l2_subdev_init(sd, &s5c73m3_subdev_ops);
-	sd->owner = client->driver->driver.owner;
+	sd->owner = client->dev.driver->owner;
 	v4l2_set_subdevdata(sd, state);
 	strlcpy(sd->name, "S5C73M3", sizeof(sd->name));
 
-- 
1.8.0
