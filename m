From: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2] i2c-i801: Enable interrupts for all post-ICH5 chips
Date: Thu, 13 Dec 2012 09:53:10 +0800
Message-ID: <CAGS+omCzK2mj6EsCQo1q4MRFHghMzWNfHZmn3DjZuPLfDkoZXg@mail.gmail.com>
References: <20121031120336.3229e1a2@endymion.delvare> <20121106203803.6af84fc8@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121106203803.6af84fc8-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Wed, Nov 7, 2012 at 3:38 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> I did not receive a single bug report after interrupt support was
> added for a limited number of chips. So I'd say the code is good and
> should be enabled for all supported chips, that is: ICH5 and later.
>
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
> I was able to test on Patsburg IDF channels and although I couldn't
> test all transaction types, interrupts seem to work the same as on the
> main SMBus channel so let's enable interrupts there too.


I can confirm that the IRQ works on PantherPoint at least, if enabled
(by this patch, for example).  However, I don't know anything about
IDF, so I can't help there.
Here's an R-B, if you need it:

Reviewed-by: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Are you targeting this for 3.8?

>
>  drivers/i2c/busses/i2c-i801.c |   11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> --- linux-3.7-rc4.orig/drivers/i2c/busses/i2c-i801.c    2012-11-05 16:55:23.271739149 +0100
> +++ linux-3.7-rc4/drivers/i2c/busses/i2c-i801.c 2012-11-06 19:26:04.073280924 +0100
> @@ -1109,6 +1109,7 @@ static int __devinit i801_probe(struct p
>                 /* fall through */
>         default:
>                 priv->features |= FEATURE_I2C_BLOCK_READ;
> +               priv->features |= FEATURE_IRQ;
>                 /* fall through */
>         case PCI_DEVICE_ID_INTEL_82801DB_3:
>                 priv->features |= FEATURE_SMBUS_PEC;
> @@ -1121,16 +1122,6 @@ static int __devinit i801_probe(struct p
>                 break;
>         }
>
> -       /* IRQ processing tested on CougarPoint PCH, ICH5, ICH7-M and ICH10 */
> -       if (dev->device == PCI_DEVICE_ID_INTEL_COUGARPOINT_SMBUS ||
> -           dev->device == PCI_DEVICE_ID_INTEL_82801EB_3 ||
> -           dev->device == PCI_DEVICE_ID_INTEL_ICH7_17 ||
> -           dev->device == PCI_DEVICE_ID_INTEL_ICH8_5 ||
> -           dev->device == PCI_DEVICE_ID_INTEL_ICH9_6 ||
> -           dev->device == PCI_DEVICE_ID_INTEL_ICH10_4 ||
> -           dev->device == PCI_DEVICE_ID_INTEL_ICH10_5)
> -               priv->features |= FEATURE_IRQ;
> -
>         /* Disable features on user request */
>         for (i = 0; i < ARRAY_SIZE(i801_feature_names); i++) {
>                 if (priv->features & disable_features & (1 << i))
>
> --
> Jean Delvare
