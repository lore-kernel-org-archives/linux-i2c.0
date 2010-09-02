From: Colin Cross <ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] [ARM] tegra: Add i2c support
Date: Thu, 2 Sep 2010 15:07:46 -0700
Message-ID: <AANLkTikxPMY-5Kf2oSAmpZhMjoT6gd_FuiGnWpgR=mpg@mail.gmail.com>
References: <1280450180-25016-1-git-send-email-ccross@google.com>
	<4C52C766.7040709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C52C766.7040709-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jul 30, 2010 at 5:36 AM, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org> wrote:
> On 07/30/2010 06:06 AM, Colin Cross wrote:
>>
>> +/* i2c_writel and i2c_readl will offset the register if necessary t=
o talk
>> + * to the I2C block inside the DVC block
>> + */
>
> Minor coding-style comment. Documentation/CodingStyle says the prefer=
red
> format for multi-line comments is to do:
>
> /*
> =A0* i2c_writel and i2c_readl ...
> =A0* to the I2C block ...
> =A0*/
Done
