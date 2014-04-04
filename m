From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 2/3] i2c: Add driver for Cadence I2C controller
Date: Fri, 4 Apr 2014 09:32:32 -0700
Message-ID: <53e29fb2-2a42-4cbf-9c15-490d81ee0de4@CH1EHSMHS005.ehs.local>
References: <1396547967-19260-1-git-send-email-soren.brinkmann@xilinx.com>
 <1396547967-19260-2-git-send-email-soren.brinkmann@xilinx.com>
 <20140404143847.GA5529@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140404143847.GA5529@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 2014-04-04 at 04:38PM +0200, Wolfram Sang wrote:
> On Thu, Apr 03, 2014 at 10:59:26AM -0700, Soren Brinkmann wrote:
> > Add a driver for the Cadence I2C controller. This controller is for
> > example found in Xilinx Zynq.
> >=20
> > Signed-off-by: Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> > Tested-by: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> > Reviewed-by: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
>=20
> Only minor stuff, but since you resend anyhow because of 400kHz issue=
=2E..
>=20
> > +static void cdns_i2c_mrecv(struct cdns_i2c *id)
> > +{
> > +	unsigned int ctrl_reg;
> > +	unsigned int isr_status;
> > +
> > +	id->p_recv_buf =3D id->p_msg->buf;
> > +	id->recv_count =3D id->p_msg->len;
> > +
> > +	/* Put the controller in master receive mode and clear the FIFO *=
/
> > +	ctrl_reg =3D cdns_i2c_readreg(CDNS_I2C_CR_OFFSET);
> > +	ctrl_reg |=3D CDNS_I2C_CR_RW | CDNS_I2C_CR_CLR_FIFO;
> > +
> > +	if ((id->p_msg->flags & I2C_M_RECV_LEN) =3D=3D I2C_M_RECV_LEN)
>=20
> 'if (id->p_msg->flags & I2C_M_RECV_LEN)' is enough.
>=20
> > +		/* Report the other error interrupts to application as EIO */
> > +		if (id->err_status & (CDNS_I2C_IXR_RX_UNF |
> > +				      CDNS_I2C_IXR_TX_OVF |
> > +				      CDNS_I2C_IXR_RX_OVF |
> > +				      CDNS_I2C_IXR_NACK)) {
> > +			cdns_i2c_master_reset(adap);
> > +			return -EIO;
> > +		}
>=20
> NACK is returned as -ENXIO. Check 'Documentation/i2c/fault-codes' for
> standard patterns. I'd think the rest is EIO, though.

Okay, I'll put this into the next version:
diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-=
cadence.c
index 43af8c351c8b..63f3f03ecc9b 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -311,7 +311,7 @@ static void cdns_i2c_mrecv(struct cdns_i2c *id)
        ctrl_reg =3D cdns_i2c_readreg(CDNS_I2C_CR_OFFSET);
        ctrl_reg |=3D CDNS_I2C_CR_RW | CDNS_I2C_CR_CLR_FIFO;
=20
-       if ((id->p_msg->flags & I2C_M_RECV_LEN) =3D=3D I2C_M_RECV_LEN)
+       if (id->p_msg->flags & I2C_M_RECV_LEN)
                id->recv_count =3D I2C_SMBUS_BLOCK_MAX + 1;
=20
        /*
@@ -531,12 +531,13 @@ static int cdns_i2c_master_xfer(struct i2c_adapte=
r *adap, struct i2c_msg *msgs,
                if (ret)
                        return ret;
=20
-               /* Report the other error interrupts to application as =
EIO */
-               if (id->err_status & (CDNS_I2C_IXR_RX_UNF |
-                                     CDNS_I2C_IXR_TX_OVF |
-                                     CDNS_I2C_IXR_RX_OVF |
-                                     CDNS_I2C_IXR_NACK)) {
+               /* Report the other error interrupts to application */
+               if (id->err_status) {
                        cdns_i2c_master_reset(adap);
+
+                       if (id->err_status & CDNS_I2C_IXR_NACK)
+                               return -ENXIO;
+
                        return -EIO;
                }
        }

	Thanks,
	S=C3=B6ren
