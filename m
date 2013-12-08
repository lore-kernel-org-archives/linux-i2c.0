From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [lm-sensors] [PATCH 1/3] dt: Add adt7411 to trivial devices list
Date: Sun, 08 Dec 2013 13:44:28 -0800
Message-ID: <52A4E83C.3000407@roeck-us.net>
References: <1386536538-14861-1-git-send-email-bgamari.foss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1386536538-14861-1-git-send-email-bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 12/08/2013 01:02 PM, Ben Gamari wrote:
> Signed-off-by: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>   Documentation/devicetree/bindings/i2c/trivial-devices.txt | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index b1cb341..9c3a684 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -9,6 +9,7 @@ document for it just like any other devices.
>
>   Compatible		Vendor / Chip
>   ==========		=============
> +ad,adt7411		I2C Digital 8-channel 10-bit ADC and temperature sensor
>   ad,ad7414		SMBus/I2C Digital Temperature Sensor in 6-Pin SOT with SMBus Alert and Over Temperature Pin
>   ad,adm9240		ADM9240:  Complete System Hardware Monitor for uProcessor-Based Systems
>   adi,adt7461		+/-1C TDM Extended Temp Range I.C
>

You should also copy the i2c mailing list (linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org)
It is ok to copy lm-sensors, but the patches will have to be reviewed
and applied through the other lists (or at least I think so).

Note that "ad" is the vendor prefix for "Avionic Design GmbH".
You might want to use "adi" instead.

Thanks,
Guenter
