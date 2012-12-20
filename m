From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PULL REQUEST] i2c-embedded for 3.8
Date: Thu, 20 Dec 2012 16:51:50 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212201650430.28579@utopia.booyaka.com>
References: <20121218234150.GA32374@pengutronix.de> <CA+55aFyV5ROO-Zy4UxhXx0Lu6biyBzmrre=NY1x0yx7tK+Lz8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CA+55aFyV5ROO-Zy4UxhXx0Lu6biyBzmrre=NY1x0yx7tK+Lz8g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 18 Dec 2012, Linus Torvalds wrote:

> But quite frankly, the thing is ugly as heck, and I hope it could just 
> be deleted.

With luck we'll be able to get rid of it in 3.9, once the underlying issue 
with the I2C driver is tracked down.

- Paul
