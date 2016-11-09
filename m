From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v3 1/3] i2c: pxa: Add support for the I2C units found in
 Armada 3700
Date: Wed, 09 Nov 2016 11:21:06 +0100
Message-ID: <87y40tkl7x.fsf@free-electrons.com>
References: <20161109101349.18722-1-romain.perier@free-electrons.com>
 <20161109101349.18722-2-romain.perier@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161109101349.18722-2-romain.perier@free-electrons.com> (Romain
 Perier's message of "Wed, 9 Nov 2016 11:13:47 +0100")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Romain Perier <romain.perier@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Yahuda Yitschak <yehuday@marvell.com>, Omri Itach <omrii@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Igal Liberman <igall@marvell.com>, Hanna Hawa <hannah@marvell.com>, Wolfram Sang <wsa@the-dreams.de>, Neta Zur Hershkovits <neta@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, linux-i2c@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Shadi Ammouri <shadi@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Hi Romain,


You was too fast I didn't have time to commnent about Baruch suggestion.

 On mer., nov. 09 2016, Romain Perier <romain.perier@free-electrons.com> wrote:

> The Armada 3700 has two I2C controllers that is compliant with the I2C
> Bus Specificiation 2.1, supports multi-master and different bus speed:
> Standard mode (up to 100 KHz), Fast mode (up to 400 KHz),
> High speed mode (up to 3.4 Mhz).
>
> This IP block has a lot of similarity with the PXA, except some register
> offsets and bitfield. This commits adds a basic support for this I2C
> unit.
>
> Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
> Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>
> Changes in v3:
>  - Replaced the type of hm_mask and fm_mask by unsigned int,
>    instead of unsigned long.

[...]


>  #define ISR_RWM		(1 << 0)	   /* read/write mode */
> @@ -193,6 +204,8 @@ struct pxa_i2c {
>  	unsigned char		master_code;
>  	unsigned long		rate;
>  	bool			highmode_enter;
> +	unsigned int		fm_mask;
> +	unsigned int		hs_mask;

These masks are used with writel and readl which use an u32. So the
better is to use this type.

Gregory

>  };
>  
>  #define _IBMR(i2c)	((i2c)->reg_ibmr)
> @@ -503,8 +516,8 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
>  		writel(i2c->slave_addr, _ISAR(i2c));
>  
>  	/* set control register values */
> -	writel(I2C_ICR_INIT | (i2c->fast_mode ? ICR_FM : 0), _ICR(i2c));
> -	writel(readl(_ICR(i2c)) | (i2c->high_mode ? ICR_HS : 0), _ICR(i2c));
> +	writel(I2C_ICR_INIT | (i2c->fast_mode ? i2c->fm_mask : 0), _ICR(i2c));
> +	writel(readl(_ICR(i2c)) | (i2c->high_mode ? i2c->hs_mask : 0), _ICR(i2c));
>  



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
