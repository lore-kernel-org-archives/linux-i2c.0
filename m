From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-dev: Add support for I2C_M_RECV_LEN
Date: Sat, 7 Apr 2012 18:00:24 +0200
Message-ID: <20120407180024.0d9e295e@endymion.delvare>
References: <20120315180835.2e669111@endymion.delvare>
	<20120331081927.2438ea9e@endymion.delvare>
	<4F7CD11C.2090801@interlog.com>
	<20120405092422.453edecf@endymion.delvare>
	<4F7E3267.9040306@interlog.com>
	<20120406083751.46fd23c5@endymion.delvare>
	<4F7F16D3.6080307@interlog.com>
	<20120406182534.68d7f53d@endymion.delvare>
	<4F7F2220.50003@interlog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F7F2220.50003-qazKcTl6WRFWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dgilbert-qazKcTl6WRFWk0Htik3J/w@public.gmane.org
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 06 Apr 2012 13:04:32 -0400, Douglas Gilbert wrote:
> So I have now applied your patch over my patch to the i2c-at91
> driver and tested it. The result is the same as the previous
> iteration: only two non-zero bytes: "08 81".

Bah. I already spent more time on this than I wanted, and it seems I am
going nowhere, due to the lack of hardware to test my changes. Are you
willing to debug my code and fix it?

-- 
Jean Delvare
