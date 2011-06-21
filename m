From: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Need to use a I2C EEPROM on normal x86 architecture
Date: Tue, 21 Jun 2011 13:54:52 +0200
Message-ID: <BANLkTimfbe4ntzzTu0SXJothK1N56m1ghA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi community,

I am working on an embedded x86 device, which has an at24 based
eeprom. I am using
the i2c_eg20t driver to access the i2c bus. To be able to access the
eeprom in a separated
driver I did this:

/* technical description of our used EEPROM */
static struct at24_platform_data custom_i2c_eeprom_info = {
	.byte_len	= EEPROM_BYTE_LEN,
	.page_size	= 16,
	.flags		= 0,
	.setup		= content_read,
	.context	= NULL,
};

/* EEPROM at24 */
static struct i2c_board_info __initdata i2c_info[] =  {
	{
		I2C_BOARD_INFO("24c04", 0x50),
		.platform_data	= &custom_i2c_eeprom_info,
	},
};

In the init function of my custom driver I do this:

	/* register known devices on i2c bus */
	status = i2c_register_board_info(0, i2c_info, ARRAY_SIZE(i2c_info))

Now I run in some troubles... see
http://www.spinics.net/lists/linux-i2c/msg02022.html

What options do I have to get this running? I could use
i2c_add_numbered_adapter, but I don''t
want to touch too much from mainline kernel sources.

Thanks
--
Christian Gmeiner, MSc
