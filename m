From: =?iso-8859-15?q?Lothar_Wa=DFmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH] I2C driver for IMX
Date: Fri, 14 Mar 2008 08:37:16 +0100
Message-ID: <18394.11052.709243.186544@ipc1.ka-ro>
References: <frbjjv$ndk$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1750941825=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <frbjjv$ndk$1@ger.gmane.org>
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
Cc: linux-arm-kernel@lists.arm.linux.org.uk, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

--===============1750941825==

Hi,

> +    #ifdef CONFIG_I2C_DEBUG_BUS
> +        printk("I2C: <i2c_imx_bus_busy>\n");
> +    #endif
>
Using a macro that evaluates to nothing in case CONFIG_I2C_DEBUG_BUS is
not defined would make the code much more readable.

> +	temp = readb ( i2c_imx->base + IMX_I2C_I2CR);
> +    temp |= I2CR_MSTA;
>
inconsistent indentation with tabs and spaces (througout the whole patch).

> +	if (!i2c_imx) {
> +		printk("I2C: can't allocate inteface!\n");
                                               ^^
typo.


Lothar Wassmann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstraße 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Geschäftsführer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________


--===============1750941825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
--===============1750941825==--
