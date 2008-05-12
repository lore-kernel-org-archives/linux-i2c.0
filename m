From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: New style i2c drivers for ALSA SoC
Date: Mon, 12 May 2008 22:15:30 +0100
Message-ID: <20080512211530.GC10234@fluff.org.uk>
References: <482795E7.9040007@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
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

On Mon, May 12, 2008 at 12:57:11PM +1200, Ryan Mallon wrote:
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

I belive that you need a bit of glue to bind your SoC system
to the codec and audio hardware. ASoC is littered with a number
of examples of how to do it.

> Finally, a stylistic question: Should the i2c_board_info (or similar)
> for a codec device be defined in the machine initialisation code
> (arch/arm/ directory), or in the sound/soc machine file?

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
