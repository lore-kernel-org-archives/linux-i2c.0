From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Re: [RFC] SW connection between DVB Transport Stream demuxer and
 I2C-based frontend
Date: Mon, 8 Jul 2019 18:42:02 +0200
Message-ID: <4b9c5a48-aaed-5f1f-1835-167fcdcb7655@free.fr>
References: <5e35b4fb-646d-6428-f372-ee47d7352cd6@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5e35b4fb-646d-6428-f372-ee47d7352cd6@free.fr>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: I2C <linux-i2c@vger.kernel.org>, linux-media <linux-media@vger.kernel.org>, GPIO <linux-gpio@vger.kernel.org>
Cc: Peter Korsgaard <peter@korsgaard.com>, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Brad Love <brad@nextdimension.cc>, =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>, Bjorn Andersson <bjorn.andersson@linaro.org>, Antti Palosaari <crope@iki.fi>, Simon Horman <horms+renesas@verge.net.au>, Mauro Carvalho Chehab <mchehab@kernel.org>, Olli Salonen <olli.salonen@iki.fi>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On 08/07/2019 13:08, Marc Gonzalez wrote:

> PROBLEM #1
> 
> The media framework requires that the TSIF and demod be "tied" together,
> by calling dvb_register_frontend(). If I do that in tsif.c, then I need to
> get the frontend pointer from the demod at some point. There is no such
> callback presently. Since si2168 lives on an I2C bus, I can get a
> struct i2c_client pointer, through the DT phandle. But some kind of
> abstraction is missing to query the i2c_client object to make sure it
> is a demodulator and request its frontend pointer.
> 
> For the time being, I have added a very generic pointer to struct i2c_client
> but I feel this is not quite right... (though it gets the job done)

As far as PROBLEM #1 is concerned, I think I have a better solution;
one that doesn't involve messing with struct i2c_client.

Basically, we embed a common struct in every demod driver, at the
beginning of their private control struct. That way, demod consumers
have a generic/common data type to inspect, and don't need to know
the specific demod they are working with. (I left the removals in
the diff below, to show the two proposed solutions so far.)

@linux-media maintainers, I think this solution is acceptable for
mainline, right?

Regards.



diff --git a/drivers/media/dvb-frontends/si2168.c b/drivers/media/dvb-frontends/si2168.c
index 726bb6759315..692f3207cd9d 100644
--- a/drivers/media/dvb-frontends/si2168.c
+++ b/drivers/media/dvb-frontends/si2168.c
@@ -666,12 +666,6 @@ struct si2168_config si2168_config;
 struct si2157_config si2157_config;
 struct i2c_client *tuner;
 
-static void *get_fe(struct i2c_client *client)
-{
-	struct si2168_dev *dev = i2c_get_clientdata(client);
-	return &dev->fe;
-}
-
 static int si2168_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
@@ -700,7 +694,7 @@ static int si2168_probe(struct i2c_client *client,
 		goto err;
 	}
 
-	client->get_something = get_fe;
+	dev->common.fe = &dev->fe;
 	i2c_set_clientdata(client, dev);
 	mutex_init(&dev->i2c_mutex);
 
diff --git a/drivers/media/dvb-frontends/si2168_priv.h b/drivers/media/dvb-frontends/si2168_priv.h
index 804d5b30c697..2e69080f8a1c 100644
--- a/drivers/media/dvb-frontends/si2168_priv.h
+++ b/drivers/media/dvb-frontends/si2168_priv.h
@@ -22,6 +22,7 @@
 
 /* state struct */
 struct si2168_dev {
+	struct dvb_demod_common common;
 	struct mutex i2c_mutex;
 	struct i2c_mux_core *muxc;
 	struct dvb_frontend fe;
diff --git a/drivers/media/platform/tsif.c b/drivers/media/platform/tsif.c
index a0118c2ee870..c13fa19c9779 100644
--- a/drivers/media/platform/tsif.c
+++ b/drivers/media/platform/tsif.c
@@ -237,6 +237,7 @@ static int msm_tspp_probe(struct platform_device *pdev)
 	{
 		struct device_node *tsif_node, *demod_node;
 		struct i2c_client *demod;
+		struct dvb_demod_common *demod_data;
 
 		tsif_node = pdev->dev.of_node;
 		demod_node = of_parse_phandle(tsif_node, "demod", 0);
@@ -244,10 +245,8 @@ static int msm_tspp_probe(struct platform_device *pdev)
 		demod = of_find_i2c_device_by_node(demod_node);
 		if (!demod) panic("of_find_i2c_device_by_node");
 
-		/*** TODO: Improve callback naming & handling ***/
-		if (!demod->get_something)
-			panic("Wrong i2c_client");
-		my_dvb_frontend = demod->get_something(demod);
+		demod_data = i2c_get_clientdata(demod);
+		my_dvb_frontend = demod_data->fe;
 		of_node_put(demod_node);
 	}
 
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 5fca596e0dd0..e982b8913b73 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -295,8 +295,6 @@ struct i2c_driver {
 };
 #define to_i2c_driver(d) container_of(d, struct i2c_driver, driver)
 
-typedef void *generic_func(struct i2c_client *this);
-
 /**
  * struct i2c_client - represent an I2C slave device
  * @flags: I2C_CLIENT_TEN indicates the device uses a ten bit chip address;
@@ -330,7 +328,6 @@ struct i2c_client {
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 	i2c_slave_cb_t slave_cb;	/* callback for slave mode	*/
 #endif
-	generic_func *get_something;
 };
 #define to_i2c_client(d) container_of(d, struct i2c_client, dev)
 
diff --git a/include/media/dvb_frontend.h b/include/media/dvb_frontend.h
index f05cd7b94a2c..087486bc027e 100644
--- a/include/media/dvb_frontend.h
+++ b/include/media/dvb_frontend.h
@@ -73,6 +73,10 @@ struct dvb_frontend_tune_settings {
 
 struct dvb_frontend;
 
+struct dvb_demod_common {
+	struct dvb_frontend *fe;
+};
+
 /**
  * struct dvb_tuner_info - Frontend name and min/max ranges/bandwidths
  *
