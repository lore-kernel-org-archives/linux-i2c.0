From: ROASCIO Paolo <roa-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org>
Subject: Re: PCA954x I2C switch/multiplexer
Date: Fri, 29 Feb 2008 20:07:06 +0100
Message-ID: <200802292007.06309.roa@libero.it>
References: <200802231707.01967.roa@libero.it>
	<A42C17A8FF150C4DB98BFD6497D1D000081DF898@ussvlexmbpf1.spansion.com>
	<20080225090237.200b5b88@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080225090237.200b5b88-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Il Monday 25 February 2008 09:02:37 hai scritto:
> Hi Frank,
>
> On Sun, 24 Feb 2008 21:41:54 -0800, Edelhaeuser, Frank wrote:
> > The driver I submitted implements the "new style" driver model. These
> > driver's don't probe the bus automatically. Instead, devices must be
> > instantiated by calling i2c_register_board_info() for each multiplexer
> > device. Please note that this driver implements a special syntax for the
> > type field: e.g. .type = "pxa9544,5" tells the driver to create 4
> > virtual i2c buses with ids 5, 6, 7 and 8. You would
> > i2c_register_board_info() your PXA9544 multiplexer with the root i2c bus
> > and your bus segment devices with those virtual i2c buses.
>
> Please don't abuse the type field, instead define a custom structure
> and pass it to the driver as platform data. This will give you much
> more flexibility as well.

Hello, thanks for your answers

Well, i googled this days to learn something about the 
i2c_register_board_info() and the platform data structures. This requires a 
good knowledge of programming as i haven't :(

I understood that pca9540 (in my case) definitions have to be hardcoded 
somewhere (the only thread i found about this regards a SIP device 
registration on arm platform), but, where? and these needs to be coded as 
a "C" struct (the "type" field is part of this struct?)?

Well, i think i'm not enough skinned to manage this driver, peraph a whish: 
will be implemented something like a modprobe option to make this driver more 
user friendly?

Please feel free to point me to adequate documentation about the platform data 
structure, in the meanwhile i continue googling...

 
Roascio paolo

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
