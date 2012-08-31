From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 8/8] ARM: dts: add twi nodes for atmel boards
Date: Fri, 31 Aug 2012 17:07:10 +0200
Message-ID: <5040D31E.8040306@atmel.com>
References: <1346404884-18451-1-git-send-email-ludovic.desroches@atmel.com> <1346405096-18660-1-git-send-email-ludovic.desroches@atmel.com> <20120831144228.GC23867@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120831144228.GC23867-RQcB7r2h9QmfDR2tN2SG5Ni2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Cc: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 08/31/2012 04:42 PM, Jean-Christophe PLAGNIOL-VILLARD :
> On 11:24 Fri 31 Aug     , ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org wrote:
>> From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>>
>> Use the atmel twi instead of gpio for i2c stuff.
> NACK as you do not update al the platform at the same time and break the Calao

Yes, Ludovic shall keep i2c-gpio at the side of the new twi driver.

But for the platform, the platform maintainer will have to choose the
one or the other.

Bye,
-- 
Nicolas Ferre
