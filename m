From: Sven Anders <anders-3bOZC6EutKuELgA04lAiVw@public.gmane.org>
Subject: Re: Need help: Watchdog-driver over smbus (i2c)
Date: Thu, 03 Dec 2009 21:56:59 +0100
Message-ID: <4B18261B.8070507@anduras.de>
References: <4B14395F.4070608@anduras.de> <20091201103120.6ba0f7e0@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080803030707090802090707"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091201103120.6ba0f7e0-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is a multi-part message in MIME format.
--------------080803030707090802090707
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

Jean Delvare schrieb:
> Hallo Sven,
> 
> On Mon, 30 Nov 2009 22:30:07 +0100, Sven Anders wrote:
>
>> Moreover the w83793g hardware sensors driver may already
>> accessing the same chip. What is the normal way to deal with this?
> 
> Do not write a separate driver for the watchdog functionality. Instead,
> add the functionality to the existing hwmon/w83793.c driver. Otherwise
> both features will be mutually exclusive.
> 
> An example of how this can be done is in hwmon/fschmd.c [1] if you want
> to take a look. This is an I2C/SMBus device driver as well, so your code
> should be very similar in the end.
> 
> [1] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=drivers/hwmon/fschmd.c
> 
> Hope this helps,

Yes, thanks! This was the hint I needed.
Now I finished the watchdog driver and it's working!

Regards
 Sven Anders

-- 
 Sven Anders <anders-3bOZC6EutKuELgA04lAiVw@public.gmane.org>                 () Ascii Ribbon Campaign
                                                 /\ Support plain text e-mail
 ANDURAS service solutions AG
 Innstrasse 71 - 94036 Passau - Germany
 Web: www.anduras.de - Tel: +49 (0)851-4 90 50-0 - Fax: +49 (0)851-4 90 50-55

Those who would give up essential Liberty, to purchase a little
temporary Safety, deserve neither Liberty nor Safety.
  - Benjamin Franklin

--------------080803030707090802090707
Content-Type: text/x-vcard; charset=utf-8;
 name="anders.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="anders.vcf"

begin:vcard
fn:Sven Anders
n:Anders;Sven
org:ANDURAS AG;Research and Development
adr;quoted-printable:;;Innstra=C3=9Fe 71;Passau;Bavaria;94036;Germany
email;internet:anders-3bOZC6EutKuELgA04lAiVw@public.gmane.org
title:Dipl. Inf.
tel;work:++49 (0)851 / 490 50 -0
tel;fax:++49 (0)851 / 590 50 - 55
x-mozilla-html:FALSE
url:http://www.anduras.de
version:2.1
end:vcard


--------------080803030707090802090707--
