From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: possible recursive locking detected
Date: Sun, 9 Mar 2008 23:41:50 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803092332160.18589@twin.jikos.cz>
References: <1205082504.47d41988f0db5@imp.free.fr>
	<alpine.DEB.1.00.0803092215010.5349@sheep.housecafe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <alpine.DEB.1.00.0803092215010.5349-F0SnE0R9v5eQ/Pez2Lbyp4QuADTiUCJX@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Christian Kujau <lists-AanptEQQ3TL9uQeqpI+JUg@public.gmane.org>
Cc: bruno.roussel-GANU6spQydw@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 9 Mar 2008, Christian Kujau wrote:

> > =============================================
> > [ INFO: possible recursive locking detected ]
> > 2.6.24.2-1mdv #1
> > ---------------------------------------------
> Hm, strange: a similiar looking issue has been reported back in 2006, it 
> even comes with a patch: http://lkml.org/lkml/2006/10/14/38
> ..but I cannot tell if the patch made it into mainline. I've Cc'ed the i2c
> folks, maybe they can tell what's going on here.

I don't recall this, but from looking at the source it seems that only 
part of my patch made it upstream for some reason ... 

Bruno, does the patch below remove the warning for you? (we should rather 
used lockdep_set_class() now, when this is already available ... it wasn't 
in the time I was doping the original patch back in 2006).



Set locking depth properly (level == 0 for DVB frontend, level == 1 for 
DVB adapter).

Signed-off-by: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>

diff --git a/drivers/media/dvb/dvb-usb/dvb-usb-i2c.c b/drivers/media/dvb/dvb-usb/dvb-usb-i2c.c
index 23428cd..8c5dc35 100644
--- a/drivers/media/dvb/dvb-usb/dvb-usb-i2c.c
+++ b/drivers/media/dvb/dvb-usb/dvb-usb-i2c.c
@@ -27,6 +27,7 @@ int dvb_usb_i2c_init(struct dvb_usb_device *d)
 #endif
 	d->i2c_adap.algo      = d->props.i2c_algo;
 	d->i2c_adap.algo_data = NULL;
+	d->i2c_adap.level = 1;
 	d->i2c_adap.dev.parent = &d->udev->dev;
 
 	i2c_set_adapdata(&d->i2c_adap, d);
diff --git a/drivers/media/dvb/frontends/dibx000_common.c b/drivers/media/dvb/frontends/dibx000_common.c
index 315e09e..a3ed8cf 100644
--- a/drivers/media/dvb/frontends/dibx000_common.c
+++ b/drivers/media/dvb/frontends/dibx000_common.c
@@ -111,6 +111,7 @@ static int i2c_adapter_init(struct i2c_adapter *i2c_adap, struct i2c_algorithm *
 	i2c_adap->class     = I2C_CLASS_TV_DIGITAL,
 	i2c_adap->algo      = algo;
 	i2c_adap->algo_data = NULL;
+	i2c_adap->level = 0;
 	i2c_set_adapdata(i2c_adap, mst);
 	if (i2c_add_adapter(i2c_adap) < 0)
 		return -ENODEV;

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
