From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c adapter scan device issue
Date: Wed, 25 Nov 2009 09:53:31 +0100
Message-ID: <20091125095331.5cbdbae6@hyperion.delvare>
References: <4B0CAFFD.7030603@freescale.com>
	<20091125091218.518d47af@hyperion.delvare>
	<4B0CEDDA.2000909@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B0CEDDA.2000909-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lanttor <lanttor.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 25 Nov 2009 16:42:02 +0800, Lanttor wrote:
> >
> > Yes, you are correct. You can't predefine I2C devices with
> > i2c_register_board_info() if you don't also set I2C adapter numbers
> > with i2c_add_numbered_adapter(). Trying would be equivalent to sending a
> > letter to someone when you know the city and street number but not the
> > street name: unlikely to succeed.
> >   
> Thanks Jean.
> 
> In fact my bus driver used i2c_add_adapter() not i2c_add_numbered_adapter().
> Now I use i2c_add_numbered_adapter() to replace 2c_add_adapter() and set
> the bus number first.
> 
> In one word, you mean that i2c_add_adapter() can not work normally if
> useing i2c_register_board_info() to pre-declare the i2c device, right?

Yes, exactly.

> I really need track i2c-stack in detail.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
