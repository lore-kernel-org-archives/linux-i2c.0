From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCHv3] I2C: MV64XXX: Add Device Tree support
Date: Mon, 16 Jul 2012 14:37:14 +0200
Message-ID: <20120716123714.GG2489@lunn.ch>
References: <1342430205-13702-1-git-send-email-andrew@lunn.ch>
 <1342430205-13702-2-git-send-email-andrew@lunn.ch>
 <20120716142019.3f6cdc26@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20120716142019.3f6cdc26@skate>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, sebastian.hesselbarth@googlemail.com, w.sang@pengutronix.de, linux-i2c@vger.kernel.org, linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jul 16, 2012 at 02:20:19PM +0200, Thomas Petazzoni wrote:
> Le Mon, 16 Jul 2012 11:16:45 +0200,
> Andrew Lunn <andrew@lunn.ch> a ??crit :
> 
> > + - reg             : Offset and length of the register set for the device
> > + - compatible      : Should be "marvell,mv64xxx-i2c"
> > + - interrupts      : Te interrupt number
> 
>                         The
> 
> > +		i2c@11000 {
> > +			compatible = "marvell,mv64xxx-i2c";
> > +			reg = <0x11000 0x20>;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			interrupts = <29>;
> > +			clock-frequency = <400000>;
> > +			timeout-ms = <1000>;
> > +			status = "disable";
> 
> This should be "disabled".

Thanks.

> The #ifdef machinery in the ->probe() function looks a bit ugly, but I
> guess this can be cleaned up once all platforms using this driver will
> have been converted to DT + clock framework.

Yes, it is ugly :-(

The ARM platforms are moving in the right direction. They all have
clock framework support and only mv78xx0 has nobody working on DT, as
far as i know.

I've no idea if anybody is still working on the powerpc platforms.
There are two _defconfig files that use it.

     Andrew
