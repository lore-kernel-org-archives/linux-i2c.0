From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] i2c/imx: add device tree probe support
Date: Tue, 2 Aug 2011 09:35:59 +0100
Message-ID: <CAAQ0ZWT+HK35ak8yKqB5gNPyU8r+9Rr46hX+5Q27Y9W9D1ZMvA@mail.gmail.com>
References: <1312050087-15701-1-git-send-email-shawn.guo@linaro.org>
	<1312050087-15701-3-git-send-email-shawn.guo@linaro.org>
	<20110801212516.GA22243@freya.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110801212516.GA22243-RazCHl0VsYgkUSuvROHNpA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: t@freya.fluff.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 1 August 2011 22:25, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:
> On Sun, Jul 31, 2011 at 02:21:27AM +0800, Shawn Guo wrote:
>> It adds device tree probe support for i2c-imx driver.
>>
>> Signed-off-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
>> Cc: Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
>> Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
>> ---
>> =A0.../devicetree/bindings/i2c/fsl-imx-i2c.txt =A0 =A0 =A0 =A0| =A0 =
25 ++++++++++++++++++++
>> =A0drivers/i2c/busses/i2c-imx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 25 +++++++++++++++----
>> =A02 files changed, 44 insertions(+), 6 deletions(-)
>> =A0create mode 100644 Documentation/devicetree/bindings/i2c/fsl-imx-=
i2c.txt
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/fsl-imx-i2c.txt b=
/Documentation/devicetree/bindings/i2c/fsl-imx-i2c.txt
>> new file mode 100644
>> index 0000000..f3cf43b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/i2c/fsl-imx-i2c.txt
>> @@ -0,0 +1,25 @@
>> +* Freescale Inter IC (I2C) and High Speed Inter IC (HS-I2C) for i.M=
X
>> +
>> +Required properties:
>> +- compatible : Should be "fsl,<chip>-i2c"
>> +- reg : Should contain I2C/HS-I2C registers location and length
>> +- interrupts : Should contain I2C/HS-I2C interrupt
>> +
>> +Optional properties:
>> +- clock-frequency : Constains desired I2C/HS-I2C bus clock frequenc=
y in Hz.
>> + =A0The absence of the propoerty indicates the default frequency 10=
0 kHz.
>> +
>> +Examples:
>> +
>> +i2c@83fc4000 { /* I2C2 on i.MX51 */
>> + =A0 =A0 compatible =3D "fsl,imx51-i2c", "fsl,imx1-i2c";
>> + =A0 =A0 reg =3D <0x83fc4000 0x4000>;
>> + =A0 =A0 interrupts =3D <63>;
>> +};
>> +
>> +i2c@70038000 { /* HS-I2C on i.MX51 */
>> + =A0 =A0 compatible =3D "fsl,imx51-i2c", "fsl,imx1-i2c";
>> + =A0 =A0 reg =3D <0x70038000 0x4000>;
>> + =A0 =A0 interrupts =3D <64>;
>> + =A0 =A0 clock-frequency =3D <400000>;
>> +};
>
> It occurs to me that the clock-frequency field should be a standard
> used by all of-i2c drivers? could we have a standardised set of
> properties and a standard chunk of code that reads them?
>
Yes, "clock-frequency" is a common property for all clock frequency
binding, not only for of-i2c but all drivers that need to get clock
frequency from device tree.  And it's a u32 and being read by the
common OF API of_property_read_u32().  So to answer your question,
both the binding and code have already been standard.

Regards,
Shawn

>> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-i=
mx.c
>> index 54d809e..58832e5 100644
>> --- a/drivers/i2c/busses/i2c-imx.c
>> +++ b/drivers/i2c/busses/i2c-imx.c
>> @@ -48,6 +48,9 @@
>> =A0#include <linux/platform_device.h>
>> =A0#include <linux/clk.h>
>> =A0#include <linux/slab.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_i2c.h>
>>
>> =A0#include <mach/irqs.h>
>> =A0#include <mach/hardware.h>
>> @@ -125,6 +128,11 @@ struct imx_i2c_struct {
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0ifdr; /* IMX_I2C_IFD=
R */
>> =A0};
>>
>> +static const struct of_device_id i2c_imx_dt_ids[] =3D {
>> + =A0 =A0 { .compatible =3D "fsl,imx1-i2c", },
>> + =A0 =A0 { /* sentinel */ }
>> +};
>> +
>> =A0/** Functions for IMX I2C adapter driver ************************=
***************
>> =A0*****************************************************************=
**************/
>>
>> @@ -469,7 +477,7 @@ static int __init i2c_imx_probe(struct platform_=
device *pdev)
>> =A0 =A0 =A0 struct imxi2c_platform_data *pdata =3D pdev->dev.platfor=
m_data;
>> =A0 =A0 =A0 void __iomem *base;
>> =A0 =A0 =A0 resource_size_t res_size;
>> - =A0 =A0 int irq;
>> + =A0 =A0 int irq, bitrate;
>> =A0 =A0 =A0 int ret;
>>
>> =A0 =A0 =A0 dev_dbg(&pdev->dev, "<%s>\n", __func__);
>> @@ -512,6 +520,7 @@ static int __init i2c_imx_probe(struct platform_=
device *pdev)
>> =A0 =A0 =A0 i2c_imx->adapter.algo =A0 =A0 =A0 =A0 =A0 =3D &i2c_imx_a=
lgo;
>> =A0 =A0 =A0 i2c_imx->adapter.dev.parent =A0 =A0 =3D &pdev->dev;
>> =A0 =A0 =A0 i2c_imx->adapter.nr =A0 =A0 =A0 =A0 =A0 =A0 =3D pdev->id=
;
>> + =A0 =A0 i2c_imx->adapter.dev.of_node =A0 =A0=3D pdev->dev.of_node;
>> =A0 =A0 =A0 i2c_imx->irq =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D =
irq;
>> =A0 =A0 =A0 i2c_imx->base =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D ba=
se;
>> =A0 =A0 =A0 i2c_imx->res =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D =
res;
>> @@ -538,10 +547,12 @@ static int __init i2c_imx_probe(struct platfor=
m_device *pdev)
>> =A0 =A0 =A0 i2c_set_adapdata(&i2c_imx->adapter, i2c_imx);
>>
>> =A0 =A0 =A0 /* Set up clock divider */
>> - =A0 =A0 if (pdata && pdata->bitrate)
>> - =A0 =A0 =A0 =A0 =A0 =A0 i2c_imx_set_clk(i2c_imx, pdata->bitrate);
>> - =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 i2c_imx_set_clk(i2c_imx, IMX_I2C_BIT_RATE)=
;
>> + =A0 =A0 bitrate =3D IMX_I2C_BIT_RATE;
>> + =A0 =A0 ret =3D of_property_read_u32(pdev->dev.of_node,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"cl=
ock-frequency", &bitrate);
>> + =A0 =A0 if (ret < 0 && pdata && pdata->bitrate)
>> + =A0 =A0 =A0 =A0 =A0 =A0 bitrate =3D pdata->bitrate;
>> + =A0 =A0 i2c_imx_set_clk(i2c_imx, bitrate);
>>
>> =A0 =A0 =A0 /* Set up chip registers to defaults */
>> =A0 =A0 =A0 writeb(0, i2c_imx->base + IMX_I2C_I2CR);
>> @@ -554,6 +565,8 @@ static int __init i2c_imx_probe(struct platform_=
device *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail5;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 of_i2c_register_devices(&i2c_imx->adapter);
>> +
>> =A0 =A0 =A0 /* Set up platform driver data */
>> =A0 =A0 =A0 platform_set_drvdata(pdev, i2c_imx);
>>
>> @@ -584,7 +597,6 @@ fail1:
>> =A0static int __exit i2c_imx_remove(struct platform_device *pdev)
>> =A0{
>> =A0 =A0 =A0 struct imx_i2c_struct *i2c_imx =3D platform_get_drvdata(=
pdev);
>> - =A0 =A0 struct imxi2c_platform_data *pdata =3D pdev->dev.platform_=
data;
>>
>> =A0 =A0 =A0 /* remove adapter */
>> =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "adapter removed\n");
>> @@ -613,6 +625,7 @@ static struct platform_driver i2c_imx_driver =3D=
 {
>> =A0 =A0 =A0 .driver =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D DRIVER_NAME,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D i2c_imx_dt_ids,
>> =A0 =A0 =A0 }
>> =A0};
>>
>> --
>> 1.7.4.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-i2c"=
 in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
