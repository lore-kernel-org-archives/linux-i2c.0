From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCHv3 1/6] i2c: sunxi: Add Allwinner A1X i2c driver
Date: Wed, 5 Jun 2013 23:31:44 +0200
Message-ID: <20130605213144.GB14209@lukather>
References: <1369648843-1640-1-git-send-email-maxime.ripard@free-electrons.com>
 <1369648843-1640-2-git-send-email-maxime.ripard@free-electrons.com>
 <20130605133945.GA2934@katana>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBP65X2GQKGQEZKWXQNA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20130605133945.GA2934@katana>
List-Post: <http://groups.google.com/group/linux-sunxi/post?hl=en-GB>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en-GB>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi?hl=en-GB>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe?hl=en-GB>,
 <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe?hl=en-GB>,
 <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Wed, Jun 05, 2013 at 03:39:47PM +0200, Wolfram Sang wrote:
> 
> > +#define SUNXI_I2C_ADDR_REG		(0x00)
> > +#define SUNXI_I2C_ADDR_ADDR(v)			((v & 0x7f) << 1)
> > +#define SUNXI_I2C_XADDR_REG		(0x04)
> > +#define SUNXI_I2C_DATA_REG		(0x08)
> > +#define SUNXI_I2C_CNTR_REG		(0x0c)
> > +#define SUNXI_I2C_CNTR_ASSERT_ACK		BIT(2)
> > +#define SUNXI_I2C_CNTR_INT_FLAG			BIT(3)
> > +#define SUNXI_I2C_CNTR_MASTER_STOP		BIT(4)
> > +#define SUNXI_I2C_CNTR_MASTER_START		BIT(5)
> > +#define SUNXI_I2C_CNTR_BUS_ENABLE		BIT(6)
> > +#define SUNXI_I2C_CNTR_INT_ENABLE		BIT(7)
> > +#define SUNXI_I2C_STA_REG		(0x10)
> > +#define SUNXI_I2C_STA_BUS_ERROR			(0x00)
> > +#define SUNXI_I2C_STA_START			(0x08)
> > +#define SUNXI_I2C_STA_START_REPEAT		(0x10)
> > +#define SUNXI_I2C_STA_MASTER_WADDR_ACK		(0x18)
> > +#define SUNXI_I2C_STA_MASTER_WADDR_NAK		(0x20)
> > +#define SUNXI_I2C_STA_MASTER_DATA_SENT_ACK	(0x28)
> > +#define SUNXI_I2C_STA_MASTER_DATA_SENT_NAK	(0x30)
> > +#define SUNXI_I2C_STA_MASTER_RADDR_ACK		(0x40)
> > +#define SUNXI_I2C_STA_MASTER_RADDR_NAK		(0x48)
> > +#define SUNXI_I2C_STA_MASTER_DATA_RECV_ACK	(0x50)
> > +#define SUNXI_I2C_STA_MASTER_DATA_RECV_NAK	(0x58)
> > +#define SUNXI_I2C_CCR_REG		(0x14)
> > +#define SUNXI_I2C_CCR_DIV_N(val)		(val & 0x3)
> > +#define SUNXI_I2C_CCR_DIV_M(val)		((val & 0xf) << 3)
> > +#define SUNXI_I2C_SRST_REG		(0x18)
> > +#define SUNXI_I2C_SRST_RESET			BIT(0)
> > +#define SUNXI_I2C_EFR_REG		(0x1c)
> > +#define SUNXI_I2C_LCR_REG		(0x20)
> > +
> > +#define SUNXI_I2C_DONE			BIT(0)
> > +#define SUNXI_I2C_ERROR			BIT(1)
> > +#define SUNXI_I2C_NAK			BIT(2)
> > +#define SUNXI_I2C_BUS_ERROR		BIT(3)
> 
> The register set looks similar to i2c-mv64xxx.c. Has it been considered
> to merge the two drivers?

Hmm, right, the logic seems surprisingly similar. I wasn't aware of such
a driver, so I didn't put much thought into merging them :)

However, the register layout is quite different enough to be quite
painful to support: the XADDR register here seems to be equivalent to
the Marvell's EXT_SLAVE_ADDR register, yet in the allwinner case, the
offset is 0x4, while it's 0x1c in Marvell's case, which offsets all the
other registers obviously. The status and clock registers in marvell
case looks to be merged together, while they are separate registers
here, etc.

I guess it would make the code much more complicated for such simple
drivers, so I wouldn't push too much for merging, but I guess it's your
call.

Thanks!
Maxime
