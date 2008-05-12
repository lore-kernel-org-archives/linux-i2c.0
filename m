From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: New style i2c drivers for ALSA SoC
Date: Mon, 12 May 2008 08:20:25 +0200
Message-ID: <20080512082025.01e5d0c0@hyperion.delvare>
References: <482795E7.9040007@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <482795E7.9040007-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Ryan Mallon <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ryan,

On Mon, 12 May 2008 12:57:11 +1200, Ryan Mallon wrote:
> I am writing drivers to support ALSA SoC for an ARM based system. The
> system has an i2c codec. I want to use the new style driver for the
> codec driver, but I cannot get it to work properly. In my codec driver
> (sound/soc/codecs/tlv320aic2x.c) I have:
> 
> static struct i2c_driver aic2x_i2c_driver = {
> 	.driver		= {
> 		.name	= "tlv320aic2x",
> 		.owner	= THIS_MODULE,
> 	},
> 	.probe		= aic2x_i2c_probe,
> 	.remove		= aic2x_i2c_remove,
> };
> 
> static int __init aic2x_init(void)
> {
> 	return i2c_add_driver(&aic2x_i2c_driver);
> }
> 
> static void __exit aic2x_exit(void)
> {
> 	i2c_del_driver(&aic2x_i2c_driver);
> }
> 
> module_init(aic2x_init);
> module_exit(aic2x_exit);
> 
> Putting i2c_register_board_info either in my machine file in the
> arch/arm/ directory, or the machine file in the sound/soc/ directory
> does not seem to work. The driver does correctly register, ie I see the
> following in dmesg (although much later than the other i2c drivers):
> 
> i2c-core: driver [tlv320aic2x] registered
> 
> But its probe function is never called. The other i2c codec drivers in
> the sound/soc/codecs directory are all using the legacy i2c driver model.

What data are you passing to i2c_register_board_info?

Since 2.6.26-rc1, you can and should provide a list of devices
supported by your driver. Your driver definition would look like:

static const struct i2c_device_id aic2x_i2c_id[] = {
	{ "tlv320aic2x", 0 },
	{ }
};
MODULE_DEVICE_TABLE(i2c, aic2x_i2c_id);

static struct i2c_driver aic2x_i2c_driver = {
	.driver		= {
		.name	= "tlv320aic2x",
		.owner	= THIS_MODULE,
	},
	.probe		= aic2x_i2c_probe,
	.remove		= aic2x_i2c_remove,
	.id_table	= aic2x_i2c_id,
};

Also note that there's already a driver in the kernel tree
(drivers/media/video/tlv320aic23b.c) for apparently the same hardware,
so maybe there's some code to share.

> I also looked at the i2c_new_device function. I'm not sure if this is
> what I want, but I don't know where to get the adapter structure to pass
> to it. The other drivers I found which use this function are creating
> their own i2c adapter (usually bit-bashed) for talking to the i2c
> device, which is not what I want to do.

i2c_new_device() is meant to instantiate I2C devices at run-time. It is
mostly useful for TV adapters and similar where you don't know in
advance if it will be there and what i2c bus number it will receive.
For embedded designs where you know exactly which devices you have at
build time, i2c_register_board_info() is the way to go.

> Finally, a stylistic question: Should the i2c_board_info (or similar)
> for a codec device be defined in the machine initialisation code
> (arch/arm/ directory), or in the sound/soc machine file?

Machine initialization code.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
