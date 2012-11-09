From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: at91: fix SMBus quick command
Date: Fri, 9 Nov 2012 20:53:40 +0100
Message-ID: <20121109205340.28e5772f@endymion.delvare>
References: <1352481797-3520-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352481797-3520-1-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, N.Voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 9 Nov 2012 18:23:17 +0100, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org wrote:
> I tested it with i2cdetect as you suggested. EEPROMs were detected but not
> other devices (lm75 and ds1337). I have exactly the same behavior by using
> i2c-gpio driver so I think there is no major issue on a driver point of view.

Note that i2cdetect uses a different probe command for EEPROM addresses
(0x50-0x57) than for other addresses by default. You can change this
default behavior with -q and -r for testing purposes.

-- 
Jean Delvare
