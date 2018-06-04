From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v9 2/7] i2c: Add FSI-attached I2C master algorithm
Date: Tue, 05 Jun 2018 09:38:06 +1000
Message-ID: <7daf29f643bb0445fceef85b1a7fff71048f2aa6.camel@kernel.crashing.org>
References: <1528138850-18259-1-git-send-email-eajames@linux.vnet.ibm.com>
         <1528138850-18259-3-git-send-email-eajames@linux.vnet.ibm.com>
         <CAHp75Vd7NvDFmWSzNDz-tgGvMVyXU7Z16LgGCWnHkY-3kE7fwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vd7NvDFmWSzNDz-tgGvMVyXU7Z16LgGCWnHkY-3kE7fwg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Eddie James <eajames@linux.vnet.ibm.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 2018-06-04 at 22:21 +0300, Andy Shevchenko wrote:
> > +#define I2C_INT_ENABLE         0x0000ff80
> > +#define I2C_INT_ERR            0x0000fcc0
> 
> Now it looks like a flags combinations.
> For me as for reader would be better to see quickly a decoded line.
> 
> My proposal is to introduce something like following
> 
> _INT_ALL  GENMASK()
> _INT_ENABLE (_INT_ALL & ~(_FOO | _BAR))
> _INT_ERR ... similar way as above ...
> 
> What do you think?

I don't think this absolutely needs to change but yes, open coding is
error prone. However I would think it more readable to use positive
logic and just list all the bits that are *set* even if it's a bit more
text:

#define I2C_INT_ERR	(I2C_INT_INV_CMD	|\                			
 I2C_INT_PARITY         |\
			 I2C_INT_BE_OVERRUN	|\
			.../...)

#define I2C_INT_ENABLE	(I2C_INT_ERR		|\
			 I2C_INT_DAT_REQ	|\
			 I2C_INT_CMD_COMP)

Note: Eddie, I notice I2C_INT_BUSY is in "ERR" but not in "ENABLE", any
reason for that ?

Cheers,
Ben.
