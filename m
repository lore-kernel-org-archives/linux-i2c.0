From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 7/8] ARM: dts: add twi nodes for atmel SOCs
Date: Fri, 31 Aug 2012 16:56:20 +0200
Message-ID: <5040D094.3060306@atmel.com>
References: <1346404884-18451-1-git-send-email-ludovic.desroches@atmel.com> <1346405077-18620-1-git-send-email-ludovic.desroches@atmel.com> <20120831144105.GB23867@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120831144105.GB23867-RQcB7r2h9QmfDR2tN2SG5Ni2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Cc: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 08/31/2012 04:41 PM, Jean-Christophe PLAGNIOL-VILLARD :
> On 11:24 Fri 31 Aug     , ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org wrote:
>> From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>>
>> Add twi nodes for atmel SOCs and remove i2c-gpio ones.
> Only drop the i2c-gpio on the soc that are kn own to have no issue on the hw
> IP. For hte onther one keep both in the dtsi

Yes, I agree with this.

Bye,
-- 
Nicolas Ferre
