From: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers
 configurable via FDT
Date: Thu, 31 Jul 2008 13:35:51 -0500
Message-ID: <48920607.5040606@freescale.com>
References: <4889EFFE.2070201@grandegger.com> <4889FD1D.4010804@freescale.com>
	<20080727012722.GH12191@secretlab.ca>
	<4891A744.6060005@grandegger.com>
	<9e4733910807310849g7e5612dbk9536733e061af8ad@mail.gmail.com>
	<4891F4D8.9090905@grandegger.com>
	<fa686aa40807311031r66f6451aw206faf54509c14d9@mail.gmail.com>
	<4891FC3A.7040609@freescale.com>
	<20080731180959.GA29057@secretlab.ca>
	<489200B6.9060906@freescale.com>
	<20080731182810.GB29097@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080731182810.GB29097-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Grant Likely wrote:

> No it doesn't, it depends on the register interface to decide
> compatibility.  Clock interface is part of that. 

I don't think so.  The interface for programming the clock registers is
identical on all 8[356]xx parts.  The only thing that matters is what specific
values to put in the FDR and DFSR registers to get a desired I2C bus speed.
That answer is dependent on the actual clock input to the device, which is
external to the device.  I wouldn't call the input frequency a property of the
I2C device.

> I suggested encoding
> the clock divider directly in compatible (implicit in the SoC version),
> but it doesn't have to be that way.  If clock freq is obtained from
> another property or some other method then that is okay too.

I think we agree on that.

> There is nothing wrong with it (as long as we agree and it gets
> documented).  I certainly don't have a problem with doing it this way.

I propose the property "clock-frequency", like this:

		i2c@3000 {
			#address-cells = <1>;
			#size-cells = <0>;
			cell-index = <0>;
			compatible = "fsl-i2c";
			reg = <0x3000 0x100>;
			interrupts = <14 0x8>;
			interrupt-parent = <&ipic>;
			dfsrr;
			clock-frequency = <0xblablabla>;  <-- added by U-Boot
		};

Note that the dfsrr property already differentiates between 8xxx and 52xx, so
maybe we don't need any other device tree changes.

-- 
Timur Tabi
Linux kernel developer at Freescale

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
