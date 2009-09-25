From: Jon Ringle <jon-7zJyie9iPacdnm+yROfE0A@public.gmane.org>
Subject: Re: [rtc-linux] Re: i2c/rtc init dependency problem
Date: Fri, 25 Sep 2009 16:19:01 -0400
Message-ID: <152584230909251319i13d64d6by3cde9c32cd15879f@mail.gmail.com>
References: <152584230909240758h674ffe3cw4d5e6baef5efc9b8@mail.gmail.com>
	 <20090924151953.GD3154@pengutronix.de>
	 <8b192c78-6ebf-42ec-b334-756f56cc5400@g6g2000vbr.googlegroups.com>
	 <20090925065843.GA4125@pengutronix.de>
	 <152584230909250749w305b5202tba55bfedd742fea9@mail.gmail.com>
	 <152584230909251138r7051a279k71e10ac778e28742@mail.gmail.com>
	 <20090925204533.69681f35@hyperion.delvare>
	 <152584230909251213l8f9663eo39151206e9ec8cd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <152584230909251213l8f9663eo39151206e9ec8cd4-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Alexander Bigga <ab-g5CePrrZ5ROELgA04lAiVw@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Sep 25, 2009 at 3:13 PM, Jon Ringle <jon-7zJyie9iPacdnm+yROfE0A@public.gmane.org> wrote:
> Can you point me to an example of how one declares a i2c device?

I discovered i2c_register_board_info and friends, which I think is
what I'm looking for...

Jon
