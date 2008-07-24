From: "Felipe Balbi" <felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: New Style I2C Driver : how to get clients ?
Date: Thu, 24 Jul 2008 16:16:26 +0300
Message-ID: <31e679430807240616n4bed86c7sa5c5ce69e066d0b5@mail.gmail.com>
References: <1216903949.48887b0dd2039@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1216903949.48887b0dd2039-HZaT1/I6gcdWj0EZb7rXcA@public.gmane.org>
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
To: fuhz-GANU6spQydw@public.gmane.org
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On Thu, Jul 24, 2008 at 3:52 PM,  <fuhz-GANU6spQydw@public.gmane.org> wrote:
> So, I added the register_board_info in my board init function.
> I fill the i2c_board_info structure with the macro I2C_BOARD_INFO.
> I define a few clients.

hmm... ok

>
> And so what ?
>
> The system is supposed to call the probe(client) of the driver ?

yes, if you have the proper struct i2c_driver and struct i2c_device_id in
your driver the i2c subsystem should call the probe of your device.

check drivers/i2c/chips/menelaus.c for an example.

See how I2C_BOARD_INFO() in arch/arm/mach-omap2/board-h4
and struct i2c_device_id have the same name for the device (menelaus).

> I am really lost. I did not anderstand how to get a valid client instance.
> I suppose the I2C layer says "Hey boy, you have a new client !", but when ?

no, i2c layer will call device probe based on the driver name being the same in
i2c_board_info and i2c_device_id (if I'm not wrong that's the match,
Jean correct
me if I'm wrong).

> What about 'static unsigned short probe[2] = { I2C_CLIENT_END, I2C_CLIENT_END
> };'.
> Can it help me ?

That's old style i2c driver. You don't need that anymore ;-)

-- 
Best Regards,

Felipe Balbi
felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
