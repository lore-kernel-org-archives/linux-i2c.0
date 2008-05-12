From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: New style i2c drivers for ALSA SoC
Date: Mon, 12 May 2008 23:05:25 +0200
Message-ID: <20080512230525.0d3952bd@hyperion.delvare>
References: <482795E7.9040007@bluewatersys.com>
	<20080512082025.01e5d0c0@hyperion.delvare>
	<4828AE22.2030705@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <4828AE22.2030705-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>
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

On Tue, 13 May 2008 08:52:50 +1200, Ryan Mallon wrote:
> Jean Delvare wrote:
> > Since 2.6.26-rc1, you can and should provide a list of devices
> > supported by your driver. Your driver definition would look like:
> > 
> > static const struct i2c_device_id aic2x_i2c_id[] = {
> > 	{ "tlv320aic2x", 0 },
> > 	{ }
> > };
> > MODULE_DEVICE_TABLE(i2c, aic2x_i2c_id);
> 
> Done. I had thought this was option if a driver only supported a single
> device?

It is optional up to and including 2.6.26-rc2, but hopefully I'll be
done with the cleanups for 2.6.26-rc3 and using .id_table will be the
only way for a driver to match its devices.

> 
> > static struct i2c_driver aic2x_i2c_driver = {
> > 	.driver		= {
> > 		.name	= "tlv320aic2x",
> > 		.owner	= THIS_MODULE,
> > 	},
> > 	.probe		= aic2x_i2c_probe,
> > 	.remove		= aic2x_i2c_remove,
> > 	.id_table	= aic2x_i2c_id,
> > };
> > 
> > Also note that there's already a driver in the kernel tree
> > (drivers/media/video/tlv320aic23b.c) for apparently the same hardware,
> > so maybe there's some code to share.
> 
> Yes. The tlv320aic23b is both an audio codec and a video decoder of some
> sort. We only use the audio codec part on our particular board. The
> driver under drivers/media/video is pretty minimal, and appears that it
> may have been hard coded for a particular graphics card that it appears
> on? The driver I have for the audio codec is already substantially
> larger. There is also the problem that the soc codec stuff should live
> under sound/soc/codecs and video decoders should live under
> drivers/media/video. Assuming I post patches for my work at some stage
> (which I intend to do), perhaps it is easier to have two drivers to
> start with, and then merge them if people have hardware which is using
> both the audio and video codec functionality?

I don't know what it the best approach myself. I just wanted you to be
aware that this other driver existed.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
