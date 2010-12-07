From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of
 interrupts
Date: Mon, 6 Dec 2010 21:14:38 -0800
Message-ID: <20101207051438.GA20144@ericsson.com>
References: <1291617494-18430-1-git-send-email-mattst88@gmail.com>
 <20101206173040.GA18372@ericsson.com>
 <alpine.LFD.2.00.1012061739200.17185@eddie.linux-mips.org>
 <AANLkTikWRsgHao_eb4W47b=E4vm6z=hi36JE_VBtD6Rg@mail.gmail.com>
 <alpine.LFD.2.00.1012070148050.17185@eddie.linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1012070148050.17185-FBDaDh2CBnQu/uO211tRtWD2FQJk+8+b@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Maciej W. Rozycki" <macro-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: Matt Turner <mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org" <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Dec 06, 2010 at 09:26:54PM -0500, Maciej W. Rozycki wrote:
[ ... ]
> 
>  Note that for IRQ support you may have to investigate dependencies in the 
> other two series as the patch (third above) was intended to apply on top 
> of the two series (select the date sort for easier identification of the 
> series).  I'd have to dig into that code for further details and I cannot 
> afford the time right now, sorry.
> 
A quick look through sb1250 vs. sb1480 code shows that the 1480 uses different
interrupt numbers. The patch assigns the sb1250 interrupt numbers, so unless
I am missing something the code as written can not work for sb1480.

Thanks,
Guenter
