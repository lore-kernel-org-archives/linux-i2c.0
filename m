From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: davinci: Add block read functionality for IPMI
Date: Thu, 22 May 2014 11:00:41 +0200
Message-ID: <20140522090041.GA2573@katana>
References: <1398970186-12204-1-git-send-email-m-karicheri2@ti.com>
 <3E54258959B69E4282D79E01AB1F32B70472F6AC@DFLE11.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3E54258959B69E4282D79E01AB1F32B70472F6AC-3fIg7tRORU6IQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Karicheri, Muralidharan" <m-karicheri2-l0cyMroinI0@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Ding, Garrett" <g-ding-l0cyMroinI0@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Shilimkar, Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

thanks for the patch.

> >+/* capabilities */
> >+#define I2C_CAPABILITIES	(I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | \
> >+				 I2C_FUNC_SMBUS_READ_BLOCK_DATA)

I don't see the need for a seperate define.

> >+
> > struct davinci_i2c_dev {
> > 	struct device           *dev;
> > 	void __iomem		*base;
> >@@ -318,7 +322,13 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg
> >*msg, int stop)
> > 	davinci_i2c_write_reg(dev, DAVINCI_I2C_SAR_REG, msg->addr);
> >
> > 	dev->buf = msg->buf;
> >-	dev->buf_len = msg->len;
> >+
> >+	 /* if first received byte is length, set buf_len = 0xffff as flag */
> >+	if (msg->flags & I2C_M_RECV_LEN)
> >+		dev->buf_len = 0xffff;

a) this magic value should be a define instead of a comment
b) i2c messages easily have a 16 bit range, so 0xffff is a troublesome
choice.

> >+	else
> >+		dev->buf_len = msg->len;
> >+
> > 	dev->stop = stop;
> >
> > 	davinci_i2c_write_reg(dev, DAVINCI_I2C_CNT_REG, dev->buf_len); @@ -456,7
> >+466,7 @@ i2c_davinci_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> >
> > static u32 i2c_davinci_func(struct i2c_adapter *adap)  {
> >-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> >+	return I2C_CAPABILITIES;
> > }
> >
> > static void terminate_read(struct davinci_i2c_dev *dev) @@ -528,10 +538,32 @@ static
> >irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
> >
> > 		case DAVINCI_I2C_IVR_RDR:
> > 			if (dev->buf_len) {
> >-				*dev->buf++ =
> >-				    davinci_i2c_read_reg(dev,
> >-							 DAVINCI_I2C_DRR_REG);
> >+				*dev->buf++ = davinci_i2c_read_reg(dev,
> >+							DAVINCI_I2C_DRR_REG);
> >+				/*
> >+				 * check if the first received byte is message
> >+				 * length, i.e, I2C_M_RECV_LEN
> >+				 */
> >+				if (dev->buf_len == 0xffff)
> >+					dev->buf_len = *(dev->buf - 1) + 1;

Please rework the code to get rid of the '- 1' and '+ 1'. They look
hackish and make the code less readable.

> >+
> > 				dev->buf_len--;
> >+				/*
> >+				 * send NACK/STOP bits BEFORE last byte is
> >+				 * received
> >+				 */
> >+				if (dev->buf_len == 1) {
> >+					w = davinci_i2c_read_reg(dev,
> >+							DAVINCI_I2C_MDR_REG);
> >+					w |= DAVINCI_I2C_MDR_NACK;
> >+					davinci_i2c_write_reg(dev,
> >+							DAVINCI_I2C_MDR_REG, w);
> >+
> >+					w |= DAVINCI_I2C_MDR_STP;
> >+					davinci_i2c_write_reg(dev,
> >+							DAVINCI_I2C_MDR_REG, w);
> >+				}
> >+

Looks like an unreleated change to me? Why is this I2C_M_RECV_LEN
specific?

Kind regards,

   Wolfram

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTfby4AAoJEBQN5MwUoCm2F+MQALJXKUaaQfaA294HKDsSqxyt
WSgP93rEtZldxKLQu20QfytyBCBq2fpumBK5UEpsTnbZ7CQltPrY2u0ojc5RaA+R
IZ42+OU6K0MarbYaEHgOq8w7GkE7YgXSojQShk1bXjd5SAinO1/2Egb1u/IufrFp
EVWagX/RfkaS5CoHbWKEebbKXtMmpGShDqOwjZjZ4MvUW6t1navDpyjaKpGCjy2P
JFkadJBzQC/k47jY6+oj7r8hMRhhEReyw4337AvrY/YPPf2IcRU9jAf9IN5dc+IX
rkekRzWO+dsyl8ObxMSEGassoA/6bVad0XVhi9+9Cfg3mtsP8jY1NKpfi+fA1XuE
FTmeeOjEv+si6AR3sadVZbwz118nZZvo4RDJ2gE7I1U+F4FhaFd+HGm5zJ+Vbn0l
e2X0jmZklYXGth4AUxYjmhkA3nyEjHpghWbYcyXEt1O6SO+CjQNyrucogfs4Vanm
1zlRcNxbEHiunuvAeJj6onZzz6NDgEa2rb6DhYKpAK7AYvg+tDyTwkpdpuHPt6MJ
/9aESi8sKQUa/HX0jOmqz2iZ4SC7S4KZE6uc7Syv+5yhfsDnrJ1h+It4F8Q65mjr
T+5vSYK6FL31DeHs39B8cHA6V/OI5DO0josiecA0hJScbptWrOokB6ga1nzN4exy
bKcVRV6Hd2zmpaJQSXLv
=Dux2
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
