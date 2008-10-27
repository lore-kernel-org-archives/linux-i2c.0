From: "Hu Mingkai-B21284" <B21284-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: How to pass board specific info to I2C driver module
Date: Mon, 27 Oct 2008 16:49:15 +0800
Message-ID: <CF6163088BDE8747873ADAA4AF922BF258D76D@zmy16exm21.fsl.freescale.net>
References: <CF6163088BDE8747873ADAA4AF922BF258D734@zmy16exm21.fsl.freescale.net>
	<20081027092125.0192b81c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <20081027092125.0192b81c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

I feel so sorry for the inconvenience this mail brought to you all.
Sorry again.

Br,
Vincent

-----Original Message-----
From: Jean Delvare [mailto:khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org] 
Sent: Monday, October 27, 2008 4:21 PM
To: Hu Mingkai-B21284
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Subject: Re: [i2c] How to pass board specific info to I2C driver module

Hi Vincent,

On Mon, 27 Oct 2008 10:00:44 +0800, Hu Mingkai-B21284 wrote:
> I'm working on an ADC chip (MCP3021) driver under Linux 2.6.27.
> We used these two chips to monitor the CPU core current and platform 
> current individually, which is converted to voltage as the ADC chip's 
> input.
> As you know, the driver shouldn't contain the board specific info, 
> such as, the chip's work voltage, the ratio of voltage and current.
> So how to pass these info to the driver module?
>  
> Here is the way I can think of:
> 1. to use dts file to pass the info to the module.
>     This way make the driver is bound to OF implement.
>  
> 2. to use the module parameter.
>     For different chips, the work voltage and the ratio may be 
> different,
>     but the chip uses the same driver.
>  
> Any other idea? Please give me some advice. Thanks a lot.

Once again this question has nothing to do with I2C, so this is the
wrong mailing list. So, once again, please ask on the lm-sensors list
instead.
