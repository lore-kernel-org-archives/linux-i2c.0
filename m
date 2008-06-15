From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [i2c] [PATCH V6] I2C driver for IMX
Date: Mon, 16 Jun 2008 00:56:01 +0100
Message-ID: <20080615235601.GB30539@fluff.org.uk>
References: <g0ts5c$mm$2@ger.gmane.org> <20080601220941.GB6226@fluff.org.uk>
	<4851139B.9000105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <4851139B.9000105@gmail.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Darius <augulis.darius@gmail.com>
Cc: i2c@lm-sensors.org, Ben Dooks <ben-linux@fluff.org>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-i2c@vger.kernel.org

On Thu, Jun 12, 2008 at 03:16:27PM +0300, Darius wrote:
> >> +static struct platform_driver i2c_imx_driver = {
> >> +	.probe	= i2c_imx_probe,
> >> +	.remove	= i2c_imx_remove,
> >> +	.driver	= {
> >> +		.name	= DRIVER_NAME,
> >> +		.owner	= THIS_MODULE,
> >> +	}
> >> +};
> > 
> > No suspend/resume support? See above note on ordering.
> > 
> 
> There are nothing to do in suspend/resume routines, because no possibility to turn off I2C clock.
> I2C module itself is disabled every time when data is not transmited.
> Seems, that there are only few I2C drivers (at91, blackfin, pnx) with suspend/resume suport.
> Most drivers has not suspend/resume support.

It depends, does the hardware keep the peripheral state during
suspend?

> Should I declare empty suspend/resume routines with return 0; only?

No, the system ignores NULL suspend/resume entries.
 
> _______________________________________________
> i2c mailing list
> i2c@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/i2c

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
