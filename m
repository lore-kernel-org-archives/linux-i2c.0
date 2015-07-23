From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH v2] hwmon: ads7828: Add devicetree documentation
Date: Thu, 23 Jul 2015 09:07:42 -0700
Message-ID: <55B1114E.7090207@roeck-us.net>
References: <1437645827-13115-1-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437645827-13115-1-git-send-email-denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: =?windows-1252?Q?Eric_B=E9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 07/23/2015 03:03 AM, Denis Carikli wrote:
> This adds devicetree documentation for the bindings of the
> ads7828 driver.
>
This is really not relevant here; what you are adding is bindings
for ADS7828 and ASDS7830 to the list of trivial devices.

> Signed-off-by: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
> Acked-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>

Subject tag should probably have been "DT: i2c:", similar
to other patches for the same file. Something like

"DT: i2c: Add ADS7828 and ADS7830 to list of trivial devices"

Guenter

> ---
> ChangeLog v1->v2:
> - Added a commit message.
> ---
>   Documentation/devicetree/bindings/i2c/trivial-devices.txt | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index 00f8652..d77d412 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -95,6 +95,8 @@ stm,m41t00		Serial Access TIMEKEEPER
>   stm,m41t62		Serial real-time clock (RTC) with alarm
>   stm,m41t80		M41T80 - SERIAL ACCESS RTC WITH ALARMS
>   taos,tsl2550		Ambient Light Sensor with SMBUS/Two Wire Serial Interface
> +ti,ads7828		8-Channels, 12-bit ADC
> +ti,ads7830		8-Channels, 8-bit ADC
>   ti,tsc2003		I2C Touch-Screen Controller
>   ti,tmp102		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
>   ti,tmp103		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
>
