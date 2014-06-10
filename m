From: Paul Carpenter <paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org>
Subject: Re: [RESEND2 PATCH v4 2/2] i2c: sunxi: add P2WI (Push/Pull 2 Wire
 Interface) controller support
Date: Tue, 10 Jun 2014 09:56:40 +0100
Message-ID: <5396C848.8020701@pcserviceselectronics.co.uk>
References: <1401785392-26602-1-git-send-email-boris.brezillon@free-electrons.com> <1401785392-26602-3-git-send-email-boris.brezillon@free-electrons.com> <20140610083850.GB2620@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140610083850.GB2620@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Shuge <shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org>, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang wrote:
> On Tue, Jun 03, 2014 at 10:49:52AM +0200, Boris BREZILLON wrote:
>> The P2WI looks like an SMBus controller which only supports byte data
>> transfers. But, it differs from standard SMBus protocol on several
>> aspects:
>> - it supports only one slave device, and thus drop the address field
>> - it adds a parity bit every 8bits of data
>> - only one read access is required to read a byte (instead of a read
>>   followed by a write access in standard SMBus protocol)

Minor quibble should be
"(instead of a write followed by a read access in standard SMBus
   protocol)"

That being similar to EEPROM and other types of devices write internal
address followed by read access from internal address.

>> - there's no Ack bit after each byte transfer
>>
>> This means this bus cannot be used to interface with standard SMBus
>> devices (the only known device to support this interface is the AXP221
>> PMIC).
> 
> Good description. Should be a comment at the top of the driver to spread
> the word.

-- 
Paul Carpenter          | paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org
<http://www.pcserviceselectronics.co.uk/>    PC Services
<http://www.pcserviceselectronics.co.uk/pi/>  Raspberry Pi Add-ons
<http://www.pcserviceselectronics.co.uk/fonts/> Timing Diagram Font
<http://www.badweb.org.uk/> For those web sites you hate
