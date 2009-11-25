From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c adapter scan device issue
Date: Wed, 25 Nov 2009 09:12:18 +0100
Message-ID: <20091125091218.518d47af@hyperion.delvare>
References: <4B0CAFFD.7030603@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B0CAFFD.7030603-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lanttor <lanttor.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 25 Nov 2009 12:18:05 +0800, Lanttor wrote:
> Hi,
> 
> I have a confused problem as follows:
> 
> I instantiate a i2c device with function i2c_register_board_info();
> This function pre-declare the I2C devices which live on this bus and the
> call of it
> is before the real i2c bus driver loaded.
> 
> In i2c_register_board_info(),
> __i2c_first_dynamic_bus_num = busnum +1;
> 
> My i2c bus driver use i2c_add_adapter() to register adapter, In
> i2c_add_adapter(),
> res = idr_get_new_above(&i2c_adapter_idr, adapter,
>                                 __i2c_first_dynamic_bus_num , &id);
> 
> adapter->nr = id;
> 
> That means if I pass busnum 0 to i2c_register_board_info(), but my i2c
> adapter will get
> busnum 1 and so it can't scan pre-declared i2c devices.
> In fact, I only have one i2c adapter.
> 
> It seems I can't use i2c_add_adapter(), instead of using
> i2c_add_numbered_adapter, right?

Yes, you are correct. You can't predefine I2C devices with
i2c_register_board_info() if you don't also set I2C adapter numbers
with i2c_add_numbered_adapter(). Trying would be equivalent to sending a
letter to someone when you know the city and street number but not the
street name: unlikely to succeed.

-- 
Jean Delvare
